module tanh(x , tanh , clk ,cosh , sinh );

parameter n = 32; //1 bit for sign , 15 bit for integer , 16 bit for decimal


input clk;
input [n-1:0] x;
output [n-1:0] tanh;
output [n-1:0] cosh;
output [n-1:0] sinh;
reg ready = 1;

reg [n-1:0] arctanh_neg [0:3];// ROM for saving different values of arctanh for negative iteration
reg [n-1:0] arctanh [0:15];// ROM for saving different values of arctanh

always @(posedge clk)begin
	if(ready)begin
			arctanh_neg[0] = 32'h00021252;
			arctanh_neg[1] = 32'h0001b78c;
			arctanh_neg[2] = 32'h00015aa1;
			arctanh_neg[3] = 32'h0000f913;
			arctanh[0]= 32'h00008c9f;// 0.549301,1/2,tanh  
			arctanh[1]= 32'h00004162;//0.255416870117188,1/4  
			arctanh[2]= 32'h0000202b;//0.125656127929688,1/8  
			arctanh[3]= 32'h00001005;//0.062582,1/16  
			arctanh[4]= 32'h00000800;// 0.031265258789063  
			arctanh[5]= 32'h00000400;// 0.015625
			arctanh[6]= 32'h00000200;//0.015626，1/128  
			arctanh[7]= 32'h00000100;//0.007813，1/256  
			arctanh[8]= 32'h00000080;//0.003906250，1/512  
			arctanh[9]= 32'h00000040;//0.001953125，1/1024  
			arctanh[10]=32'h00000020;//0.0009765625，1/2048 
			arctanh[11]=32'h00000010;//0.00048828125，1/4096 
			arctanh[12]=32'h00000008;//1/8192
			arctanh[13]=32'h00000004;
			arctanh[14]=32'h00000002;
			arctanh[15]=32'h00000001;
			end
end

reg signed[n-1:0] reg_x [0:20];
reg signed[n-1:0] reg_y [0:20];
reg signed[n-1:0] reg_z [0:20];
wire [n-1:0] tanh_final;
reg sign_z;
reg sign_y;
integer i,j;


//assign tanh = tanh_final;
div my_div(reg_x[20] , reg_y[20] , tanh) ;
assign cosh =  reg_x[20] ;
assign sinh = reg_y[20] ;

always @(posedge clk)
begin

	if(ready)begin
		reg_x[0] = 32'h002b9a37;//（43.602) ====> x0 = 1/An
		reg_y[0] = 0;
		reg_z[0] = x;
		ready = 0;
	end
	else	begin
		for(i= 1 ; i <= 4 ; i = i+1) begin // for negative iteration
			sign_z = reg_z[i-1][n-1];
			if(sign_z) begin	// d = -1 because Z<0
				reg_x[i] = $signed(reg_x[i-1]) - $signed(reg_y[i-1]) + $signed(reg_y[i-1]>>>(6-i));
				reg_y[i] = $signed(reg_y[i-1]) - $signed(reg_x[i-1]) + $signed(reg_x[i-1]>>>(6-i));
				reg_z[i] = $signed(reg_z[i-1]) + $signed(arctanh_neg[i-1]);
			end
			
			else begin // d = 1 because Z>0
				reg_x[i] = $signed(reg_x[i-1]) + $signed(reg_y[i-1]) - $signed(reg_y[i-1]>>>(6-i));
				reg_y[i] = $signed(reg_y[i-1]) + $signed(reg_x[i-1]) - $signed(reg_x[i-1]>>>(6-i));
				reg_z[i] = $signed(reg_z[i-1]) - $signed(arctanh_neg[i-1]);
			end
		end
		for(i= 1 ; i <= 16 ; i = i+1) begin // for positive iteration
			sign_z = reg_z[i+4-1][n-1];
			if(sign_z) begin	// d = -1 because Z<0
				reg_x[i+4] = $signed(reg_x[i+4-1]) - $signed(reg_y[i+4-1]>>>i);
				reg_y[i+4] = $signed(reg_y[i+4-1]) - $signed(reg_x[i+4-1]>>>i);
				reg_z[i+4] = $signed(reg_z[i+4-1]) + $signed(arctanh[i-1]);
			end
			
			else begin // d = 1 because Z>0
				reg_x[i+4] = $signed(reg_x[i+4-1]) + $signed(reg_y[i+4-1]>>>i);
				reg_y[i+4] = $signed(reg_y[i+4-1]) + $signed(reg_x[i+4-1]>>>i);
				reg_z[i+4] = $signed(reg_z[i+4-1]) - $signed(arctanh[i-1]);
			end
		end
		ready = (i>=11) ? 1 : 0;
	end
		
end 

endmodule


module div(x , y , out);
parameter n = 32;
input [n-1:0]x;
input [n-1:0]y;
output reg[n-1:0]out;

reg [n-1:0] reg_x_divide [0:24];
reg [n-1:0] reg_y_divide [0:24];
reg [n-1:0] reg_z_divide [0:24];
reg sign_y;
reg [n-1:0]d = 32'h00010000;
integer j;
always @(reg_x_divide , reg_y_divide , reg_z_divide , x , y , d)begin
reg_x_divide[0] = x;
reg_y_divide[0] = y;
reg_z_divide[0] = 0;
for(j= 1 ; j <= 24 ; j = j+1) begin
			sign_y = reg_y_divide[j-1][n-1];
			if(sign_y) begin	// d = 1 because Y<0
				reg_x_divide[j] = reg_x_divide[j-1];
				reg_y_divide[j] = reg_y_divide[j-1] + (reg_x_divide[j-1]>>(j));
				reg_z_divide[j] = reg_z_divide[j-1] - (d>>j);
			end
			else begin // d = -1 because Y>0
				reg_x_divide[j] = reg_x_divide[j-1] ;
				reg_y_divide[j] = reg_y_divide[j-1] - (reg_x_divide[j-1]>>(j));
				reg_z_divide[j] = reg_z_divide[j-1] + (d>>j);
			end
end
out = reg_z_divide[24];
end
endmodule