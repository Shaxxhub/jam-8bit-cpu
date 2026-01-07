module instr_reg(clk, rst, instr_in, instr_out, instr_load);

input wire clk,rst,instr_load;
input wire [7:0]instr_in;
output reg [7:0]instr_out;

always @(posedge clk or posedge rst) begin
    if (rst)
	instr_out <= 8'h00;
    else if (instr_load)
        instr_out <= instr_in;
  end
endmodule