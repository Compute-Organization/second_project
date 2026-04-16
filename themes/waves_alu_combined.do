onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 32 Inputs
add wave -noupdate -color Yellow -height 32 /tb_alu_combined/clk_tb
add wave -noupdate -color Red -height 32 /tb_alu_combined/rst_tb
add wave -noupdate -color Orange -height 32 /tb_alu_combined/enaf_tb
add wave -noupdate -color Magenta -height 32 -radix hexadecimal /tb_alu_combined/busA_tb
add wave -noupdate -color {Cornflower Blue} -height 32 -radix hexadecimal /tb_alu_combined/busB_tb
add wave -noupdate -color Thistle -height 32 -radix binary /tb_alu_combined/selop_tb
add wave -noupdate -color Gold -height 32 -radix binary /tb_alu_combined/shamt_tb
add wave -noupdate -divider -height 32 Internal
add wave -noupdate -color White -height 32 -radix hexadecimal /tb_alu_combined/DUT/result
add wave -noupdate -color Green -height 32 /tb_alu_combined/DUT/cout
add wave -noupdate -divider -height 32 Outputs
add wave -noupdate -color Cyan -height 32 -radix hexadecimal /tb_alu_combined/busC_tb
add wave -noupdate -color Green -height 32 /tb_alu_combined/C_tb
add wave -noupdate -color Violet -height 32 /tb_alu_combined/N_tb
add wave -noupdate -color Pink -height 32 /tb_alu_combined/P_tb
add wave -noupdate -color White -height 32 /tb_alu_combined/Z_tb
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 210
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
WaveRestoreCursors {{Cursor 1} {200 ns} 0} {{Cursor 2} {250 ns} 0} {{Cursor 3} {850 ns} 0} {{Cursor 4} {950 ns} 0} {{Cursor 5} {1450 ns} 0}
WaveRestoreZoom {150 ns} {1050 ns}
