class ALU_sequence_item extends uvm_sequence_item;
    rand bit [7:0] A;
    rand bit [7:0] B;
    rand bit [3:0] ALU_Sel;
    rand bit       Reset;

    bit [7:0] ALU_Out;
    bit       Carry_Out;

    `uvm_object_utils_begin(ALU_sequence_item)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(ALU_Sel, UVM_ALL_ON)
        `uvm_field_int(Reset, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "ALU_sequence_item");
        super.new(name);
    endfunction: new

    constraint c1 {ALU_Sel inside {[0:6]};}
    constraint c2 {A >= B;}
endclass: ALU_sequence_item