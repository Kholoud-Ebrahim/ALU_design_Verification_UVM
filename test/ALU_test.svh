class ALU_test extends uvm_test;
    `uvm_component_utils(ALU_test)

    ALU_env env;
    ALU_base_sequence tst_seq;
    ALU_rst_sequence  rst_seq;
    
    function new(string name= "ALU_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("TEST","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TEST","build_phase", UVM_HIGH)
        
        env = ALU_env::type_id::create("env", this);
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("TEST","run_phase", UVM_HIGH)
        
        phase.raise_objection(this);
        rst_seq = ALU_rst_sequence::type_id::create("rst_seq");
        rst_seq.start(env.agnt.sqr);
        #10;
        repeat(1000) begin
            tst_seq = ALU_base_sequence::type_id::create("tst_seq");
            tst_seq.start(env.agnt.sqr);
            #10;
        end
        
        phase.drop_objection(this);
    endtask: run_phase

endclass: ALU_test