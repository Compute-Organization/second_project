onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 40 Inputs
add wave -noupdate -color Magenta -height 40 -radix unsigned /tb_processing_unit_verilog/dataa_tb
add wave -noupdate -color {Cornflower Blue} -height 40 -radix unsigned /tb_processing_unit_verilog/datab_tb
add wave -noupdate -color Thistle -height 40 -radix binary /tb_processing_unit_verilog/selop_tb
add wave -noupdate -divider -height 40 Internal_Results
add wave -noupdate -color Gold -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/not_b
add wave -noupdate -color Lime -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/a_and_b
add wave -noupdate -color Orange -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/a_or_b
add wave -noupdate -color Violet -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/a_xor_b
add wave -noupdate -color Salmon -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/a_plus_b
add wave -noupdate -color Cyan -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/b_plus_one
add wave -noupdate -color White -height 40 -radix unsigned /tb_processing_unit_verilog/DUT/neg_b
add wave -noupdate -divider -height 40 Outputs
add wave -noupdate -color DeepSkyBlue -height 40 -radix unsigned /tb_processing_unit_verilog/result_tb
add wave -noupdate -color Green -height 40 -radix unsigned /tb_processing_unit_verilog/cout_tb
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 220
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
WaveRestoreZoom {0 ps} {2400 ns}
