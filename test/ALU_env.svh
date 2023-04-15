class ALU_env extends uvm_env;
    `uvm_component_utils(ALU_env)

    ALU_agent agnt;
    ALU_scoreboard scb;

    function new(string name ="ALU_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENV","build_phase", UVM_HIGH)
        
        agnt = ALU_agent::type_id::create("agnt", this);
        scb = ALU_scoreboard::type_id::create("scb", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV","connect_phase", UVM_HIGH)
        agnt.mon.monitor_port.connect(scb.scoreboard_port);
    endfunction: connect_phase

endclass: ALU_env