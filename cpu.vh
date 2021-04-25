`ifndef _cpu_vh_
`define _cpu_vh_ 

/* R200 section */

//r200 pipeline units
`include "fu/r200id.v"
`include "fu/r200if.v"
`include "fu/r200ex.v"
`include "fu/r200mem.v"
`include "fu/r200wb.v"

//pipeline reg units
`include "pipereg/if_id_reg.v"
`include "pipereg/id_ex_reg.v"
`include "pipereg/ex_mem_reg.v"
`include "pipereg/mem_wb_reg.v"

//pipeline control
`include "pipecont/hazard.v"
`include "pipecont/pc-cont.v"

/* ALU SECTION */

//logical
`include "alu/not32.v"
`include "alu/or32.v"
`include "alu/xor32.v"
`include "alu/and32.v"
`include "alu/and32s.v"

//adder
`include "alu/adder32.v"
`include "alu/adder.v"

//shifter
`include "alu/shifter/mshifter32.v"
`include "alu/shifter/shifter32b1.v"
`include "alu/shifter/shifter32b2.v"
`include "alu/shifter/shifter32b4.v"
`include "alu/shifter/shifter32b8.v"
`include "alu/shifter/shifter32b16.v"

//alu unit
`include "alu/alu.v"
`include "alu/alucont.v"
/* END ALU SECTION */


`include "mux.vh"
`include "decode/decoder.v"
`include "pc/pc.v"
`include "mem/mem.v"
`include "mem/dmem-nclk.v"
`include "decode/regfile.v"



//sign extensions
`include "signex/signex12.v"
`include "signex/signex13.v"

//immediate handling
`include "decode/utypeimm.v"
`include "signex/ssignex.v"
`include "signex/isignex.v"

//pc target generation
`include "pc/jumptarggen-id.v"
`include "pc/jumptarggen-ex.v"
`include "pc/branchtarggen.v"

//comparitor
`include "comp.vh"


`endif
