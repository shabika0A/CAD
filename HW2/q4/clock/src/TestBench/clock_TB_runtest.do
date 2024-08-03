SetActiveLib -work
comp -include "$dsn\src\clock_with_alarm.vhd" 
comp -include "$dsn\src\TestBench\clock_TB.vhd" 
asim +access +r TESTBENCH_FOR_clock 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg set_clock
wave -noreg set_alarm
wave -noreg stop_alarm
wave -noreg setting_time_seconds
wave -noreg setting_time_minutes
wave -noreg setting_time_hours
wave -noreg alarm_signal
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\clock_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_clock 
