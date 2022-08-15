
`timescale 1ns/1ns

module tanh__tb();

   integer i, j;

   reg [31:0] a , b,  data[0:203];
   wire [31:0]  y , x;
   wire [31:0]  z , m , n;
   reg Clk = 0;
   always
   Clk = #1 ~Clk;

   initial begin


      $readmemh("matlab_data.hex", data);

      if(data[0] === 'bx) begin
         $display("ERROR: fp.hex file is not read in properly");
         $display("Make sure this file is located in working directory");
         $stop;
      end

      for(i=0; i<51; i=i+1) begin
         a = data[2*i][31:4];
		 b = data[2*i+1];
		 #50
	if(uut.tanh[31:4] !== a) begin
		$write("\tError: tanh_verilog: %8x  \t tanh_matlab:%8x, \t %8x\n", uut.tanh[31:4] , a , sst.out[31:4]) ;
	end
	else
		$write("\tOK \t tanh(%8x) = %8x\n", b ,uut.tanh[31:4] );
      end

	$stop;
   end

   tanh uut( .x(b), .tanh(n) , .clk(Clk) , .cosh(x), .sinh(y) ); 
   div sst(.x(x) , .y(y) , .out());
   
endmodule
