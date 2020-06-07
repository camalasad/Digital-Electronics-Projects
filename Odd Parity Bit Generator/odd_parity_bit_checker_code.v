// Verilog model of circuit of 8 bit Odd Parity Checker.
// if everything is ok, output C will be "0"
// if there is an error, output C will be "1"
// written by Asadullah Jamalov 14.04.2020
module odd_parity_checker (A0, A1, A2, A3, A4, A5, A6, A7, P, C);
  	input A0, A1, A2, A3, A4, A5, A6, A7, P;  // 8 bit information and 1 odd parity bit
  	output C;				   
  
  	wire w1, w2, w3, w4, w5, w6, w7, w8;
 	xor G1 (w1, A0, A1); 
  	xor G2 (w2, A2, A3);
  	xor G3 (w3, A4, A5);
  	xor G4 (w4, A6, A7);
	xor G5 (w5, w1, w2);
  	xor G6 (w6, w3, w4);
  	xor G7 (w7, w5, w6);
  	not G8 (w8, w7);
	xor G9 (C, w8, P);
endmodule

module testbench;

  	reg A0, A1, A2, A3, A4, A5, A6, A7, P;
  	wire C;
  	odd_parity_checker test(A0, A1, A2, A3, A4, A5, A6, A7, P, C);
  
  	initial 
		begin
   			    A0=1'b0;A1=1'b0;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b1; //ok
   			#10 A0=1'b1;A1=1'b0;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b0; //ok
   			#10 A0=1'b1;A1=1'b1;A2=1'b0;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b1; //ok
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b0; //ok
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b1; //ok
			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b1;A5=1'b0;A6=1'b0;A7=1'b0;P=1'b0; //error
    			#10 A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b1;A4=1'b1;A5=1'b1;A6=1'b0;A7=1'b0;P=1'b0; //error
 		end
  
endmodule
