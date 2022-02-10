//memory unit
module IMemBank(input [31:0] address, output reg [31:0] readdata);
  reg [31:0] mem_array [127:0];
  
  //integer i;
  //initial begin
  //    for (i=0; i<64; i=i+1)   
  //   mem_array[i]=i*10;
  //end

  initial begin
  mem_array[0] = 32'b00000000000000000100000000100000;
  mem_array[1] = 32'b00100000000010010000000000000111;
  mem_array[2] = 32'b10101101000010010000000000000000;
  mem_array[3] = 32'b00100001000010000000000000000001;
  mem_array[4] = 32'b00100001001010010000000000000101;
  mem_array[5] = 32'b00101001000010110000000000001010;
  mem_array[6] = 32'b00010101011000001111111111101100;
  mem_array[7] = 32'b00100000000010000001000011000110;
  mem_array[8] = 32'b00000000000000000100100000100000;
  mem_array[9] = 32'b00100000000010100000000000001010;
  mem_array[10] = 32'b00010001001010100000000000011000;
  mem_array[11] = 32'b10001101001010110000000000000000;
  mem_array[12] = 32'b00000001011010000110000000101010;
  mem_array[13] = 32'b00010001100000000000000000000100;
  mem_array[14] = 32'b00000000000010110100000000100000;
  mem_array[15] = 32'b00100001001010010000000000000001;
  mem_array[16] = 32'b00001000000000000000000000001010;
  mem_array[17] = 32'b00000000000010000010000000100000;
  mem_array[18] = 32'b00100000000010000000000000000000;
  mem_array[19] = 32'b00000000000000000100100000100000;
  mem_array[20] = 32'b00100000000010100000000000001010;
  mem_array[21] = 32'b00010001001010100000000000011000;
  mem_array[22] = 32'b10001101001010110000000000000000;
  mem_array[23] = 32'b00000001000010110110000000101010;
  mem_array[24] = 32'b00010001100000000000000000000100;
  mem_array[25] = 32'b00000000000010110100000000100000;
  mem_array[26] = 32'b00100001001010010000000000000001;
  mem_array[27] = 32'b00001000000000000000000000010101;
  mem_array[28] = 32'b00000000000010000010100000100000;
  end
 
  always@(address, readdata)
  begin
      $display("%d", address);
      readdata=mem_array[address >> 2];
    
  end

endmodule

// module testbench;
//   reg memread;              /* rw=RegWrite */
//   reg [31:0] adr;  	    /* adr=address */
//   wire [31:0] rd; 	    /* rd=readdata */
  
//   memBank u0(adr, rd);
  
//   initial begin
//     memread=1'b0;
//     adr=16'd0;
    
//     #5
//     memread=1'b1;
//     adr=16'd0;
//   end
  
//   initial repeat(127)#4 adr=adr+1;
  
// endmodule;
