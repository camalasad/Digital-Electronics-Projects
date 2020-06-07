// Verilog model of D Flip-Flop (without Reset)
// written by Asadullah Jamalov 25.04.2020
module d_flip_flop (out, in, clk);
  	input in, clk;  
  	output reg out;				   

  	always @( posedge clk)
		out <= in;

endmodule


module testbench;
 	
	reg in, clk;
	wire out;

 	d_flip_flop test (out, in, clk);
 
	initial 
		begin
 			clk=0;
    			forever #10 clk = ~clk;  
		end 

	initial 
		begin 
 		     	     in <= 0;
 			#100 in <= 1;
 			#100 in <= 0;
 			#100 in <= 1;
		end 
endmodule 
