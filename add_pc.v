`timescale 1ns / 1ps


module add_pc(

			input clk,
			input nrst,
			input [31:0] ins_delay,
			input [31:0] IF_pcs,
			input [31:0] comp1,
			input [31:0] comp2,
			input [2:0] func,
			input execute,
//			output leds,
			output [31:0] IF_pc4

    );

reg [31:0] IF_pc4s;
reg [31:0] comp11;
reg [31:0] comp22;

//reg ledss;
//assign leds = ledss;

initial
begin
	IF_pc4s=0;
end


assign IF_pc4 = IF_pc4s;

	always @(posedge clk)
	begin
		if (~nrst)
		begin
			IF_pc4s <= 0;
		end
		else
		begin
		if(execute == 1)
		begin

		if(ins_delay == 2)
		begin	
		
						IF_pc4s <= IF_pcs + 4;
			
		end// end of ins_delay 	
		
		end// end of execute
		else
		begin
			IF_pc4s <= 0;
			
		end
		
	end// end of clk

end
endmodule
