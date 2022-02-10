module ALU(input [31:0] data1,data2,input [3:0] aluoperation,output reg [31:0] result,output reg zero,lt,gt);

  always@(aluoperation,data1,data2)
  begin
    case (aluoperation)
      4'b0000 : result = data1 + data2; // ADD
      4'b0001 : result = data1 - data2; // SUB
      4'b0010 : result = data1 & data2; // AND
      4'b0011 : result = data1 | data2; // OR
      4'b0100 : result = data1 ^ data2; // XOR
      default : result = data1 + data2; // ADD
    endcase

	//$display("data1: %d, data2: %d, aluop: %d, result: %d", data1, data2, aluoperation, result);
    if(data1 == data2)
      begin
       gt = 1'b0;
       lt = 1'b0;
      end
    if(data1>data2)
      begin
       gt = 1'b1;
       lt = 1'b0; 
      end else if(data1<data2)
      begin
       gt = 1'b0;
       lt = 1'b1;  
      end
      
    if (result==32'd0) zero=1'b1;
    else zero=1'b0;

    if (aluoperation == 4'b0111) result = lt;
     
  end
  

endmodule

