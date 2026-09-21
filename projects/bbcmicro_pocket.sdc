# ==============================================================================
# BBC Micro on the Pocket: timing constraints beyond the BSP's
# sys_constr.sdc. The 96 MHz system clock, its 16 MHz video pair and the
# shifted SDRAM clock all come from core_pll and are timed as one related
# group; the two 74.25 MHz inputs and the audio PLL are asynchronous to it.
# The PLL's fifth output drives nothing in core_top, so no clock of its own
# reaches the netlist and it is not named here -- naming it only bought an
# ignored-filter warning that hid the ones that mattered.
# ==============================================================================
set_clock_groups -asynchronous \
 -group { bridge_spiclk } \
 -group { clk_74a } \
 -group { clk_74b } \
 -group { ic|core_pll|core_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[2].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk } \
 -group { ic|pocket_audio_mixer|audio_pll|mf_audio_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk } \
 -group { ic|pocket_audio_mixer|audio_pll|mf_audio_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk }

# SDRAM: the chip is clocked by the phase-shifted PLL output (core_pll's
# outclk_3).  The shift divides the budget between two checks that pull
# opposite ways: the data the chip returns is captured by an I/O-cell register
# on the core clock, and the address and command the core drives are captured
# by the chip.  On the captured data, setup gets 2T - shift and hold gets
# T - shift, so a nanosecond off the shift is a nanosecond onto setup and a
# nanosecond off hold.
#
# THE SHIFT IS PER-DESIGN.  5.859 ns is where Master of Weapon's fit balanced
# (setup slack = 6.241 - shift at slow 85C, hold slack = shift - 5.519 at fast
# 0C); the board is the same for every core but the fit is not.  If the worst
# path in a build is dram_dq[*] -> sdram_ctrl|dq_in[*], measure both slacks at
# two shift values, solve for where they meet, and round to a multiple of
# 130.2 ps, the step the 960 MHz VCO can make.  projects/report_worst.tcl
# writes the reports to read: worst_paths*.txt for setup, worst_hold_fast.txt
# for hold.  METHODOLOGY.md section 5.20.
create_generated_clock -name dram_clk -source \
    [get_pins {ic|core_pll|core_pll_inst|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk}] \
    [get_ports {dram_clk}]
set_input_delay -max -clock dram_clk 7.0 [get_ports {dram_dq[*]}]
set_input_delay -min -clock dram_clk 2.5 [get_ports {dram_dq[*]}]
set SDRAM_OUT [get_ports {dram_a[*] dram_ba[*] dram_cke dram_dqm[*] dram_dq[*] dram_ras_n dram_cas_n dram_we_n}]
set_output_delay -max -clock dram_clk  1.5 $SDRAM_OUT
set_output_delay -min -clock dram_clk -0.8 $SDRAM_OUT
set_multicycle_path -setup 2 -from [get_clocks {dram_clk}] -to [get_registers {*|sdram_ctrl:*|dq_in[*]}]
set_multicycle_path -setup 3 -from [get_registers {*|sdram_ctrl:*|last[*]}] -to [get_registers {*|sdram_ctrl:*|*}]
set_multicycle_path -hold  2 -from [get_registers {*|sdram_ctrl:*|last[*]}] -to [get_registers {*|sdram_ctrl:*|*}]

# The pixel hand-over to the 16 MHz video clock -- the BBC's own dot clock,
# 96/6, so six system clocks a pixel. The dot enable's phase is
# pinned to clk_vid (core_top.sv's pix_sync into clk_enables.sv), so the
# colour and sync registers are launched a fixed number of system clocks
# before the clk_vid edge that samples them, and the setup check starts from
# that launch edge. The toggle the other way (vt -> vt_s) is a plain
# flop-to-flop path, checked as it stands.
set VID_OUT [get_registers {ic|vr_q[*] ic|vg_q[*] ic|vb_q[*] ic|vhs_q ic|vvs_q ic|vde_q}]
set_multicycle_path -setup 3 -start -from [get_clocks {ic|core_pll|core_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to $VID_OUT
set_multicycle_path -hold  2 -start -from [get_clocks {ic|core_pll|core_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to $VID_OUT

# SRAM: unused by this core (docs/core-design.md section 2) -- a disc image
# does not fit in 128 KB and everything else is block RAM.  The pins are still
# brought out by the BSP, and are not timed against a clock.
set_false_path -to   [get_ports {sram_*}]
set_false_path -from [get_ports {sram_dq[*]}]

# The PSRAMs are unused on this board; the BSP still brings their pins out.
set_false_path -to   [get_ports {cram0_* cram1_*}]
set_false_path -from [get_ports {cram0_dq[*] cram1_dq[*] cram0_wait cram1_wait}]

# ------------------------------------------------------------------------------
# The 6502 steps on a clock enable, and its internal paths are the only ones
# in this design that miss 96 MHz.  Measured, before this exception: setup
# slack -1.577 ns on the core clock with TNS -26.314, and every one of the 40
# violating paths was T65 -> T65 (n838 -> n822 and neighbours).  Nothing else
# in the machine violated at all.
#
# Why everything this filter matches qualifies (METHODOLOGY 5.11, 5.20):
#
#   * T65's state is in four clocked processes and every one of them is inside
#     `if (Enable = '1')` (modules/cpu-t65/T65.vhd, lines 353, 440, 532, 672).
#     Enable is cpu_cen, one system clock in 48 at 2 MHz and one in 96 while a
#     1 MHz cycle is stretched, so a value launched by one enable is not
#     sampled until the next -- 48 clocks later, not 4.
#   * The fifth clocked process, at line 322, is the two-flop reset
#     synchroniser (Res_n_d, Res_n_i) and is NOT gated by Enable.  It is two
#     flops in series with no logic between them, so it cannot fail at any
#     multicycle; its output is an asynchronous reset, whose release the CPU
#     then sits behind for 256 more cpu_cen ticks (rtl/bbcmicro_core.sv's
#     rst_cnt), which is at least 12,288 system clocks.
#   * Only T65 -> T65 is relaxed.  Everything crossing the boundary -- DI,
#     IRQ_n, NMI_n, Rdy in; A, DO, R_W_n, Sync out -- keeps the full
#     single-cycle check, so the registers at the edge of the relaxed region
#     are checked as they stand.
#
# If this line ever matches nothing, CI fails the build on it ("Check every
# constraint was applied"), which is the point: a 6502 that quietly stopped
# being relaxed would be a 96 MHz path again.
set T65 [get_keepers {*|T65:*|*}]
set_multicycle_path -setup 4 -from $T65 -to $T65
set_multicycle_path -hold  3 -from $T65 -to $T65
