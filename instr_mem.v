module instr_mem(addr,instr);
// A simple read-only instruction memory (ROM) that loads hexadecimal program data from a file 
// and outputs an 8-bit instruction based on an 8-bit address input.
input [7:0]addr;
output [7:0]instr;

reg [7:0] imem[0:255]; // creating 256 storage locations addressable from 0 to 255.
assign instr = imem[addr];

initial begin
        $readmemh("./program.hex", imem); // loads hex data from "program.hex" into imem starting at index 0
    end

endmodule
