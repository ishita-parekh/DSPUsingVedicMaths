`timescale 1ns / 1ps

module control(

		input clk,
		input nrst,
		input [5:0]  OpCode,
		input [4:0]  Rs,
		input [4:0]  Rt,
		input [4:0]  Rd,
		input [7:0] immediate,
//		input [7:0] ram1,
//		input [7:0] ram2,
//		input [7:0] ram3,
//		input [7:0] ram4,
		input [31:0] t0ss,
		input [31:0] t1ss,
		input [31:0] t2ss,
		input [31:0] t3ss,
		input [31:0] t4ss,
		input [31:0] t5ss,
		input [31:0] t6ss,
		input [31:0] t7ss,
		input [31:0] t8ss,
        
    //    input [31:0] t9ss,

		inout [31:0] t0,
		inout [31:0] t1,
		inout [31:0] t2,
		inout [31:0] t3,
		inout [31:0] t4,
		inout [31:0] t5,
		inout [31:0] t6,
		inout [31:0] t7,
		inout [31:0] t8,
      //  inout [31:0] t9,
        		
		output [31:0] data_a,
		output [31:0] data_b,
		output [31:0] comp1,
		output [31:0] comp2,
//		output  type,
//		input  [31:0] IF_pc4,
		output  [2:0] func,
		output reg [4:0] store
		//input [31:0] result,
//		input [31:0] IF_pcs

    );

//reg [31:0] IF_pc4s;



		reg [31:0] comp1s;
		reg [31:0] comp2s;
		reg [4:0] stores;

		reg [31:0] t0s;
		reg [31:0] t1s;
		reg [31:0] t2s;
		reg [31:0] t3s;
		reg [31:0] t4s;
		reg [31:0] t5s;
		reg [31:0] t6s;
		reg [31:0] t7s;
		reg [31:0] t8s;
//		reg [31:0] t9s;
        reg [31:0] data_a_s;
		reg [31:0] data_b_s;
//		reg types;
		reg [2:0] funcs;
		
		
	assign t0 = t0s;
	assign t1 = t1s;
	assign t2 = t2s;
	assign t3 = t3s;
	assign t4 = t4s;
	assign data_a = data_a_s;
	assign data_b = data_b_s;
//	assign type = types;
//	assign  IF_pc4 =  IF_pc4s;
	assign  func =  funcs;
//	assign store = stores;
	assign comp1 = comp1s;
	assign comp2 = comp2s;


    parameter ld = 	    6'b000001;
    parameter mpy = 	6'b000010;
    parameter add = 	6'b000011;
    parameter stl =     6'b000100;
   
    parameter t0p = 	5'b00001;
    parameter t1p = 	5'b00010;
    parameter t2p = 	5'b00011;
    parameter t3p = 	5'b00100;
    parameter t4p = 	5'b00101;
    parameter t5p = 	5'b00110;
    parameter t6p = 	5'b00111;
    parameter t7p = 	5'b01000;
    parameter t8p = 	5'b01001;
//    parameter t9p =     5'b01010;

initial
begin
//		IF_pc4s = 0;

		stores = 0;
		comp1s = 0 ;
		comp2s = 0;

		t0s = 0;
		t1s = 0;
		t2s = 0;
		t3s = 0;
		t4s = 0;
		t5s = 0;
		t6s = 0;
		t7s = 0;
		t8s = 0;
  //      t9s = 0;
		data_a_s = 0;
		data_b_s = 0;
//		types = 0;
		funcs = 0;
end


	always @(posedge clk)
	begin
		if (~nrst)
		begin
		// need to write something
		end
		else
		begin
		
	//	if(ins_delay == 2)
	//	begin
				case(OpCode)
				
					ld:
					begin
							case(Rs)
									t0p: t0s <= immediate;
									t1p: t1s <= immediate;
									t2p: t2s <= immediate;
									t3p: t3s <= immediate;
									t4p: t4s <= immediate;
									t5p: t5s <= immediate;
									t6p: t6s <= immediate;
									t7p: t7s <= immediate;
									t8p: t8s <= immediate;
							endcase
							//types <= 0;					
							funcs <= 0;

					end
					
				add:
					begin
							case(Rs)
									t0p: data_a_s <= t0ss;
									t1p: data_a_s <= t1ss;
									t2p: data_a_s <= t2ss;
									t3p: data_a_s <= t3ss;
									t4p: data_a_s <= t4ss;
                                    t5p: data_a_s <= t5ss;
									t6p: data_a_s <= t6ss;
									t7p: data_a_s <= t7ss;
									t8p: data_a_s <= t8ss;
    //                                t9p: data_a_s <= t9ss;
							endcase
							
							case(Rt)
									t0p: data_b_s <= t0ss;
									t1p: data_b_s <= t1ss;
									t2p: data_b_s <= t2ss;
									t3p: data_b_s <= t3ss;
									t4p: data_b_s <= t4ss;
                                    t5p: data_b_s <= t5ss;
									t6p: data_b_s <= t6ss;
									t7p: data_b_s <= t7ss;
									t8p: data_b_s <= t8ss;
      //                              t9p: data_b_s <= t9ss;
							endcase
							
							store <= Rd;
							//types <= 0;	
							funcs <= 1;
							
					end
					mpy:
					begin
							case(Rs)
									t0p: data_a_s <= t0ss;
									t1p: data_a_s <= t1ss;
									t2p: data_a_s <= t2ss;
									t3p: data_a_s <= t3ss;
									t4p: data_a_s <= t4ss;
							endcase
							
							case(Rt)
									t0p: data_b_s <= t0ss;
									t1p: data_b_s <= t1ss;
									t2p: data_b_s <= t2ss;
									t3p: data_b_s <= t3ss;
									t4p: data_b_s <= t4ss;
							endcase
							//types <= 0;					
							store <= Rd;
							funcs <= 2;


					end
					stl:
					begin
							case(Rt)
									t0p: t4s <= t0ss;
									t1p: t4s <= t1ss;
									t2p: t4s <= t2ss;
									t3p: t4s <= t3ss;
                                    t4p: t4s <= t4ss;
							endcase
							//types <= 0;					
							funcs <= 0;
					end
					
				endcase

	end
end
endmodule
