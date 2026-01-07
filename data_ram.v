module data_ram(clk, rst, addr, wr_data, mem_write, mem_read, rd_data);

input clk, rst, mem_read, mem_write;
input [7:0] addr, wr_data;
output wire [7:0] rd_data;

//256 bytes of data
reg [7:0] dmem [0:255];


//sequential write
integer i;
always @(posedge clk or posedge rst) begin
	if(rst) begin
		for(i = 0; i<256; i=i+1) dmem[i] <= 0; //clear memory on reset
	end 
	else if(mem_write)  dmem[addr] <= wr_data;
end

//combinational read
assign rd_data = mem_read? dmem[addr] : 0 ;

endmodule