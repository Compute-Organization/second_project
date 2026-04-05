quit -sim
transcript on
set SIM_DIR [file dirname [info script]]
cd $SIM_DIR
puts "Running from: [pwd]"
if {[file exists work]} { vdel -lib work -all }
vlib work
vlog -reportprogress 300 +incdir+../design -work work ../design/shift_unit.v
vlog -reportprogress 300 +incdir+../design -work work ../test/tb_shift_unit_verilog.v
vsim work.tb_shift_unit_verilog
do ../themes/wave_shift_unit.do
run 1.5 us
wave zoom full
