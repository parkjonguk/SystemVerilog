`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

class environment;
   driver d0;
   generator g0;
   monitor m0;
   scoreboard s0;
   mailbox drv_mbx;
   mailbox scb_mbx;
   event   drv_done;
   virtual ram_if vif;

  function new(virtual ram_if vif);
      this.vif = vif;
      drv_mbx = new();
      scb_mbx = new();
      d0 = new(vif,drv_mbx,drv_done);
      g0 = new(drv_mbx,drv_done);
      m0 = new(vif,scb_mbx);
      s0 = new(scb_mbx);
   endfunction // new

   task run();
      pre_test();
      fork
         d0.run();
         m0.run();
         g0.run();
         s0.run();
      join_any
   endtask // run

   task pre_test();
      d0.reset();
   endtask // pre_test
endclass // environment
