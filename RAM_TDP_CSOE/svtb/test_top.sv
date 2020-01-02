`include "Interface.sv"
`include "testbench.sv"

module tb;
   bit clk;

   always #10 clk = ~clk;

   initial begin
      {clk,_if.rstn} <=0;
      #30 _if.rstn <=1;
   end
   ram_if _if(clk);
   test t1(_if);
   ram_tdp_csoe(.clk(clk),
                .cs_0(_if.cs_0),
                .oe_0(_if.oe_0),
                .we_0(_if.we_0),
                .addr_0(_if.addr_0),
                .din_0(_if.din_0),
                .cs_1(_if.cs_1),
                .oe_1(_if.oe_1),
                .we_0(_if.we_1),
                .addr_1(_if.addr_1),
                .din_1(_if.din_1)
                );
   initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
   end
endmodule // tb

