onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 40 Inputs
add wave -noupdate -color Magenta -height 40 -radix binary   /tb_shift_unit_verilog/shamt_tb
add wave -noupdate -color {Cornflower Blue} -height 40 -radix binary /tb_shift_unit_verilog/dataa_tb
add wave -noupdate -divider -height 40 Outputs
add wave -noupdate -color Cyan -height 40 -radix binary /tb_shift_unit_verilog/dataout_tb
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
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1400 ns}
