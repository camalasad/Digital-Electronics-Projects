// Verilog model of 8-bit Magnitude Comparator circuit 
// which is used to compare 2-byte input data
// I cascaded two 4-bit comparator to obtain 8-bit comparator
// 1st IC will compare 4 LSBs
// 2nd IC will compare 4 MSBs
// written by Asadullah Jamalov 17.04.2020
module comparator (A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, A_greater, B_greater, A_equal_B);
  	input A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7;  // 2 byte information 
  	output A_greater, B_greater, A_equal_B;				   
  
  	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26;
	wire A_equal_B_1, A_greater_1, B_greater_1, A_equal_B_2, A_greater_2, B_greater_2;

// Creating hat versions of every input
	not g1 (A0_hat, A0);
	not g2 (A1_hat, A1);
	not g3 (A2_hat, A2);
	not g4 (A3_hat, A3);
	not g5 (A4_hat, A4);
	not g6 (A5_hat, A5);
	not g7 (A6_hat, A6);
	not g8 (A7_hat, A7);

	not g9 (B0_hat, B0);
	not g10 (B1_hat, B1);
	not g11 (B2_hat, B2);
	not g12 (B3_hat, B3);
	not g13 (B4_hat, B4);
	not g14 (B5_hat, B5);
	not g15 (B6_hat, B6);
	not g16 (B7_hat, B7);

// 1st IC
 	xnor G1 (w1, A0, B0); 
  	xnor G2 (w2, A1, B1);
  	xnor G3 (w3, A2, B2);
	xnor G4 (w4, A3, B3);
  	and G5 (A_equal_B_1, w1, w2, w3, w4); // result of 1st IC for A_equal_B

	and G6 (w5, A3, B3_hat);
	and G7 (w6, A2, B2_hat, w4);
	and G8 (w7, A1, B1_hat, w4, w3);
	and G9 (w8, A0, B0_hat, w4, w3, w2);
	or G10 (A_greater_1, w5, w6, w7, w8); // result of 1st IC for A_greater

	and G11 (w9, B3, A3_hat);
	and G12 (w10, B2, A2_hat, w4);
	and G13 (w11, B1, A1_hat, w4, w3);
	and G14 (w12, B0, A0_hat, w4, w3, w2); 
	or G15 (B_greater_1, w9, w10, w11, w12); // result of 1st IC for B_greater

// 2nd IC
	
 	xnor G16 (w13, A4, B4); 
  	xnor G17 (w14, A5, B5);
  	xnor G18 (w15, A6, B6);
	xnor G19 (w16, A7, B7);
  	and G20 (A_equal_B_2, w13, w14, w15, w16); // result of 2nd IC for A_equal_B

	and G21 (w17, A7, B7_hat);
	and G22 (w18, A6, B6_hat, w16);
	and G23 (w19, A5, B5_hat, w16, w15);
	and G24 (w20, A4, B4_hat, w16, w15, w14);
	or G25 (A_greater_2, w17, w18, w19, w20); // result of 2nd IC for A_greater

	and G26 (w21, B7, A7_hat);
	and G27 (w22, B6, A6_hat, w16);
	and G28 (w23, B5, A5_hat, w16, w15);
	and G29 (w24, B4, A4_hat, w16, w15, w14); 
	or G30 (B_greater_2, w21, w22, w23, w24); // result of 2nd IC for B_greater

// Final level cascading 2 ICs

	and G31 (A_equal_B, A_equal_B_1, A_equal_B_2); // output for A_equal_B

	and G32 (w25, A_greater_1, A_equal_B_2);
	or G33 (A_greater, A_greater_2, w25);          // output for A_greater

	and G34 (w26, B_greater_1, A_equal_B_2);
	or G35 (B_greater, B_greater_2, w26);          // output for B_greater

endmodule

module testbench;

  	reg A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7;
  	wire A_greater, B_greater, A_equal_B;
  	comparator test(A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, A_greater, B_greater, A_equal_B);
  
  	initial 
		begin
   			    A0=1'b1;A1=1'b1;A2=1'b1;A3=1'b0;A4=1'b0;A5=1'b0;A6=1'b0;A7=1'b0; // A=11; B=11
			    B0=1'b1;B1=1'b1;B2=1'b1;B3=1'b0;B4=1'b0;B5=1'b0;B6=1'b0;B7=1'b0; // first 100 nsec A_equal_B will be high

   		       #100 A0=1'b1;A1=1'b0;A2=1'b0;A3=1'b0;A4=1'b1;A5=1'b1;A6=1'b1;A7=1'b0; // A=113; B=112
			    B0=1'b0;B1=1'b0;B2=1'b0;B3=1'b0;B4=1'b1;B5=1'b1;B6=1'b1;B7=1'b0; // second 100 nsec A_greater will be high

		       #100 A0=1'b0;A1=1'b1;A2=1'b0;A3=1'b1;A4=1'b1;A5=1'b0;A6=1'b0;A7=1'b0; // A=26; B=32
			    B0=1'b0;B1=1'b0;B2=1'b0;B3=1'b0;B4=1'b0;B5=1'b1;B6=1'b0;B7=1'b0; // then B_greater will be high
			
 		end
  
endmodule

