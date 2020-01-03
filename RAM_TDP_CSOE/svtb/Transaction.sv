`include "Environment.sv"
program test(ram_if if2);
  
   environment env;
   
   initial begin
     env = new(if2);
      env.g0.num = 10;
      env.run();
   end
endprogram // test
   