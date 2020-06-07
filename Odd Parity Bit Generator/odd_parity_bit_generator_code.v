// Verilog model of circuit of Odd parity bit generator.
// written by Asadullah Jamalov 14.04.2020
module odd_parity (A0, A1, A2, A3, A4, A5, A6, A7, Z);
  	input A0, A1, A2, A3, A4, A5, A6, A7;
  	output Z;
  
  	wire w1, w2, w3, w4, w5, w6, w7;
 	xor G1 (w1, A0, A1); 
  	xor G2 (w2, A2, A3);
  	xor G3 (w3, A4, A5);
  	xor G4 (w4, A6, A7);
	xor G5 (w5, w1, w2);
  	xor G6 (w6, w3, w4);
  	xor G7 (w7, w5, w6);
  	not G8 (Z, w7);
endmodule

module testbench;

  	reg A0, A1, A2, A3, A4, A5, A6, A7;
  	wire Z;
  	odd_parity test(A0, A1, A2, A3, A4, A5, A6, A7, Z);
  
  	initial 
		begin
   			    A0=1'b0;A1=1'b0;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;
   			#10 A0=1'b1;A1=1'b0;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;
   			#10 A0=1'b1;A1=1'b1;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;
			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b1;A5=1'b0;A6=1'b0;A7=1'b0;
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b1;A5=1'b1;A6=1'b0;A7=1'b0;
 		end
  
endmodule
