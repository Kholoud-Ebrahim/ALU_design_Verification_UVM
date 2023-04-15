interface ALU_interface (input Clock);
    logic Reset;
    logic [7:0]A;
    logic [7:0]B;
    logic [3:0]ALU_Sel;
    logic [7:0]ALU_Out;
    logic      Carry_Out;
endinterface: ALU_interface