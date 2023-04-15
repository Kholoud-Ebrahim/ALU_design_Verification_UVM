class ALU_driver extends uvm_driver #(ALU_sequence_item);
    `uvm_component_utils(ALU_driver)

    virtual ALU_interface vif;
    ALU_sequence_item item;

    function new(string name= "ALU_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info("DRV","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DRV","build_phase", UVM_HIGH)
        
        if(!(uvm_config_db #(virtual ALU_interface)::get(this, "*","vif", vif)))
          `uvm_error("DRV","Failed to get VIF config db") 
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRV","run_phase", UVM_HIGH)
        
        forever begin
            item = ALU_sequence_item::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive(item);
            seq_item_port.item_done();
        end  
    endtask: run_phase

    task drive(ALU_sequence_item item);
        @(posedge vif.Clock);
            vif.Reset <= item.Reset ;
            vif.A <= item.A ;
            vif.B <= item.B ;
            vif.ALU_Sel <= item.ALU_Sel ;
    endtask: drive

endclass: ALU_driver
