SetActiveLib -work
comp -include "$dsn\src\serialReceiver.vhd" 
comp -include "$dsn\src\TestBench\serialreceiver_TB.vhd" 
asim +access +r TESTBENCH_FOR_serialreceiver 
wave 
wave -noreg clk
wave -noreg data_in
wave -noreg data_out
wave -noreg data_valid
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\serialreceiver_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_serialreceiver 
