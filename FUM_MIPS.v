`timescale 1us/10ns

module FUM_MIPS();
	reg signed [31:0] pc;
	reg clk;
	wire [31:0] instruction	;
	wire [4:0] readreg1, readreg2, writereg;
	wire [31:0] readdata1, readdata2;
	wire [31:0] DMaddress, DMwritedata, DMreaddata;
	wire [31:0] ALUResult;
	wire [31:0] writedata;
	wire zero, lt, gt;

	reg [5:0] opcode;

	//wire [31:0] branch_mux_to_jump_mux;

	wire signed [31:0] seInst;

	wire [3:0] ALUOp;
	wire RegDst, ALUSrc, MemtoReg, RegWrite,
	 	MemRead, MemWrite, Jump, Branch;//Beq, Bne;

	wire unsigned [31:0]  pcPlus4, pcBranch, pcJump;
	//reg signed [28:0] shifted;
	reg signed [31:0] nextPc;

	integer i;
	initial begin  
		//pc = 0;
       		clk = 1;  

			$dumpfile("FUM_MIPS.vcd");
    		$dumpvars(0,FUM_MIPS);
           
        	for (i = 0; i < 500; i = i + 1) begin       
        	#50 clk = ~clk;           
        	end
      	end 

	always @(posedge clk) begin  
		//$display("%d", pc);
		assign pc = nextPc;
	end

	initial begin
		assign pc = -4;
		opcode = instruction[31:26];
	end

	assign pcPlus4 = pc + 4;
	assign pcBranch = opcode == 6'b000100 ? pcPlus4 + (seInst) : pcPlus4 - ((-seInst));
	assign pcJump = {pcPlus4[31:28], instruction[25:0], 2'b00};


	
	SignExtend se(instruction[15:0], seInst, clk);

	IMemBank im(pc, instruction);

	Controlunit control(ALUOp, instruction, RegDst, ALUSrc, MemtoReg, RegWrite,
	 	MemRead, MemWrite, Jump, Branch);//Beq, Bne);

	//MUX5 muxRegIn(RegDst, instruction[15:11], instruction[20:16], writereg);
	assign writereg = RegDst ? instruction[15:11] : instruction[20:16];
	assign readreg2 = instruction[20:16];
	assign readreg1 = instruction[25:21];

	RegFile regfile(clk, readreg1, readreg2, writereg, writedata, RegWrite, readdata1, readdata2);
	
	

	wire [31:0] inp2ALU;
	//MUX32 muxALUInput(ALUSrc, seInst, readdata2, inp2ALU);	
	
	assign inp2ALU = ALUSrc ? seInst : readdata2;
	
	ALU alu(readdata1, inp2ALU, ALUOp, ALUResult, zero, lt, gt);

	assign DMaddress = ALUResult;
	assign DMwritedata = readdata2;
	
	DMemBank dm(MemRead, MemWrite, DMaddress, DMwritedata, DMreaddata);

	//MUX32 wb(MemtoReg, DMreaddata, ALUResult, writedata);
	assign writedata = MemtoReg ? DMreaddata : ALUResult;

	//mux #(32) branchMux((Branch & zero), pcPlus4, pcBranch, branch_mux_to_jump_mux);

	//mux #(32) jumpMux(Jump, branch_mux_to_jump_mux, pcJump, nextPc);
	
	always @(posedge clk) begin

		$display("ALUResult: %d", ALUResult);
		//$display("ALUOp

		if (Jump) begin
			nextPc = pcJump;
		end else begin
    			if(((Branch & zero) && opcode == 6'b000100) || ((Branch & ~zero) && opcode == 6'b000101)) begin
	
				//$display("%d", seInst);
				nextPc = pcBranch;
			end else begin
				nextPc = pcPlus4;
			end
		end
		
  	end

endmodule

module SignExtend(input[15:0] in,output reg [31:0] out,input clk);
always @(*) begin
    if(in[15])
      out = {16'b1111111111111111 , in};
    else
      out = {16'd0 , in};
end
endmodule

module MUX32(Select, I1, I2, Out);
input [31:0] I1;
input [31:0] I2;
input Select;
output reg [31:0] Out;

always@(*) begin
  if (Select==1'b1) begin
   Out = I1;
  end 
  else begin 
   Out = I2;
  end
end
endmodule

module MUX5(Select, I1, I2, Out);
input [4:0] I1;
input [4:0] I2;
input Select;
output reg [4:0] Out;

always@(*) begin
  if (Select==1'b1) begin
   Out = I1;
  end 
  else begin
   Out = I2;
  end
end
endmodule