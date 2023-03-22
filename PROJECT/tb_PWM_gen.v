`timescale 1ns / 1ps
module tb_PWM_gen;  
 // Inputs
 reg clk;
 reg increase_duty;
 reg decrease_duty;
 reg reset;
 // Outputs
 wire PWM_OUT;
 //wire [3:0] dc,db,cnt;
 // Instantiate the PWM Generator with variable duty cycle in Verilog
 PWM_gen PWM_Generator_Unit(
  .clk(clk), 
  .increase_duty(increase_duty), 
  .decrease_duty(decrease_duty), 
  .reset(reset),
  .PWM_OUT(PWM_OUT)
  //.dc(dc),.db(db),.cnt(cnt)
 );
 // Create 100Mhz clock
 initial 
    begin
	//for creating vcd waveform file to view in gtkwave
	
	$dumpfile ("tb_PWM_gen.vcd"); //by default vcd
	$dumpvars(0, tb_PWM_gen);
    end
 initial begin
   clk = 0;
   reset=0;
 	 increase_duty = 0;
   decrease_duty = 0;
   
 forever #5 clk = ~clk;
 end 
initial begin
   #5 reset=1;
   #5 reset =0;

  #100; 
    increase_duty = 1; 
  #100;// increase duty cycle by 10%
    increase_duty = 0;
  #100; 
    increase_duty = 1;
  #100;// increase duty cycle by 10%
    increase_duty = 0;
  #100; 
    increase_duty = 1;
  #100;// increase duty cycle by 10%
    increase_duty = 0;
  #100; 
    increase_duty = 1; 
  #100;// increase duty cycle by 10%
    increase_duty = 0;
  #100; 
    increase_duty = 1;
  #100;// increase duty cycle by 10%
    increase_duty = 0;
  #200 reset =1;
  #5 reset = 0;
    decrease_duty = 1; 
  #100;//decrease duty cycle by 10%
    decrease_duty = 0;
  #100; 
    decrease_duty = 1;
  #100;//decrease duty cycle by 10%
    decrease_duty = 0;
  #100;
    decrease_duty = 1;
  #100;//decrease duty cycle by 10%
    decrease_duty = 0;
  #100;
    decrease_duty = 1; 
  #100;//decrease duty cycle by 10%
    decrease_duty = 0;
  #100; 
    decrease_duty = 1;
  #100;//decrease duty cycle by 10%
    decrease_duty = 0;
  #200 reset = 1;
  #5 reset = 0;
 end
 initial #2500 $finish;
endmodule

