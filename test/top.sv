`timescale 1ns/1ns

`include "uvm_macros.svh"

`include "ALU_interface.sv"
`include "ALU_sequence_item.svh"
`include "ALU_sequences.svh"
`include "ALU_sequencer.svh"
`include "ALU_driver.svh"
`include "ALU_monitor.svh"
`include "ALU_agent.svh"
`include "ALU_scoreboard.svh"
`include "ALU_env.svh"
`include "ALU_test.svh"

module top;
    bit Clock;

    ALU_interface intif(Clock);
    ALU  dut (.Clock(Clock), 
              .Reset(intif.Reset), 
              .A(intif.A), 
              .B(intif.B), 
              .ALU_Sel(intif.ALU_Sel), 
              .ALU_Out(intif.ALU_Out), 
              .Carry_Out(intif.Carry_Out) );
    
    initial begin
        uvm_config_db #(virtual ALU_interface)::set(null,"*","vif",intif);
    end

    initial begin
        run_test("ALU_test");
    end

    initial begin
        forever begin
            #10
            Clock = ~Clock;
        end
    end

    initial begin
        #50000;
        $display("simulation Time end");
        $finish;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars();
    end
endmodule: top