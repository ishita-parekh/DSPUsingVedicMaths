`timescale 1ns / 1ps

module fetch(
			input clk,
			input nrst,
//			input [31:0] ins_delay,
			input [31:0] IF_pcs,
			input [7:0] memf1,
			input [7:0] memf2,
			input [7:0] memf3,
			input [7:0] memf4,
			output [31:0] instruction
    );


reg [31:0] instructions;


initial
begin
	instructions=0;
end


assign instruction = instructions;



	always @(posedge clk)
	begin
		if (~nrst)
		begin
			instructions = 0;
		end
		else
		begin
	//		if(ins_delay == 0)
				instructions = {memf1,memf2,memf3,memf4};
		end
	end

endmodule
