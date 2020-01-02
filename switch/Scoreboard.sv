class scoreboard;
   mailbox scb_mbx;


   function new(mailbox scb_mbx);
      this.scb_mbx = scb_mbx;
     endfunction
 
   task run();
      forever begin
         transaction trans;
         scb_mbx.get(trans);

        if(trans.addr inside {[0:'h3f]}) begin
            if(trans.addr_a != trans.addr | trans.data_a != trans.data)
              $display ("T=%0t [Scoreboard] ERROR! Mismatch addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", $time, trans.addr, trans.data, trans.addr_a, trans.data_a,trans);
            else
              $display ("T=%0t [Scoreboard] PASS! match addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", $time, trans.addr, trans.data, trans.addr_a, trans.data_a);
         end
         else begin
           if (trans.addr_b != trans.addr | trans.data_b != trans.data)
          $display ("T=%0t [Scoreboard] ERROR! Mismatch addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", $time, trans.addr, trans.data,trans.addr_b,trans.data_b);
        else
          $display ("T=%0t [Scoreboard] PASS! match addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", $time, trans.addr, trans.data, trans.addr_b, trans.data_b);
         end // else: !if(trans.addr inside {[0:`h3f]})
      end // forever begin
   endtask // run
endclass // scoreboard
