module control_unit(
input clk, rst,
input [2:0] opcode,
output reg pc_en, pc_load, ir_load, reg_write, mem_read, mem_write,
output reg [2:0] alu_op
);

reg [1:0] state, next_state ;

parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
//STATE REGISTER
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= s0;      // FETCH
    else
        state <= next_state;
end

//COMBINATIONAL CONTROL
always @(*) begin

// default valuea to avoid latch
pc_en = 0; 
pc_load = 0; 
ir_load = 0;
reg_write = 0; 
mem_read = 0;
mem_write = 0;
alu_op = 3'b000;
next_state = s0;
	
	case (state) 
	s0: begin //FETCH
		pc_en = 1; 
		pc_load = 0; 
		ir_load = 1;
		reg_write = 0; 
		mem_read = 0;
		mem_write = 0;
		next_state = s1;
		end

	s1: begin //DECODE
		pc_en = 0; 
		ir_load = 0; next_state = s2;
		end
	s2: begin //EXECUTE
		if(opcode <= 3'b100)/*ALU OPS*/ alu_op = opcode;
		else if (opcode == 3'b101) /*LOAD*/ mem_read = 1;
		else if (opcode == 3'b110) /*STORE*/ mem_write = 1;
		else if (opcode == 3'b111) /*JMP*/ begin pc_en = 1; pc_load = 1; end
		next_state = s3;
		end
	s3: begin //WRITEBACK
		if(opcode<=3'b100) reg_write = 1;
		else if (opcode == 3'b101) /*LOAD*/ reg_write = 1;
		next_state = s0;
		end
	endcase
	
end

endmodule