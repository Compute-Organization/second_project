onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 40 Inputs
add wave -noupdate -color Yellow -height 40 /tb_flag_register_verilog/clk_tb
add wave -noupdate -color Red -height 40 /tb_flag_register_verilog/rst_tb
add wave -noupdate -color Orange -height 40 /tb_flag_register_verilog/enaf_tb
add wave -noupdate -color {Cornflower Blue} -height 40 -radix binary /tb_flag_register_verilog/dataa_tb
add wave -noupdate -color Magenta -height 40 /tb_flag_register_verilog/carry_tb
add wave -noupdate -divider -height 40 Outputs
add wave -noupdate -color Green -height 40 /tb_flag_register_verilog/C_tb
add wave -noupdate -color Cyan -height 40 /tb_flag_register_verilog/N_tb
add wave -noupdate -color Violet -height 40 /tb_flag_register_verilog/P_tb
add wave -noupdate -color White -height 40 /tb_flag_register_verilog/Z_tb
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 180
configure wave -valuecolwidth 120
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
WaveRestoreZoom {0 ps} {6000 ns}
