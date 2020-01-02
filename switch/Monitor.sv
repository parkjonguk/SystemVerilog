class monitor;

virtual switch_if vif;

mailbox scb_mbx;

semaphore sema;


function new(virtual switch_if vif,mailbox scb_mbx);

   this.vif = vif;

   this.scb_mbx = scb_mbx;

   sema = new(1);

      endfunction // new

task run();

   $display("T=%0t [Monitor] starting ... ",$time);


         fork
            sample_port("Thread0");

            sample_port("Thread1");

         join
      endtask // run

task sample_port(string tag="");

         forever begin
            @(posedge vif.clk);

                    if(vif.rstn & vif.vld) begin
                       transaction trans = new;

                       sema.get();

                       trans.addr = vif.addr;

                       trans.data = vif.data;

                       trans.addr_a= vif.addr_a;

                       trans.data_a= vif.data_a;

                       trans.addr_b= vif.addr_b;

                       trans.data_b= vif.data_b;

                       $display("T=%0t [Monitor] %s First part over",$time,tag);

                       @(posedge vif.clk);

                       sema.put();

                       $display("T=%0t [Monitor] %s Second part over",$time,tag);

                       scb_mbx.put(trans);

                       trans.print({"Monitor_",tag});

                                end // if (vif.DRIVER.clk & vif.DRIVER.vld)
                  end // forever begin
      endtask // sample_port
endclass // monitor~
            
