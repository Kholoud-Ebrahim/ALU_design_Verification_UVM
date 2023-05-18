class ALU_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(ALU_scoreboard)

    ALU_sequence_item item;
    ALU_sequence_item trasaction [$];
    uvm_analysis_imp #(ALU_sequence_item, ALU_scoreboard) scoreboard_port;

    function new(string name= "ALU_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SCB","new constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AGNT","build_phase", UVM_HIGH)
        
        scoreboard_port = new("scoreboard_port", this); 
    endfunction: build_phase

    function void write(ALU_sequence_item item);
        trasaction.push_back(item);
    endfunction: write

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("AGNT","run_phase", UVM_HIGH)
        
        forever begin
          ALU_sequence_item current_trans;
          wait(trasaction.size() != 0 );
          current_trans = trasaction.pop_front();
          compare(current_trans);
        end
    endtask: run_phase

    task compare(ALU_sequence_item current_trans);
        logic [7:0] expected , actual;
        
        case(current_trans.ALU_Sel)
            0: expected = current_trans.A + current_trans.B;
            1: expected = current_trans.A - current_trans.B;
            2: expected = current_trans.A * current_trans.B;
            3: expected = current_trans.A / current_trans.B;
            4: expected = current_trans.A & current_trans.B;
            5: expected = current_trans.A | current_trans.B;
            6: expected = current_trans.A ^ current_trans.B;
        endcase
        actual = current_trans.ALU_Out;
        
        if(actual != expected) begin
            `uvm_error("COMPARE", $sformatf("FAILED @%5t: A=%4d  OP=%3d  B=%4d  Exp=%4d  Actual=%4d", $time, current_trans.A, current_trans.ALU_Sel, current_trans.B, expected, actual))
        end
        else begin
            `uvm_info("COMPARE", $sformatf("PASSED  @%5t: A=%4d  OP=%3b  B=%4d  Exp=%4d  Actual=%4d", $time, current_trans.A, current_trans.ALU_Sel, current_trans.B, expected, actual), UVM_LOW)
        end
    endtask:compare
    
endclass: ALU_scoreboard
