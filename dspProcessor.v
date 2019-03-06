`timescale 1ns / 1ps

module dsp_processor(
    
	   input clk,
       input nrst,
	    output [7:0]v1,
        output [7:0]v2,
        output [7:0]v3
        

	 );

reg [7:0] mem1[52:0];
reg execute;
reg [7:0] ram[0:8];
reg [5:0] OpCode;
reg [4:0] Rs, Rt, Rd;
reg [4:0] stores;
reg [3:0] code_end;  
reg [2:0] funcss;

reg [15:0] cntr ;
reg [7:0] immediate;
reg [31:0] delay_cntr;
reg [31:0] IF_pcs;

reg [31:0] t0s;
reg [31:0] t1s;
reg [31:0] t2s;
reg [31:0] t3s;
reg [31:0] t4s;
reg [31:0] t5s;
reg [31:0] t6s;
reg [31:0] t7s;
reg [31:0] t8s;




reg [31:0] results;

//reg [31:0] results1;

reg [31:0] ins_delay=0;
reg [31:0] msclk;
reg [31:0] data_a_s;
reg [31:0] data_b_s;
reg [31:0] comp1s;
reg [31:0] comp2s;


reg ram_rom;  // 0 for ram 1 for rom
reg types;
reg mclk;
reg transmit=0;
reg once;
reg arith_flags;
reg execute1=0;

reg [7:0] v1_t;
reg [7:0] v2_t;
reg [7:0] v3_t;

wire [4:0] store;
wire [2:0] func;
wire [31:0] IF_pc4;
wire [31:0] instruction;
wire [31:0] t0;
wire [31:0] t1;
wire [31:0] t2;
wire [31:0] t3;
wire [31:0] t4;
wire [31:0] t5;
wire [31:0] t6;
wire [31:0] t7;
wire [31:0] t8;



wire [31:0] data_a;
wire [31:0] data_b;
wire [31:0] result;

//wire [32:0] result1;

wire [31:0] comp1;
wire [31:0] comp2;
wire [15:0] rx_no;
wire rx_flag2;
wire type;
wire transmit1;
wire rx_complete;
wire arith_flag;

assign v1 = v1_t;
assign v2 = v2_t;
assign v3 = v3_t;


parameter t0p = 	5'b00001;
parameter t1p = 	5'b00010;
parameter t2p = 	5'b00011;
parameter t3p = 	5'b00100;
parameter t4p = 	5'b00101;
parameter t5p = 	5'b00110;
parameter t6p = 	5'b00111;
parameter t7p = 	5'b01000;
parameter t8p = 	5'b01001;
//parameter t9p =     5'b01010;

//##################################################################
//   Initial setting of registers
//##################################################################
initial
begin

    OpCode = 0;
    Rs = 0;
    Rt = 0;
    Rd = 0;
    immediate = 0;

  //  results1=0;	

	ram_rom = 0;
	code_end = 0;
	
	msclk = 0;
	data_a_s = 0;
	data_b_s = 0;
	delay_cntr =0 ;
	cntr =0 ;
	IF_pcs=0;
	stores = 0;
	t0s =0 ;
	t1s =0;
	t2s =0;
	t3s= 0;
	t4s = 0;
	t5s =0;
	t6s =0;
	t7s= 0;
	t8s = 0;
    
    	funcss = 0;
	results = 0;
	types =0 ;
	mclk = 0;
	comp1s = 0;
	comp2s = 0;
    v1_t =0 ;
    v2_t =0;
    v3_t =0;
	//results1 =0;

end


initial 
begin
	once = 0;
	execute=0;

	arith_flags = 0;
end







//##################################################################
// Clock Divide
//##################################################################
always @ (posedge clk)
begin


	msclk = msclk + 1;
//	mem1[0] = 8'b10101010;
end




always @(posedge clk)
begin
//	mclk = msclk[24];
	mclk = msclk[6];
//	mclk = msclk[2];

end
//##################################################################

//################################################
	always @ (posedge mclk)
	begin
		ins_delay = ins_delay+1;
		if(ins_delay > 2)
		begin
			ins_delay = 0;
		end
	end	

////################################################






//always @(rx_nos)
//always @(posedge msclk[1])
always @(posedge clk)

begin	

	if(execute1==1)
	begin
		execute=0;
	end


	if(once == 0)
	begin
	ram[0] <= 8'b00000000;		//00
	ram[1] <= 8'b00000000;		//00
	ram[2] <= 8'b00000011;		//03
	ram[3] <= 8'b11101000;		//E8

	ram[4] <= 8'b00000001;		//00
	ram[5] <= 8'b00000010;		//00
	ram[6] <= 8'b00000011;		//03
	ram[7] <= 8'b00000100;		//E8


	mem1[0] <= 8'b00000100;		
	mem1[1] <= 8'b00100001;		
	mem1[2] <= 8'b00000000;		
	mem1[3] <= 8'b00000001;		//
	
	mem1[4] <= 8'b00000100;		//
	mem1[5] <= 8'b01000010;		//
	mem1[6] <= 8'b00000000;		//
	mem1[7] <= 8'b00000010;		//
	
	mem1[8] <= 8'b00000100;		//
	mem1[9] <= 8'b01100011;		//
	mem1[10] <= 8'b00000000;	//
	mem1[11] <= 8'b00000011;	//
	
	mem1[12] <= 8'b00000100;	//
	mem1[13] <= 8'b10000100;	//
	mem1[14] <= 8'b00000000;	//
	mem1[15] <= 8'b00000100;	//
	
	mem1[16] <= 8'b00001000;	//
	mem1[17] <= 8'b00100011;	//
	mem1[18] <= 8'b00000000;	//
	mem1[19] <= 8'b00000000;	//
	
	mem1[20] <= 8'b00001000;	//
	mem1[21] <= 8'b00100100;	//
	mem1[22] <= 8'b00101000;	//
	mem1[23] <= 8'b00000000;	//
	
	mem1[24] <= 8'b00001000;	//
	mem1[25] <= 8'b01000011;	//
	mem1[26] <= 8'b00110000;	//
	mem1[27] <= 8'b00000000;	//
	
	mem1[28] <= 8'b00001000;	//
	mem1[29] <= 8'b01000100;	//
	mem1[30] <= 8'b00111000;	//
	mem1[31] <= 8'b00000000;	//
	
	mem1[32] <= 8'b00001000;	//
	mem1[33] <= 8'b00000000;	//
	mem1[34] <= 8'b01000000;	//
	mem1[35] <= 8'b00000000;	//
	
	mem1[36] <= 8'b00001100;	//
	mem1[37] <= 8'b11000111;	//
	mem1[38] <= 8'b00000000;	//
	mem1[39] <= 8'b00000000;	//
	
	mem1[40] <= 8'b00001100;	//
	mem1[41] <= 8'b00000000;	//
	mem1[42] <= 8'b01001000;	//
	mem1[43] <= 8'b00000000;	//
	
//	mem1[44] <= 8'b00010001;	//
//	mem1[45] <= 8'b00000111;	//
//	mem1[46] <= 8'b00000000;	//
//	mem1[47] <= 8'b00000000;	//

	mem1[44] <= 8'b11111111;	//
	mem1[45] <= 8'b11111111;	//
	mem1[46] <= 8'b11111111;	//
	mem1[47] <= 8'b11111111;	//
	
	once = 1;
	execute=1;
	end


	

	
end
//##################################################################













//////################################################



	fetch ftch(
	
			.clk(mclk),
			.nrst(nrst),
//			.ins_delay(ins_delay),
			.IF_pcs(IF_pcs),
			.memf1(mem1[IF_pcs]),
			.memf2(mem1[IF_pcs+1]),
			.memf3(mem1[IF_pcs+2]),
			.memf4(mem1[IF_pcs+3]),
			.instruction(instruction)

		);






always @(posedge mclk)
begin

    OpCode = instruction[31:26];
    Rs = instruction[25:21];
    Rt = instruction[20:16];
    Rd = instruction[15:11];
    immediate = instruction[7:0];
  v1_t = t4s[7:0];
  v2_t = t8s[7:0];
  v3_t = t7s[7:0];

end



always @(posedge mclk)
begin

	if(OpCode == 6'b111111)
	begin
		execute1=1;
	end

end

 
			
	control ctrl(
			
			.clk(mclk),
			.nrst(nrst),
			.OpCode(OpCode),
			.Rs(Rs),
			.Rt(Rt),
			.Rd(Rd),
			.immediate(immediate),
			
//			.ram1(ram[index]),
			
//			.ram2(ram[1]),
	//		.ram3(ram[2]),
		//	.ram4(ram[3]),
			
			.t0ss(t0s),
			.t1ss(t1s),
			.t2ss(t2s),
			.t3ss(t3s),
			.t4ss(t4s),
			.t5ss(t5s),
			.t6ss(t6s),
			.t7ss(t7s),
			.t8ss(t8s),
	//		.t9ss(t9s),

			.t0(t0),
			.t1(t1),
			.t2(t2),
			.t3(t3),
			.t4(t4),
			.t5(t5),
			.t6(t6),
			.t7(t7),
			.t8(t8),
	//		.t9(t9),
			.data_a(data_a),
			.data_b(data_b),
			
//			.type(type),
//			.IF_pc4(IF_pc4),

			.func(func),
			//.result(result),
			.store(store)
//			.IF_pcs(IF_pcs)
			);		
			

always @(posedge mclk)
begin
	stores <= store;
	funcss <= func;
	comp1s <= comp1;
	comp2s <= comp2;
	
	

	if(IF_pcs == 0)
	begin
		t0s <= 0;  
		t1s <= 0;  
		t2s <= 0;  
		t3s <= 0;  
	//	t4s <= 0;
	//	results <= 0;
		data_a_s	<= 0;
		data_b_s	<= 0;
		comp1s <=0;
		comp2s <=0;
		funcss <= 0;
		stores <= 0;
//		results <= 0;
	end
	else
	begin
		t0s <= t0;  
		t1s <= t1;  
		t2s <= t2;  
		t3s <= t3;  
//		t4s <= t4;  
	end


	if(IF_pcs == 0)
	begin
//		t3s <= 0;
		results <= 0;
//		result <= 0;
      //  results1 = 0;
	end
	else if(IF_pcs > 4)
	begin
		results <= result;
        //results1 <= result1;
		data_a_s <= data_a;
		data_b_s <= data_b;
//		cntr <= results[15:0];	
		if(arith_flags == 1)
		begin
			case(store)
				t0p: t0s <= results;
				t1p: t1s <= results;
				t2p: t2s <= results;
				t3p: t3s <= results;
				t4p: t4s <= results;
				t5p: t5s <= results;
				t6p: t6s <= results;
				t7p: t7s <= results;
				t8p: t8s <= results;
          //      t9p: t9s <= results1;
			endcase
		end	
//		t3s <= result;





	end
	else
	begin
	
		results <= result;
     //   results1<= result1;
		data_a_s <= data_a;
		data_b_s <= data_b;
	//	types <= type;
	
	end
	

end



always @ (posedge clk)
begin
	
		arith_flags = arith_flag;
end




	alu alu1(
		
			.clk(mclk),
			.nrst(nrst),
			.ins_delay(ins_delay),
			.func(func),
			.data_as(data_a_s),
			.data_bs(data_b_s),
           // .t6s(t6p),
            //.t7s(t7p),
			//.type(types),
			.result(result),
			.arith_flag(arith_flag),
			.IF_pcss(IF_pcs)

       //     .result1(result1)

			);





	add_pc a_pc(
	
			.clk(mclk),
			.nrst(nrst),
			.ins_delay(ins_delay),
			.IF_pcs(IF_pcs),
			.comp1(comp1s),
			.comp2(comp2s),
			.func(func),
			.execute(execute),
			//.leds(leds),
			.IF_pc4(IF_pc4)
		);



always @(posedge mclk)
begin

	IF_pcs <= IF_pc4;

end





endmodule
