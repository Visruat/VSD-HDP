module PWM_gen
 (
 clk, // 100MHz clock input 
 increase_duty, // input to increase 10% duty cycle 
 decrease_duty, // input to decrease 10% duty cycle
 reset, 
 PWM_OUT // 10MHz PWM output signal 
    );
 
 input clk,reset;
 input increase_duty;
 input decrease_duty;
 output PWM_OUT;
 wire slow_clk_enable; // slow clock enable signal for debouncing FFs(40MHz)
 reg[27:0] counter_debounce;// counter for creating slow clock enable signals 
 reg tmp1,tmp2;// temporary flip-flop signals for debouncing the increasing button
 reg tmp3,tmp4;// temporary flip-flop signals for debouncing the decreasing button
 wire duty_inc, duty_dec;
 reg[3:0] counter_PWM;
 reg[3:0] DUTY_CYCLE; 
  // Debouncing 2 buttons for inc/dec duty cycle 
  // Firstly generate slow clock enable for debouncing flip-flop 
  
 always @(posedge clk or posedge reset)
 begin
 if(reset) begin
 counter_debounce<=28'd0;
  counter_PWM<=4'd0;// counter for creating 10Mhz PWM signal
  DUTY_CYCLE<=4'd5;// initial duty cycle is 50%
  tmp1 <= 0;
  tmp2 <= 0;
  tmp3<=0;
  tmp4<=0;
  end
 else begin
 	counter_debounce <= counter_debounce>=28'd1 ? 28'd0 : counter_debounce + 28'd1;
 	if(duty_inc==1 && DUTY_CYCLE <= 9) begin
        DUTY_CYCLE <= DUTY_CYCLE + 4'd1;// increase duty cycle by 10%
        end
        else if(duty_dec==1 && DUTY_CYCLE>=1) begin
        //else begin
        DUTY_CYCLE <= DUTY_CYCLE - 4'd1;
        end//decrease duty cycle by 10%
        counter_PWM <= counter_PWM + 4'd1;
        if(counter_PWM>=9) begin
        counter_PWM <= 0;
        end
        if(slow_clk_enable==1) begin// slow clock enable signal 
  	tmp1 <= increase_duty;
  	tmp2 <= tmp1;
  	tmp3 <= decrease_duty;
  	tmp4 <= tmp3;
  	end
    end
 end
 
 assign slow_clk_enable = counter_debounce == 1 ?1:0;
  
 assign duty_inc =  tmp1 & (~ tmp2) & slow_clk_enable;
  
 assign duty_dec =  tmp3 & (~ tmp4) & slow_clk_enable;
 
 assign PWM_OUT = counter_PWM < DUTY_CYCLE ? 1:0;
 
endmodule
