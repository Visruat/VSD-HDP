read_liberty /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/DC_WORKSHOP/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
read_verilog ../netlists/PWM_gen_net13_ss_100C_1v60.v
link_design PWM_gen
read_sdc /home/pandabr07/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_design/PROJECT/PWM_gen.tcl
report_checks -verbose -path_delay min_max -fields {nets cap slew input_pins} -digits 4 > ss_100C_1v60_reps/PWM_gen_rep.rpt
report_wns -digits 4 > ss_100C_1v60_reps/wns
report_tns -digits 4 > ss_100C_1v60_reps/tns
report_worst_slack -digits 4 > ss_100C_1v60_reps/worst_slack
report_check_types -all_violators > ss_100C_1v60_reps/violations 
