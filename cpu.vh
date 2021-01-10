`ifndef _cpu_vh_
`define _cpu_vh_ 

/* R200 section */

//r200 pipeline units
`include "r200_id.v"
`include "r200_if.v"
`include "r200_ex.v"
`include "r200_mem.v"
`include "r200_wb.v"

//pipeline reg units
`include "if_id_reg.v"
`include "id_ex_reg.v"
`include "ex_mem_reg.v"
`include "mem_wb_reg.v"

//pipeline control
`include "hazard.v"
`include "pc-cont.v"

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
`include "decode.v"
`include "pc.v"
`include "mem.v"
`include "dmem-nclk.v"
`include "regfile.v"



//sign extensions
`include "signex/signex12.v"
`include "signex/signex13.v"

//immediate handling
`include "utypeimm.v"
`include "ssignex.v"
`include "isignex.v"

//pc target generation
`include "jumptarggen-id.v"
`include "jumptarggen-ex.v"
`include "branchtarggen.v"

//comparitor
`include "comp.vh"


`endif
