puts "==========================================="
puts " Running all ALU verification simulations "
puts "==========================================="

do shift_unit_run.do
quit -sim

do flag_register_run.do
quit -sim

do processing_unit_run.do
quit -sim

do alu_run.do
quit -sim

do pdua_instructions_run.do
quit -sim
