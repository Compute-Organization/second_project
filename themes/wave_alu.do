onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 40 Inputs
add wave -noupdate -color Yellow -height 40 /tb_alu_verilog/clk_tb
add wave -noupdate -color Red -height 40 /tb_alu_verilog/rst_tb
add wave -noupdate -color Orange -height 40 /tb_alu_verilog/enaf_tb
add wave -noupdate -color Magenta -height 40 -radix unsigned /tb_alu_verilog/busA_tb
add wave -noupdate -color {Cornflower Blue} -height 40 -radix unsigned /tb_alu_verilog/busB_tb
add wave -noupdate -color Thistle -height 40 -radix binary /tb_alu_verilog/selop_tb
add wave -noupdate -color Gold -height 40 -radix binary /tb_alu_verilog/shamt_tb
add wave -noupdate -divider -height 40 Internal
add wave -noupdate -color White -height 40 -radix unsigned /tb_alu_verilog/DUT/result
add wave -noupdate -color Green -height 40 /tb_alu_verilog/DUT/cout
add wave -noupdate -divider -height 40 Outputs
add wave -noupdate -color Cyan -height 40 -radix unsigned /tb_alu_verilog/busC_tb
add wave -noupdate -color Green -height 40 /tb_alu_verilog/C_tb
add wave -noupdate -color Violet -height 40 /tb_alu_verilog/N_tb
add wave -noupdate -color Pink -height 40 /tb_alu_verilog/P_tb
add wave -noupdate -color White -height 40 /tb_alu_verilog/Z_tb
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 200
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
WaveRestoreZoom {0 ps} {2200 ns}
