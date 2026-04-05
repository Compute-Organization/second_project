quit -sim
transcript on
set SIM_DIR [file dirname [info script]]
cd $SIM_DIR
puts "Running from: [pwd]"
if {[file exists work]} { vdel -lib work -all }
vlib work
vlog -reportprogress 300 +incdir+../design -work work ../design/flag_register.v
vlog -reportprogress 300 +incdir+../design -work work ../test/tb_flag_register_verilog.v
vsim work.tb_flag_register_verilog
do ../themes/wave_flag_register.do
run 55 us
wave zoom full
