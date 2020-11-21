onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /top/duv/reset
add wave -noupdate -radix hexadecimal /top/duv/clk
add wave -noupdate -radix hexadecimal /top/duv/stall
add wave -noupdate -radix hexadecimal /top/duv/flush
add wave -noupdate -radix hexadecimal /top/duv/pc
add wave -noupdate -radix hexadecimal /top/duv/npc
add wave -noupdate -divider {ID stage}
add wave -noupdate -radix hexadecimal /top/duv/instruction
add wave -noupdate -radix hexadecimal /top/duv/b2v_regfile/ra1
add wave -noupdate -radix hexadecimal /top/duv/b2v_regfile/ra2
add wave -noupdate -radix hexadecimal /top/duv/id_rdA
add wave -noupdate -radix hexadecimal /top/duv/id_rdB
add wave -noupdate -radix hexadecimal /top/duv/id_imm
add wave -noupdate -radix hexadecimal -childformat {{{/top/duv/wr[4]} -radix hexadecimal} {{/top/duv/wr[3]} -radix hexadecimal} {{/top/duv/wr[2]} -radix hexadecimal} {{/top/duv/wr[1]} -radix hexadecimal} {{/top/duv/wr[0]} -radix hexadecimal}} -subitemconfig {{/top/duv/wr[4]} {-height 15 -radix hexadecimal} {/top/duv/wr[3]} {-height 15 -radix hexadecimal} {/top/duv/wr[2]} {-height 15 -radix hexadecimal} {/top/duv/wr[1]} {-height 15 -radix hexadecimal} {/top/duv/wr[0]} {-height 15 -radix hexadecimal}} /top/duv/wr
add wave -noupdate /top/duv/regDst
add wave -noupdate /top/duv/id_regWrite
add wave -noupdate -divider {EX stage}
add wave -noupdate -radix hexadecimal /top/duv/a
add wave -noupdate -radix hexadecimal /top/duv/b
add wave -noupdate -radix hexadecimal /top/duv/ex_forwardA
add wave -noupdate -radix hexadecimal /top/duv/ex_forwardB
add wave -noupdate -radix hexadecimal /top/duv/ex_src2
add wave -noupdate -radix hexadecimal /top/duv/ex_alucont
add wave -noupdate -radix hexadecimal /top/duv/ex_aluOut
add wave -noupdate /top/duv/ex_regWrite
add wave -noupdate -radix hexadecimal /top/duv/ex_rd
add wave -noupdate -radix hexadecimal /top/duv/pcTarget
add wave -noupdate /top/duv/ex_brTaken
add wave -noupdate -divider {MEM stage}
add wave -noupdate -radix hexadecimal /top/duv/dmem_in
add wave -noupdate -radix hexadecimal /top/duv/mem_aluOut
add wave -noupdate -radix hexadecimal /top/duv/mem_ldstBypass
add wave -noupdate -radix hexadecimal /top/duv/mem_memWrite
add wave -noupdate -radix hexadecimal /top/duv/mem_mo
add wave -noupdate -divider {WB stage}
add wave -noupdate -radix hexadecimal /top/duv/wb_memToReg
add wave -noupdate -radix hexadecimal /top/duv/wb_writeData
add wave -noupdate -radix hexadecimal /top/duv/wb_rd
add wave -noupdate -radix hexadecimal /top/duv/wb_regWrite
add wave -noupdate -divider Other
add wave -noupdate /top/cycle_counter
TreeUpdate [SetDefaultTree]
quietly wave cursor active 1
configure wave -namecolwidth 325
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {9153 ps} {12649 ps}
