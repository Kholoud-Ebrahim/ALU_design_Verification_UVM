class ALU_base_sequence extends uvm_sequence;
    `uvm_object_utils(ALU_base_sequence)

    ALU_sequence_item item;

    function new(string name = "ALU_base_sequence");
        super.new(name);
        `uvm_info("Base_SEQ","new constructor", UVM_HIGH)
    endfunction: new

    task body();
        `uvm_info("Base_SEQ","body", UVM_HIGH)
        item = ALU_sequence_item::type_id::create("item");
        start_item(item);
        assert(item.randomize() with {Reset==0;});
        finish_item(item);
    endtask: body

endclass: ALU_base_sequence
//=========================================================
class ALU_rst_sequence extends ALU_base_sequence;
    `uvm_object_utils(ALU_rst_sequence)
    
    ALU_sequence_item rst_item;
    
    function new(string name = "ALU_rst_sequence");
      super.new(name);
      `uvm_info("RST_SEQ","new constructor", UVM_HIGH)
    endfunction: new  
    
    task body();
      `uvm_info("RST_SEQ","body", UVM_HIGH)
        rst_item = ALU_sequence_item::type_id::create("rst_item");
      start_item(rst_item);
      assert(rst_item.randomize() with {Reset==1;});
      finish_item(rst_item);
      
    endtask: body
endclass: ALU_rst_sequence