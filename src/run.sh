iverilog *.v -o FUM_MIPS
vvp FUM_MIPS
gtkwave FUM_MIPS.vcd