`define MON_IF vif.MONITOR.monitor_cb
class monitor;
   virtual ram_if vif;
   mailbox scb_mbx;
   semaphore sema;

   mailbox   mon_mbx;
   
   function new(virtual ram_if vif,mailbox scb_mbx);
      this.vif = vif;
      this.scb_mbx = scb_mbx;
      sema = new(1);
   endfunction // new

   task run();
      $display("T=%0t [Monitor] starting ...",$time);
     // @(posedge vif.MONITOR.clk);
      fork
         fetch();
         excution();
       join
      endtask // run

   task fetch();
      transaction trans;
      trans = new();
      forever begin
         sema.get(1);
         trans.cs_0 = `MON_IF.cs_0;
         trans.cs_1 = `MON_IF.cs_1;
         trans.oe_0 = `MON_IF.oe_0;
         trans.oe_1 = `MON_IF.oe_1;
         trans.we_0 = `MON_IF.we_0;
         trans.we_1 = `MON_IF.we_1;
         trans.addr_0 = `MON_IF.addr_0;
         trans.addr_1 = `MON_IF.addr_1;
         trans.din_0 = `MON_IF.din_0;
         trans.din_1 = `MON_IF.din_1;
         mon_mbx.put(trans);
         sema.put(2);
        $display("T=%0t [Monitor] Data and Address Fetch  ",$time);
         @(posedge vif.MONITOR.clk);
      end // forever begin
   endtask // fetch

   task excute();
      transaction trans;
      forever begin
         sema.get(2);
         mon_mbx.get(trans);
         @(posedge vif.MONITOR.clk);
         trans.dout_0 = `MON_IF.dout_0;
         trans.dout_1 = `MON_IF.dout_1;
        $display("T=%0t [Monitor] Data Excute    dout_0 = 0x%0h dout_1 = 0x%0h",$time,trans.dout_0,trans.dout_1);
         scb_mbx.put(trans);
         sema.put(1);
      end // forever begin
   endtask // excute
   
         
         
         
