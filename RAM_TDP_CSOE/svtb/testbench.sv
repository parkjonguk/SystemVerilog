`include "Environment.sv"
program test(ram_if _if);
   environment env;

   initial begin
      env =new(_if);
      env.run();
   end
endprogram // test
   
