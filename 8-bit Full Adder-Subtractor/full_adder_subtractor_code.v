// Verilog model of 8-bit Full-Adder-Subtractor circuit 
// which is used to add or subtract 2-byte input data (binary numbers)
// I used buttom-up modelling for this task
// which means firstly I define Half-Adder, then Full-Adder
// after that, I design 8-bit Full-Adder-Subtractor using Full-Adders
// if Mode is 0, circuit behaves as Adder
// if Mode is 1, circuit behaves as Subtractor
// At the end, there are some Registers to save data
// written by Asadullah Jamalov 05.05.2020

module half_adder ( output S, C, input x, y); // Half-Adder 
	xor (S, x, y);
	and (C, x, y);
endmodule

module full_adder ( output S, C, input x, y, z); // Full-Adder
	wire S1, C1, C2;
	half_adder HA1 (S1, C1, x, y);
	half_adder HA2 (S, C2, S1, z);
	or g1 (C, C2, C1);
endmodule

// Full-Adder-Subtractor
module full_adder_subtractor ( output [7:0] S, output Carry, Overflow , input [7:0] A, B, input Mode);
	wire [8: 0] C;
	wire [7: 0] B_M;

// Depending on Mode, B_M will be B or B_hat
	xor  G0 (B_M[0], B[0], Mode);
	xor  G1 (B_M[1], B[1], Mode);
	xor  G2 (B_M[2], B[2], Mode);
	xor  G3 (B_M[3], B[3], Mode);
	xor  G4 (B_M[4], B[4], Mode);
	xor  G5 (B_M[5], B[5], Mode);
	xor  G6 (B_M[6], B[6], Mode);
	xor  G7 (B_M[7], B[7], Mode);

// Initializing C0
	buf G8 (C[0], Mode); 

// 8 Full-Adder
	full_adder FA0 (S[0], C[1], A[0], B_M[0], C[0]),
	           FA1 (S[1], C[2], A[1], B_M[1], C[1]),
	           FA2 (S[2], C[3], A[2], B_M[2], C[2]),
	           FA3 (S[3], C[4], A[3], B_M[3], C[3]),
		   FA4 (S[4], C[5], A[4], B_M[4], C[4]),
		   FA5 (S[5], C[6], A[5], B_M[5], C[5]),
  		   FA6 (S[6], C[7], A[6], B_M[6], C[6]),
		   FA7 (S[7], C[8], A[7], B_M[7], C[7]);

// Assigning Carry bit
	buf G9 (Carry, C[8]);

// Assigning Overflow bit
	xor  G10 (Overflow, C[7], C[8]);

endmodule

// Registers for saving inputs A and B
module Register_A (input [7:0] A, input Clk, output reg [7:0] out_A);
	always @(posedge Clk)
	out_A <= A;
endmodule 

module Register_B (input [7:0] B, input Clk, output reg [7:0] out_B);
	always @(posedge Clk)
	out_B <= B;
endmodule 

// Register for saving output S
module Register_S (input [7:0] S, input Clk, output reg [7:0] out_S);
	always @(posedge Clk)
	out_S <= S;
endmodule 

// Testing the Binary Full-Adder-Subtractor Circuit
module testbench;

  	reg [7: 0] A;
	reg [7: 0] B;
	reg Mode;
  	wire [7: 0] S;
	wire Carry, Overflow;

  	full_adder_subtractor test(S[7:0], Carry, Overflow, A [7:0], B[7:0], Mode);
  
  	initial 
		begin
   			A=8'b00000001; // A=01
			B=8'b00000001; // B=01
			Mode=1'b0;     // Addition Mode A+B=02 (S=02, carry=0, overflow=0)
			
			#50
			A=8'b11111111; // A=ff
			B=8'b10111010; // B=ba
			Mode=1'b0;     // Addition Mode A+B=b9 (S=b9, carry=1, overflow=0)

			#50
			A=8'b10000000; // A=80
			B=8'b10000000; // B=80
			Mode=1'b0;     // Addition Mode A+B=00 (S=00, carry=1, overflow=1)

			#50	
		        A=8'b01100001; // A=61
			B=8'b00001001; // B=09
			Mode=1'b1;     // Subtraction Mode A-B=58 (S=58, carry=1, overflow=0)
			
			#50
			A=8'b10001111; // A=8f
			B=8'b10111010; // B=ba
			Mode=1'b1;     // Subtraction Mode A-B=d5 (S=d5, carry=0, overflow=0)

			#50
			A=8'b01000010; // A=42
			B=8'b10001000; // B=88
			Mode=1'b1;     // Subtraction Mode A-B=ba (S=ba, carry=0, overflow=1)

 		end
  
endmodule
