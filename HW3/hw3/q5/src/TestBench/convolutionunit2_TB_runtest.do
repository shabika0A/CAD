SetActiveLib -work
comp -include "$dsn\src\Convolution.vhd" 
comp -include "$dsn\src\TestBench\convolutionunit2_TB.vhd" 
asim +access +r TESTBENCH_FOR_convolutionunit 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg kernel
wave -noreg channel
wave -noreg result
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\convolutionunit2_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_convolutionunit 
