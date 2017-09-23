class Packet;

	rand	reg	[`REGISTER_WIDTH-1:0] 	src1;		 
	rand	reg	[`REGISTER_WIDTH-1:0] 	src2;		 
	rand	reg	[`REGISTER_WIDTH-1:0] 	imm;		
	rand	reg	[`REGISTER_WIDTH-1:0] 	mem_data;		
	rand	reg				immp_regn_op_gen;
	rand	reg [2:0]			operation_gen;
	rand	reg [2:0]			opselect_gen;
	
	reg					enable;
	string 	name;
	
	constraint Limit {
		src1 inside	{[0:32'hFFFFFFFF]};
		src2 inside	{[0:32'hFFFFFFFF]};
		imm inside	{[0:32'hFFFFFFFF]};
		mem_data inside	{[0:65534]};
		
		opselect_gen inside {[0:1], [4:5]};	//these are the only valid inputs 
	//	opselect_gen inside {4};	//arith only 
		
		if ((opselect_gen == `ARITH_LOGIC)){
			operation_gen inside {[0:7]};
		}
		else if ((opselect_gen == `SHIFT_REG)) {
			immp_regn_op_gen inside {0};
			operation_gen inside {[0:3]};
		}
		else if ((opselect_gen == `MEM_READ)) {
			immp_regn_op_gen inside {1};
			operation_gen inside {0,1,3,4,5};
		}
		else if ((opselect_gen == `MEM_WRITE)) {
			immp_regn_op_gen inside {1};
			operation_gen inside {[0:7]}; // just make sure it does not matter
		}
	}
	
	extern function new(string name = "Packet");
endclass

function Packet::new(string name = "Packet");
	this.name = name;
endfunction