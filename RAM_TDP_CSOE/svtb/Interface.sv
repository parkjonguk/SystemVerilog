interface ram_if(input logic clk,reset);
   parameter AWIDTH=4;
   parameter DWIDTH=8;

   logic              cs_0;
   logic              oe_0;
   logic [AWIDTH-1:0] addr_0;
   logic [DWIDTH-1:0] din_0;
   logic [DWIDTH-1:0] dout_0;
   
   logic              cs_1;
   logic              oe_1;
   logic [AWIDTH-1:0] addr_1;
   logic [DWIDTH-1:0] din_1;
   logic [DWIDTH-1:0] dout_1;

   clocking driver_cb @(posedge clk);
      default input $1ns output #1ns;
      output          cs_0;
      output          oe_0;
      output          addr_0;
      output          din_0;
      input           dout_0;

      output          cs_1;
      output          oe_1;
      output          addr_1;
      output          din_1;
      input           dout_1;

   endclocking // driver_cb

   clocking monitor_cb @(posedge clk);
      input           cs_0;
      input           oe_0;
      input           addr_0;
      input           din_0;
      output          dout_0;

      input           cs_1;
      input           oe_1;
      input           addr_1;
      input           din_1;
      output          dout_1;
   endclocking // monitor_cb

   modport DRIVER(clocking driver_cb,input clk,reset);
   modport MONITOR(clocking monitor_cb,input clk);
endinterface // ram_if

      
