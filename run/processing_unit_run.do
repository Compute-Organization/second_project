quit -sim
transcript on
set SIM_DIR [file dirname [info script]]
cd $SIM_DIR
puts "Running from: [pwd]"
if {[file exists work]} { vdel -lib work -all }
vlib work
vlog -reportprogress 300 +incdir+../design -work work ../design/full_adder.v
vlog -reportprogress 300 +incdir+../design -work work ../design/nbit_adder.v
vlog -reportprogress 300 +incdir+../design -work work ../design/add_sub.v
vlog -reportprogress 300 +incdir+../design -work work ../design/processing_unit.v
vlog -reportprogress 300 +incdir+../design -work work ../test/tb_processing_unit_verilog.v
vsim work.tb_processing_unit_verilog
do ../themes/wave_processing_unit.do
run 2.4 us
wave zoom full
