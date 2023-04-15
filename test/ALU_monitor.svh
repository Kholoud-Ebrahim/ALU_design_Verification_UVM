class ALU_monitor extends uvm_monitor;
    `uvm_component_utils(ALU_monitor)
    virtual ALU_interface vif;
    ALU_sequence_item item;

    uvm_analysis_port #(ALU_sequence_item) monitor_port;

    function new(string name= "ALU_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info("MON","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("MON","build_phase", UVM_HIGH)
        
        monitor_port = new("monitor_port", this);
        
        if(!(uvm_config_db #(virtual ALU_interface)::get(this,"*","vif", vif)))
            `uvm_error("MON","Failed to get VIF config db")
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("MON","run_phase", UVM_HIGH)
        
        forever begin
            item = ALU_sequence_item::type_id::create("item");
            wait(! vif.Reset);
          
            @(posedge vif.Clock);
            item.A = vif.A;
            item.B = vif.B;
            item.ALU_Sel = vif.ALU_Sel;
          
            @(posedge vif.Clock);
            item.ALU_Out = vif.ALU_Out;
          
            // send item on scoreboard
            monitor_port.write(item);
        end
    endtask: run_phase

endclass: ALU_monitor