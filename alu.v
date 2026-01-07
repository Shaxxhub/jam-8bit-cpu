module alu(a, b, alu_op, result, zero, carry);

input  wire [7:0] a, b;
input  wire [2:0] alu_op;
output reg  [7:0] result;
output wire       zero;
output reg        carry;

reg [8:0] temp;  

always @(*) begin
    // defaults (prevents latches)
    result = 8'h00;
    carry  = 1'b0;
    temp   = 9'h000;

    case (alu_op)
        3'b000: begin  // ADD
            temp   = {1'b0, a} + {1'b0, b};
            result = temp[7:0];
            carry  = temp[8];
        end

        3'b001: begin  // SUB
            temp   = {1'b0, a} - {1'b0, b};
            result = temp[7:0];
            carry  = temp[8];
        end

        3'b010: result = a & b; 
        3'b011: result = a | b;
        3'b100: result = a ^ b;
        3'b101: result = b;
        3'b110: result = a;
        default: result = 8'h00;
    endcase
end

// derived flag
assign zero = (result == 8'h00);

endmodule
