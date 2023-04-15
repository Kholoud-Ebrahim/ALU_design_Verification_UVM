class ALU_agent extends uvm_agent;
    `uvm_component_utils(ALU_agent)

    ALU_sequencer sqr;
    ALU_driver   drv;
    ALU_monitor  mon;

    function new(string name= "ALU_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGNT","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AGNT","build_phase", UVM_HIGH)
        
        drv = ALU_driver::type_id::create("drv",this);
        mon = ALU_monitor::type_id::create("mon",this);
        sqr = ALU_sequencer::type_id::create("sqr",this);
       
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("AGNT","connect_phase", UVM_HIGH)
    
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction: connect_phase
endclass: ALU_agent