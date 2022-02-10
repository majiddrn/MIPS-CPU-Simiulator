//memory unit
`timescale 1ps/1ps

module DMemBank(input memread, input memwrite, input wire [31:0] address, input wire [31:0] writedata, output reg [31:0] readdata);
 
  reg [31:0] mem_array [127:0];
  
  //integer i;
  //initial 
  //begin
  //    for (i=0; i<64; i=i+1)   
  //   mem_array[i]=i*10;
  //end
 
  always@(memread, memwrite, address, writedata, readdata)
  begin
    if(memread & ~memwrite)begin
	#1
	//$display("read data: %d", readdata);
      readdata=mem_array[address];
    end

    if(memwrite & ~memread)
    begin
	#1
	//$display("write data: %d, memread: %d, memwrite: %d", writedata, memread, memwrite);
      mem_array[address]= writedata;
    end

  end

endmodule

// module testbench;
//   reg memread, memwrite;              /* rw=RegWrite */
//   reg [7:0] adr;  /* adr=address */
//   wire [31:0] rd; /* rd=readdata */
//   reg [31:0] wd;
  
//   memBank u0(memread, memwrite, adr, wd, rd);
  
//   initial begin
//     memread=1'b0;
//     adr=16'd0;
    
//     #500
//     memread=1'b1;
//     adr=16'd0;
//   end
  
//   initial repeat(127)#4 adr=adr+1;
  
// endmodule
