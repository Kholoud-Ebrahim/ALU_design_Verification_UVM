class ALU_sequencer extends uvm_sequencer #(ALU_sequence_item);
    `uvm_component_utils(ALU_sequencer)

    function new(string name= "ALU_sequencer", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SQR","new constructor", UVM_HIGH)
    endfunction: new
endclass: ALU_sequencer