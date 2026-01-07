module reg_file(clk, rst, rs_addr, rt_addr, rd_addr, wr_data, reg_write, rs_data, rt_data);
/*
rs_addr [2:0] - source register A
rt_addr [2:0] - source register B
rd_addr [2:0] - destination register
reg_write - write enable
*/
  input wire clk, rst, reg_write;
  input wire [2:0] rs_addr, rd_addr, rt_addr;
  input wire [7:0] wr_data;
  output wire [7:0] rs_data, rt_data;
  
  reg [7:0] regs [0:7];
  
  // Read logic (combinational)
  assign rs_data = regs[rs_addr];
  assign rt_data = regs[rt_addr]; 
  
  // Write logic (sequential)
  integer i;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (i = 0; i < 8; i = i + 1)
        regs[i] <= 8'h00;
    end	
    else if (reg_write) begin
      regs[rd_addr] <= wr_data;
    end
  end
endmodule