`define DRIV_IF vif.DRIVER.driver_cb

class driver;
   virtual ram_if vif;
   mailbox drv_mbx;
   event   drv_done;
   int     no_transaction;
   
   function new(virtual ram_if vif,mailbox drv_mbx, event drv_done);
      this.vif = vif;
      this.drv_mbx = drv_mbx;
      this.drv_done = drv_done;
   endfunction // new

   task reset();
      wait(vif.rstn);
      $display("T=%0t [DRIVER] RESET!!!",$time);
      `DRIV_IF.cs_0 <= 0;
      `DRIV_IF.oe_0 <= 0;
      `DRIV_IF.we_0 <= 0;
      `DRIV_IF.addr_0 <=0;
      `DRIV_IF.din_0 <=0;
      wait(!vif.rstn);
      $display("T=%0t [DRIVER] RESET END !!!",$time);
   endtask; // reset
   
      
   task run();
      $display ("T=%0t [Driver] Starting...");
      forever begin
         transaction trans;
        $display("T=%0t [Driver] waiting for trans....",$time);
         drv_mbx.get(trans);
         trans.print("Driver");
         @(posedge vif.DRIVER.clk);
         `DRIV_IF.cs_0 <= trans.cs_0;
         `DRIV_IF.cs_1 <= trnas.cs_1;
         
         if(trans.cs_0 && trans.oe_0) begin
            `DRIV_IF.oe_0 <=trans.oe_0;
            `DRIV_IF.addr_0 <=trans.addr_0;
            `DRIV_IF.dout_0 <=trans.dout_0;
            $display("T=%0t [DRIVER] READ_0 Transaction");
            
         end
         else if(trans.cs_0 && trans.we_0) begin
            `DRIV_IF.we_0 <= trans.we_0;
            `DRIV_IF.addr_0 <= trnas.addr_0;
            `DRIV_IF.mem[addr_0] <= trans.din_0;
            $display("T=%0t [DRIVER] WRITE_0 Transaction");
         end

         else if(trans.cs_1 && trans.oe_1) begin
            `DRIV_IF.oe_1 <=trans.oe_1;
            `DRIV_IF.addr_1 <=trans.addr_1;
            `DRIV_IF.dout_1 <=trans.dout_1;
            $display("T=%0t [DRIVER] READ_1 Transaction");
            
         end
         else if(trans.cs_1 && trans.we_1) begin
            `DRIV_IF.we_1 <= trans.we_1;
            `DRIV_IF.addr_1 <= trnas.addr_1;
            `DRIV_IF.mem[addr_1] <= trans.din_1;
            $display("T=%0t [DRIVER] WRITE_1 Transaction");
         end
         @(posedge vif_DRIVER.clk);
         `DRIV_IF.cs_0 <= 0;
         `DRIV_IF.oe_0 <= 0;
         `DRIV_IF.we_0 <= 0;

         `DRIV_IF.cs_1 <= 0;
         `DRIV_IF.oe_1 <= 0;
         `DRIV_IF.we_1 <= 0;
         
         no_transaction++;
         ->drv_done;
      end // forever begin
   endtask // run
endclass // driver
