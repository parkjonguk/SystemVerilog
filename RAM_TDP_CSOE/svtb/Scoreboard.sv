class scoreboard;
   parameter DWIDTH = 8;
   parameter AWIDTH = 4;
   parameter RDEPTH = 1<<AWIDTH;
   
   mailbox scb_mbx;

   bit [DWIDTH-1:0] mem [RDEPTH-1:0];

   
   function new(mailbox scb_mbx);
   endfunction // new

   task run();
    forever begin
       transaction trans;
       scb_mbx.get(trans);

       if(trans.cs_0 && trans.oe_0) begin
          if(trans.dout_0 == mem[trans.addr_0])begin
            $display("T=%0t [Scoreboard] Read Data And Match addr_0 = 0x%0h data = 0x%0h ",$time,trans.addr_0,trans.dout_0);
          end
  
          else begin
             $display("T=%0t [Scoreboard] Error ! Mismatch dout and mem [data] addr_0 = 0x%0h [dout_0 = 0x%0h  meme[trnas.addr_0]=0x%0h]",$time,trans.addr_0,trnas.dout_0,mem[trans.addr_0]);
          end
       end
          
       if(trans.cs_1 && trans.oe_1) begin
          if(trans.dout_1 == mem[trans.addr_1])begin
             $display("T=%0t [Scoreboard] Read Data And Match addr_1 = 0x%0h data = 0x%0h ",$time,trans.addr_1,trans.dout_1);
          end
          
          else begin
             $display("T=%0t [Scoreboard] Error ! Mismatch dout and mem [data] addr_1 = 0x%0h [dout_1 = 0x%0h  meme[trnas.addr_1]=0x%0h]",$time,trans.addr_1,trnas.dout_1,mem[trans.addr_1]);
          end
       end

       if(trans.cs_0 && trans.wr_0) begin
          mem[trans.addr_0] = trans.din_0;
          $display("T=%0t [Scoreboard] Write Data_0 !! addr_0=0x%0h din_0 = 0x%0h mem[addr_0]=0x%0h",$time,trans.addr_0,trans.din_0,mem[trans.addr_0]);
       end
       else if(trans.cs_1 && trans.wr_1) begin
          mem[trans.addr_1] = trans.din_1;
          $display("T=%0t [Scoreboard] Write Data_1 !! addr_1=0x%0h din_1=0x%0h mem[addr_1]=0x%0h",$time,trans.addr_1,trans.din_1,mem[trnas.addr_1]);
       end
    end // forever begin
   endtask // run
endclass // scoreboard
