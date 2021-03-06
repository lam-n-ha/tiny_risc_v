transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/instruction_parser.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/tiny_risc_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/instructions.v}

vlog -vlog01compat -work work +incdir+C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v {C:/Users/haln/Desktop/ECE289/tiny_risc_v/tiny_risc_v/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
