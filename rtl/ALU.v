module ALU (Clock, Reset, A, B, ALU_Sel, ALU_Out, Carry_Out);
    input Clock;
    input Reset;
    input [7:0] A, B;         // ALU 8-bit Inputs                 
    input [3:0] ALU_Sel;      // ALU Selection
    output reg [7:0] ALU_Out; // ALU 8-bit Output
    output reg Carry_Out;     // Carry Out Flag

    reg [7:0] ALU_Out_tmp;
    reg Carry_Out_tmp;
    always @(posedge Clock , posedge Reset) begin
        if(Reset) begin
            ALU_Out   <= 8'b0;
            Carry_Out <= 1'b0;
        end
        else begin
            Carry_Out = 1'b0;
            case(ALU_Sel)
                4'b0000: // Add
                    {Carry_Out_tmp, ALU_Out_tmp} = A + B ; 
                4'b0001: // Subtraction
                    ALU_Out_tmp = A - B ;
                4'b0010: // Mul
                    ALU_Out_tmp = A * B;
                4'b0011: // Div
                    ALU_Out_tmp = A / B;
                4'b0100: // And_bw
                    ALU_Out_tmp = A & B;
                4'b0101: // Or_bw
                    ALU_Out_tmp = A | B;
                4'b0110: // Xor_bw
                    ALU_Out_tmp = A ^ B;
                default: 
                    ALU_Out_tmp = 8'h0 ;
            endcase
            ALU_Out   <= ALU_Out_tmp;
            Carry_Out <= Carry_Out_tmp;
        end
    end
endmodule: ALU