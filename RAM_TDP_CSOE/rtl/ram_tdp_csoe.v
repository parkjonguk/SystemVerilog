module ram_tdp_csoe (/*AUTOARG*/
   // Outputs
   dout_0, dout_1,
   // Inputs
   clk, cs_0, oe_0, we_0, addr_0, din_0, cs_1, oe_1, we_1, addr_1, din_1
   ) ;
   parameter DWIDTH =8;
   parameter AWIDTH = 4;
   parameter RDEPTH = 1<< AWIDTH;

   input clk;
   input cs_0;
   input oe_0;
   input we_0;
   input [AWIDTH-1:0] addr_0;
   input [DWIDTH-1:0] din_0;
   output reg [DWIDTH-1:0] dout_0;

   input               cs_1;
   input               oe_1;
   input               we_1;
   input [AWIDTH-1:0]  addr_1;
   input [DWIDTH-1:0]  din_1;
   output reg [DWIDTH-1:0] dout_1;

   reg [DWIDTH-1:0]        mem[RDEPTH-1:0];

   always @ (posedge clk) begin
      if(cs_0 && oe_0)
        dout_0 <= mem[addr_0];
   end

   always @(posedge clk) begin
      if(cs_1 && oe_1)
        dout_1 <= mem[addr_1];
   end

   always @ (posedge clk) begin
      if(cs_0 && we_0) begin
         mem[addr_0] <= din_0;
      end
      else if(cs_1 && we_1) begin
         mem[addr_1] <= din_1;
      end
   end
   
endmodule // ram_tdp_csoe
