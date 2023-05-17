read_liberty -lib /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/DC_WORKSHOP/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
read_verilog /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_design/PROJECT/PWM_gen.v
synth -top PWM_gen
dfflibmap -liberty /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/DC_WORKSHOP/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
opt -purge 
abc -liberty /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/DC_WORKSHOP/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
write_verilog -noattr PWM_gen_net13_ss_100C_1v60.v

