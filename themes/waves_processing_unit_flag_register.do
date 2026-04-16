onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 32 Inputs
add wave -noupdate -color Yellow -height 32 /tb_processing_unit_flag_register/clk_tb
add wave -noupdate -color Red -height 32 /tb_processing_unit_flag_register/rst_tb
add wave -noupdate -color Orange -height 32 /tb_processing_unit_flag_register/enaf_tb
add wave -noupdate -color Magenta -height 32 -radix hexadecimal /tb_processing_unit_flag_register/dataa_tb
add wave -noupdate -color {Cornflower Blue} -height 32 -radix hexadecimal /tb_processing_unit_flag_register/datab_tb
add wave -noupdate -color Thistle -height 32 -radix binary /tb_processing_unit_flag_register/selop_tb
add wave -noupdate -divider -height 32 Processing_Unit
add wave -noupdate -color White -height 32 -radix hexadecimal /tb_processing_unit_flag_register/result_tb
add wave -noupdate -color Green -height 32 /tb_processing_unit_flag_register/cout_tb
add wave -noupdate -divider -height 32 Flag_Register
add wave -noupdate -color Green -height 32 /tb_processing_unit_flag_register/C_tb
add wave -noupdate -color Violet -height 32 /tb_processing_unit_flag_register/N_tb
add wave -noupdate -color Pink -height 32 /tb_processing_unit_flag_register/P_tb
add wave -noupdate -color White -height 32 /tb_processing_unit_flag_register/Z_tb
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 240
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 50
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreCursors {{Cursor 1} {200 ns} 0} {{Cursor 2} {250 ns} 0} {{Cursor 3} {800 ns} 0} {{Cursor 4} {850 ns} 0}
