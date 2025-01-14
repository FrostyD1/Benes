Project: 8 x 8 Benes Network
Author: DONG TIANHAO
Date: 2025/01/14
Version: 2.0

Current Top Module: Benes_8p.v (pipelined version)
Current Top Simulation Files: Benes_8p_tb.v

For single test, use Benes_8_tb.v

File Generation: 
1. permutation.py -> n = 4 -> permutation_4.txt (All 4 x 4 Benes Network Solution)
2. benes_4_comb.py -> benes_4.v
3. permutation.py -> n = 8 -> permutation.txt (20000 test cases for 8 x 8 permutation)
4. state_matrix.py -> state_matrices.txt

Vivado Project Version: 2019.2
Constraint: CLK_cons.xdc
Current Clock Rate: 770 MHZ
Current WNS: +52 ps
Current WHS: +28 ps
Current TPWS: +0

When clk set at period 1.1ns, WNS, WHS still positive, but TPWS degraded, being confused how to inmprove TPWS.

Next Goal:
1. 16 x 16 and 32 x 32 version
2. Assembling 2x2 switches and apply routing results to simultate and verify.
3. Maybe look into OXC Switches implementation (Maybe RF or Analog design).
