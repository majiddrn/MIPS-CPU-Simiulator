module Controlunit(output reg [3:0] ALUOp, input [31:0] instruction, output reg RegDst, ALUSrc, MemToReg, RegWrite,
	 MemRead, MemWrite, Jump, Branch);
	
	reg [5:0] opcode;
	reg [5:0] func;

	/*initial begin
		opcode = instruction[31:26];
		func = instruction[5:0];
	end*/

	/*always @(instruction) begin

	 opcode = instruction[31:26];
	 func = instruction[5:0];
	
	 MemRead = (opcode == 6'b100011 ? 1'b1 : 1'b0); 				// lw
	 MemtoReg = (opcode == 6'b100011 ? 1'b1 : 1'b0); 				// lw
	 MemWrite = (opcode == 6'b101011 ? 1'b1 : 1'b0);  				// sw
	 Jump = (opcode == 6'b000010 ? 1'b1 : 1'b0); 					// jump
	 RegDst = (opcode == 6'b000000 ? 1'b1 : 1'b0);					// RegDst is 1 when R-Type

	 if (opcode == 6'b000100 || opcode == 6'b000101) Branch = 1'b1;
	 if (opcode == 6'b000100) ALUOp = 4'b1001;					// Beq
	 if (opcode == 6'b000101) ALUOp = 4'b1010;					// Bne

	 if (opcode == 6'b001100) ALUOp = 4'd2;						// Andi
	 if (opcode == 6'b001101) ALUOp = 4'd3;						// Ori
	 if (opcode == 6'b001010) ALUOp = 4'd1;				        	// Slti	

	 RegWrite = ((opcode == 6'b000000) |						// R-Type
			(opcode == 6'b100011) |						// lw
			(opcode == 6'b001000) |						// addi
			(opcode == 6'b001010) |						// slti
			(opcode == 6'b001100) |						// andi
			(opcode == 6'b001101) ? 1'b1 : 1'b0);				// ori

	 ALUSrc = (opcode == 6'b000000 ? 1'b0 : 1'b1);

	if (opcode == 6'b000000 && func == 6'b100000) ALUOp = 4'd0;
	if (opcode == 6'b000000 && func == 6'b100010) ALUOp = 4'd1;
	if (opcode == 6'b000000 && func == 6'b100100) ALUOp = 4'd2;
	if (opcode == 6'b000000 && func == 6'b100101) ALUOp = 4'd3;
	if (opcode == 6'b000000 && func == 6'b101010) ALUOp = 4'd1;
	if (opcode == 6'd0 && func == 6'd101010) ALUOp = 4'd1;				//slt 

	if (opcode == 6'b101011) ALUOp = 4'd0;
	if (opcode == 6'b100011) ALUOp = 4'd0;

	// ALUOp = (opcode == 6'd0 && func == 6'b100000 ? 4'b0010 : 4'd0); 		// R-Type add
	// ALUOp = (opcode == 6'd0 && func == 6'b100010 ? 4'b0110 : 4'd0);		// R-Type sub
	// ALUOp = (opcode == 6'd0 && func == 6'b100100 ? 4'b0000 : 4'd0);		// R-Type and	
	// ALUOp = (opcode == 6'd0 && func == 6'b100101 ? 4'b0001 : 4'd0);		// R-Type or
	// ALUOp = (opcode == 6'd0 && func == 6'b101010 ? 4'b0111 : 4'd0);		// R-Type slt
	
	end*/


	always @(instruction) begin

		opcode = instruction[31:26];
		func = instruction[5:0];

		RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd0;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;

		case (opcode)
			6'b000000: begin // R-Type
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				if (func == 6'b100000)
					ALUOp = 4'b0000;
				if (func == 6'b100010)
					ALUOp = 4'd1;
				if (func == 6'b100100)
					ALUOp = 4'd2;
				if (func == 6'b100101)
					ALUOp = 4'd3;
				if (func == 6'b101010)
					ALUOp = 4'b0111;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				
			end

			6'b001000: begin // addi
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd0;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				
			end


			6'b001100: begin // andi
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd2;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				
			end


			6'b001101: begin // ori
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd3;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				
				
			end


			6'b100011: begin // lw
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b1;
				ALUOp = 4'd0;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				
			end


			6'b101011: begin // sw
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd0;
				MemWrite = 1'b1;
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
				
			end


			6'b000100: begin // beq
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd1;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				
			end


			6'b000101: begin // bne
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'd1;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				
			end


			6'b000010: begin // jump
				RegDst = 1'b0;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				
			end

			6'b001010: begin  //slti
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0111;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end

		endcase

	end


endmodule
