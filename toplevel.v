`include "reg_file.v"
`include "control_unit.v"
`include "data_ram.v"
`include "alu.v"
`include "instr_mem.v"
`include "instr_reg.v"
`include "pc.v"

module toplevel(
    input  wire clk,
    input  wire rst,
    output wire [7:0] pc_out,
    output wire [7:0] instr
);

    // ================= INTERNAL WIRES =================
    wire [7:0] pc;
    wire [7:0] instr_mem_out;
    wire [7:0] ir_out;

    wire [2:0] opcode;
    wire [2:0] rd;
    wire [1:0] rs;
    wire [2:0] rs_addr;

    wire pc_en, pc_load, ir_load;
    wire reg_write, mem_read, mem_write;
    wire [2:0] alu_op;

    wire [7:0] rs_data, rt_data;
    wire [7:0] alu_result;
    wire alu_zero, alu_carry;
    wire [7:0] mem_data;
    wire [7:0] writeback_data;

    // ================= DECODE =================
    assign opcode = ir_out[7:5];
    assign rd     = ir_out[4:2];
    assign rs     = ir_out[1:0];
    assign rs_addr = {1'b0, rs};

    // ================= WRITEBACK MUX =================
    assign writeback_data =
        mem_read ? mem_data : alu_result;

    // ================= PC =================
    pc pc_inst (
        .clk(clk),
        .rst(rst),
        .pc_en(pc_en),
        .pc_load(pc_load),
        .pc_in(rs_data),      // JMP uses R[rs]
        .pc_out(pc)
    );

    // ================= INSTRUCTION MEMORY =================
    instr_mem imem (
        .addr(pc),
        .instr(instr_mem_out)
    );

    // ================= INSTRUCTION REGISTER =================
    instr_reg ir (
        .clk(clk),
        .rst(rst),
        .instr_in(instr_mem_out),
        .instr_out(ir_out),
        .instr_load(ir_load)
    );

    // ================= CONTROL UNIT =================
    control_unit cu (
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .pc_en(pc_en),
        .pc_load(pc_load),
        .ir_load(ir_load),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op)
    );

    // ================= REGISTER FILE =================
    reg_file rf (
        .clk(clk),
        .rst(rst),
        .rs_addr(rd),
        .rt_addr(rs_addr),
        .rd_addr(rd),
        .wr_data(writeback_data),
        .reg_write(reg_write),
        .rs_data(rs_data),
        .rt_data(rt_data)
    );

    // ================= ALU =================
    alu alu_inst (
        .a(rs_data),
        .b(rt_data),
        .alu_op(alu_op),
        .result(alu_result),
        .zero(alu_zero),
        .carry(alu_carry)
    );

    // ================= DATA MEMORY =================
    data_ram dmem (
        .clk(clk),
        .rst(rst),
        .addr(rs_data),
        .wr_data(rt_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .rd_data(mem_data)
    );

    assign pc_out = pc;
    assign instr  = ir_out;

endmodule

