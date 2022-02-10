module mux
	#(
		parameter LENGTH = 32
	)
	(
		input select,
		input [LENGTH-1:0] in0, in1,
		output wire [LENGTH-1:0] out
	);

	assign out = select ? in1 : in0;
endmodule
