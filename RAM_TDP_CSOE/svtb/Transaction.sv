class transaction;
   parameter DWIDTH =8;
   parameter AWIDTH =4;
   parameter RDEPTH = 1<<AWIDTH;

   rand bit [AWIDTH-1:0] addr_0;
   rand bit [DWIDTH-1:0] din_0;
   bit [DWIDTH-1:0] dout_0;

   rand bit[AWIDTH-1:0] addr_1;
   rand bit[DWIDTH-1:0] din_1;
   bit [DWIDTH-1:0] dout_1;

   constraint wr_addr{addr_0 != addr_1;};
 
   function void print(string tag="");
      #display("T=%0t [%s] addr_0=0x%0h din_0=0x%0h dout_0=0x%0h addr_1=0x%0h din_1=0x%0h dout_1=0x%0h",
               $time,tag,addr_0,din_0,dout_0,addr_1,din_1,dout_1);
   endfunction // print
endclass // transaction
