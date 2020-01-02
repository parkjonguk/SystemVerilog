class driver;
   virtual switch_if vif;
   mailbox drv_mbx;
   event   drv_done;
   
   function new(virtual switch_if vif,mailbox drv_mbx,event drv_done);
      this.vif = vif;
      this.drv_mbx =drv_mbx;
      this.drv_done = drv_done;
      
   endfunction // new
   task run();
      $display ("T=%0t [Driver] Starting ...",$time);
      @(posedge vif.clk);
      forever begin
         transaction trans;
         $display("T=%0t [Driver] waiting for trans..." ,$time);
         drv_mbx.get(trans);
         trans.print("Driver");
         vif.vld <=1;
         vif.addr <= trans.addr;
         vif.data <= trans.data;
         @(posedge vif.clk);
         vif.vld <=0;
         ->drv_done;
      end // forever begin
   endtask // run
endclass // driver
