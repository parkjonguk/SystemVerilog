class generator;
   int look = 10;
   event drv_done;
   mailbox drv_mbx;

   task run();
      for(int i=0; i<loop; i++) begin
         packet item = new;
         item.randomize();
         $display ("T=%0t [Generator] Loop:%0d/%0d create next item",$time,i+1,loop);
         drv_mbx.put(item);
         $display("T=%0t [Generator] wait for driver to be done",$time);
         @(drv_done);
      end
   endtask // run
endclass // generator
