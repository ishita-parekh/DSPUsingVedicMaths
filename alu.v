`timescale 1ns / 1ps


module alu(

  input clk,
  input nrst,
  input [31:0] ins_delay,
  input [2:0] func,
  input [31:0] data_as,
  input [31:0] data_bs,
 // input type,
  output [31:0] result,
//  output [31:0] result1,
  output arith_flag,
  
  input [31:0]IF_pcss
);

		
  reg [31:0] results;
 // reg [31:0] results1;
  reg addflg;
  reg arith_flags;
  
	assign arith_flag = arith_flags;
  assign result = results;
 // assign result1 = results1;
  
  initial 
  begin
		results = 0;
   //     results1 =0;

		addflg = 0;
		arith_flags = 0;
  end

  always @(posedge clk)
  begin
//	if (type == 1)
//	begin

	if(IF_pcss == 0)
	begin
		results = 0;
     //   results1 = 0;
		arith_flags = 0;
	end
	else
	begin
		if(ins_delay == 2)
		begin	
				case (func)
					3'b001 : begin 
									results = data_as + data_bs; // Add
									arith_flags = 1;
								end
					3'b010 : begin
									results = data_as * data_bs; // Multiply
									arith_flags = 1;
								end
				endcase
		end	
	end
		
		
		
 end
endmodule

