module pc(rst, clk, pc_en, pc_load, pc_in, pc_out);

  input rst, clk, pc_en, pc_load;
  input [7:0] pc_in;
  output reg [7:0] pc_out;
  
  always @(posedge clk or posedge rst) begin
    if (rst)
      pc_out <= 0;
    else if (pc_en) begin
      if (pc_load)
        pc_out <= pc_in;
      else
        pc_out <= pc_out + 1;
    end
  end
endmodule


