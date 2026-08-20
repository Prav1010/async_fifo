// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Thu Aug 20 15:29:15 2026
// Host        : Prav11 running 64-bit major release  (build 9200)
// Command     : write_verilog -force ./reports/async_fifo_synth.v
// Design      : async_fifo
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ADDR_WIDTH = "4" *) (* DATA_WIDTH = "8" *) (* DEPTH = "16" *) 
(* PTR_WIDTH = "5" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module async_fifo
   (wr_clk,
    wr_rst_n,
    wr_en,
    wr_data,
    full,
    almost_full,
    rd_clk,
    rd_rst_n,
    rd_en,
    rd_data,
    empty,
    almost_empty);
  input wr_clk;
  input wr_rst_n;
  input wr_en;
  input [7:0]wr_data;
  output full;
  output almost_full;
  input rd_clk;
  input rd_rst_n;
  input rd_en;
  output [7:0]rd_data;
  output empty;
  output almost_empty;

  wire \<const0> ;
  wire almost_empty;
  wire almost_empty_comb;
  wire almost_full;
  wire almost_full_comb;
  wire empty;
  wire full;
  wire [2:2]gray2bin2_return__3;
  wire [2:2]gray2bin_return__3;
  wire p_25_in;
  wire rd_clk;
  wire [7:0]rd_data;
  wire [7:0]rd_data0;
  wire rd_en;
  wire [4:0]rd_ptr_gray;
  wire [4:0]rd_ptr_gray_sync;
  wire rd_rst_n;
  wire u_rd_ptr_n_0;
  wire u_rd_ptr_n_1;
  wire u_rd_ptr_n_2;
  wire u_rd_ptr_n_3;
  wire u_rd_ptr_n_9;
  wire u_sync_rd2wr_n_7;
  wire u_sync_wr2rd_n_0;
  wire u_wr_ptr_n_0;
  wire u_wr_ptr_n_1;
  wire u_wr_ptr_n_11;
  wire u_wr_ptr_n_2;
  wire u_wr_ptr_n_3;
  wire wr_clk;
  wire [7:0]wr_data;
  wire wr_en;
  wire wr_incr;
  wire [4:0]wr_ptr_gray;
  wire [4:0]wr_ptr_gray_sync;
  wire wr_rst_n;

  GND GND
       (.G(\<const0> ));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M mem_reg_0_15_0_5
       (.ADDRA({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRB({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRC({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRD({\<const0> ,u_wr_ptr_n_0,u_wr_ptr_n_1,u_wr_ptr_n_2,u_wr_ptr_n_3}),
        .DIA(wr_data[1:0]),
        .DIB(wr_data[3:2]),
        .DIC(wr_data[5:4]),
        .DID({\<const0> ,\<const0> }),
        .DOA(rd_data0[1:0]),
        .DOB(rd_data0[3:2]),
        .DOC(rd_data0[5:4]),
        .WCLK(wr_clk),
        .WE(wr_incr));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  RAM32M mem_reg_0_15_6_7
       (.ADDRA({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRB({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRC({\<const0> ,u_rd_ptr_n_0,u_rd_ptr_n_1,u_rd_ptr_n_2,u_rd_ptr_n_3}),
        .ADDRD({\<const0> ,u_wr_ptr_n_0,u_wr_ptr_n_1,u_wr_ptr_n_2,u_wr_ptr_n_3}),
        .DIA(wr_data[7:6]),
        .DIB({\<const0> ,\<const0> }),
        .DIC({\<const0> ,\<const0> }),
        .DID({\<const0> ,\<const0> }),
        .DOA(rd_data0[7:6]),
        .WCLK(wr_clk),
        .WE(wr_incr));
  FDCE \rd_data_reg[0] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[0]),
        .Q(rd_data[0]));
  FDCE \rd_data_reg[1] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[1]),
        .Q(rd_data[1]));
  FDCE \rd_data_reg[2] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[2]),
        .Q(rd_data[2]));
  FDCE \rd_data_reg[3] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[3]),
        .Q(rd_data[3]));
  FDCE \rd_data_reg[4] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[4]),
        .Q(rd_data[4]));
  FDCE \rd_data_reg[5] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[5]),
        .Q(rd_data[5]));
  FDCE \rd_data_reg[6] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[6]),
        .Q(rd_data[6]));
  FDCE \rd_data_reg[7] 
       (.C(rd_clk),
        .CE(u_rd_ptr_n_9),
        .CLR(u_sync_wr2rd_n_0),
        .D(rd_data0[7]),
        .Q(rd_data[7]));
  fifo_flags u_flags_rd
       (.almost_empty(almost_empty),
        .almost_empty_comb(almost_empty_comb),
        .rd_clk(rd_clk),
        .rd_rst_n(u_sync_wr2rd_n_0));
  fifo_flags_0 u_flags_wr
       (.almost_full(almost_full),
        .almost_full_comb(almost_full_comb),
        .wr_clk(wr_clk),
        .wr_rst_n(u_sync_rd2wr_n_7));
  fifo_ptr u_rd_ptr
       (.Q(wr_ptr_gray_sync),
        .almost_empty_comb(almost_empty_comb),
        .empty(empty),
        .gray2bin2_return__3(gray2bin2_return__3),
        .\gray_ptr_reg[3]_0 (u_rd_ptr_n_0),
        .\gray_ptr_reg[3]_1 (u_rd_ptr_n_1),
        .\gray_ptr_reg[3]_2 (u_rd_ptr_n_2),
        .\gray_ptr_reg[3]_3 (u_rd_ptr_n_3),
        .rd_clk(rd_clk),
        .\rd_data_reg[7] (u_rd_ptr_n_9),
        .rd_en(rd_en),
        .rd_ptr_gray(rd_ptr_gray),
        .rd_rst_n(u_sync_wr2rd_n_0));
  cdc_sync u_sync_rd2wr
       (.D(rd_ptr_gray),
        .Q(rd_ptr_gray_sync),
        .almost_full_comb(almost_full_comb),
        .gray2bin_return__3(gray2bin_return__3),
        .\gray_ptr_reg[1] (u_wr_ptr_n_11),
        .p_25_in(p_25_in),
        .\sync_ff_reg[1][0]_0 (u_sync_rd2wr_n_7),
        .wr_clk(wr_clk),
        .wr_ptr_gray({wr_ptr_gray[4:3],wr_ptr_gray[1:0]}),
        .wr_rst_n(wr_rst_n));
  cdc_sync_1 u_sync_wr2rd
       (.Q(wr_ptr_gray_sync),
        .gray2bin2_return__3(gray2bin2_return__3),
        .rd_clk(rd_clk),
        .rd_rst_n(rd_rst_n),
        .\sync_ff_reg[0][0]_0 (u_sync_wr2rd_n_0),
        .wr_ptr_gray(wr_ptr_gray));
  fifo_ptr_2 u_wr_ptr
       (.Q(rd_ptr_gray_sync),
        .almost_full_reg(u_wr_ptr_n_11),
        .full(full),
        .gray2bin_return__3(gray2bin_return__3),
        .\gray_ptr_reg[1]_0 (u_wr_ptr_n_1),
        .\gray_ptr_reg[1]_1 (u_wr_ptr_n_2),
        .\gray_ptr_reg[1]_2 (u_wr_ptr_n_3),
        .\gray_ptr_reg[2]_0 (u_wr_ptr_n_0),
        .p_25_in(p_25_in),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_incr(wr_incr),
        .wr_ptr_gray(wr_ptr_gray),
        .wr_rst_n(u_sync_rd2wr_n_7));
endmodule

module cdc_sync
   (almost_full_comb,
    Q,
    p_25_in,
    \sync_ff_reg[1][0]_0 ,
    wr_ptr_gray,
    \gray_ptr_reg[1] ,
    gray2bin_return__3,
    wr_rst_n,
    D,
    wr_clk);
  output almost_full_comb;
  output [4:0]Q;
  output p_25_in;
  output \sync_ff_reg[1][0]_0 ;
  input [3:0]wr_ptr_gray;
  input \gray_ptr_reg[1] ;
  input [0:0]gray2bin_return__3;
  input wr_rst_n;
  input [4:0]D;
  input wr_clk;

  wire \<const1> ;
  wire [4:0]D;
  wire [4:0]Q;
  wire almost_full_comb;
  wire almost_full_i_3_n_0;
  wire [0:0]gray2bin_return__3;
  wire \gray_ptr_reg[1] ;
  wire p_25_in;
  wire [4:0]\sync_ff_reg[0] ;
  wire \sync_ff_reg[1][0]_0 ;
  wire wr_clk;
  wire [3:0]wr_ptr_gray;
  wire wr_rst_n;

  VCC VCC
       (.P(\<const1> ));
  LUT6 #(
    .INIT(64'h721BE48D7B9FF6ED)) 
    almost_full_i_1
       (.I0(almost_full_i_3_n_0),
        .I1(Q[3]),
        .I2(Q[4]),
        .I3(wr_ptr_gray[2]),
        .I4(wr_ptr_gray[3]),
        .I5(\gray_ptr_reg[1] ),
        .O(almost_full_comb));
  LUT1 #(
    .INIT(2'h1)) 
    almost_full_i_2
       (.I0(wr_rst_n),
        .O(\sync_ff_reg[1][0]_0 ));
  LUT6 #(
    .INIT(64'hBBFB31113BFF3301)) 
    almost_full_i_3
       (.I0(Q[1]),
        .I1(p_25_in),
        .I2(Q[0]),
        .I3(wr_ptr_gray[1]),
        .I4(gray2bin_return__3),
        .I5(wr_ptr_gray[0]),
        .O(almost_full_i_3_n_0));
  LUT3 #(
    .INIT(8'h96)) 
    almost_full_i_5
       (.I0(Q[2]),
        .I1(Q[4]),
        .I2(Q[3]),
        .O(p_25_in));
  FDCE \sync_ff_reg[0][0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(D[0]),
        .Q(\sync_ff_reg[0] [0]));
  FDCE \sync_ff_reg[0][1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(D[1]),
        .Q(\sync_ff_reg[0] [1]));
  FDCE \sync_ff_reg[0][2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(D[2]),
        .Q(\sync_ff_reg[0] [2]));
  FDCE \sync_ff_reg[0][3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(D[3]),
        .Q(\sync_ff_reg[0] [3]));
  FDCE \sync_ff_reg[0][4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(D[4]),
        .Q(\sync_ff_reg[0] [4]));
  FDCE \sync_ff_reg[1][0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(\sync_ff_reg[0] [0]),
        .Q(Q[0]));
  FDCE \sync_ff_reg[1][1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(\sync_ff_reg[0] [1]),
        .Q(Q[1]));
  FDCE \sync_ff_reg[1][2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(\sync_ff_reg[0] [2]),
        .Q(Q[2]));
  FDCE \sync_ff_reg[1][3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(\sync_ff_reg[0] [3]),
        .Q(Q[3]));
  FDCE \sync_ff_reg[1][4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[1][0]_0 ),
        .D(\sync_ff_reg[0] [4]),
        .Q(Q[4]));
endmodule

(* ORIG_REF_NAME = "cdc_sync" *) 
module cdc_sync_1
   (\sync_ff_reg[0][0]_0 ,
    gray2bin2_return__3,
    Q,
    rd_rst_n,
    wr_ptr_gray,
    rd_clk);
  output \sync_ff_reg[0][0]_0 ;
  output [0:0]gray2bin2_return__3;
  output [4:0]Q;
  input rd_rst_n;
  input [4:0]wr_ptr_gray;
  input rd_clk;

  wire \<const1> ;
  wire [4:0]Q;
  wire [0:0]gray2bin2_return__3;
  wire rd_clk;
  wire rd_rst_n;
  wire \sync_ff_reg[0][0]_0 ;
  wire \sync_ff_reg_n_0_[0][0] ;
  wire \sync_ff_reg_n_0_[0][1] ;
  wire \sync_ff_reg_n_0_[0][2] ;
  wire \sync_ff_reg_n_0_[0][3] ;
  wire \sync_ff_reg_n_0_[0][4] ;
  wire [4:0]wr_ptr_gray;

  VCC VCC
       (.P(\<const1> ));
  LUT3 #(
    .INIT(8'h96)) 
    almost_empty_i_5
       (.I0(Q[2]),
        .I1(Q[4]),
        .I2(Q[3]),
        .O(gray2bin2_return__3));
  LUT1 #(
    .INIT(2'h1)) 
    \rd_data[7]_i_2 
       (.I0(rd_rst_n),
        .O(\sync_ff_reg[0][0]_0 ));
  FDCE \sync_ff_reg[0][0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(wr_ptr_gray[0]),
        .Q(\sync_ff_reg_n_0_[0][0] ));
  FDCE \sync_ff_reg[0][1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(wr_ptr_gray[1]),
        .Q(\sync_ff_reg_n_0_[0][1] ));
  FDCE \sync_ff_reg[0][2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(wr_ptr_gray[2]),
        .Q(\sync_ff_reg_n_0_[0][2] ));
  FDCE \sync_ff_reg[0][3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(wr_ptr_gray[3]),
        .Q(\sync_ff_reg_n_0_[0][3] ));
  FDCE \sync_ff_reg[0][4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(wr_ptr_gray[4]),
        .Q(\sync_ff_reg_n_0_[0][4] ));
  FDCE \sync_ff_reg[1][0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(\sync_ff_reg_n_0_[0][0] ),
        .Q(Q[0]));
  FDCE \sync_ff_reg[1][1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(\sync_ff_reg_n_0_[0][1] ),
        .Q(Q[1]));
  FDCE \sync_ff_reg[1][2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(\sync_ff_reg_n_0_[0][2] ),
        .Q(Q[2]));
  FDCE \sync_ff_reg[1][3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(\sync_ff_reg_n_0_[0][3] ),
        .Q(Q[3]));
  FDCE \sync_ff_reg[1][4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(\sync_ff_reg[0][0]_0 ),
        .D(\sync_ff_reg_n_0_[0][4] ),
        .Q(Q[4]));
endmodule

module fifo_flags
   (almost_empty,
    almost_empty_comb,
    rd_clk,
    rd_rst_n);
  output almost_empty;
  input almost_empty_comb;
  input rd_clk;
  input rd_rst_n;

  wire \<const1> ;
  wire almost_empty;
  wire almost_empty_comb;
  wire rd_clk;
  wire rd_rst_n;

  VCC VCC
       (.P(\<const1> ));
  FDPE almost_empty_reg
       (.C(rd_clk),
        .CE(\<const1> ),
        .D(almost_empty_comb),
        .PRE(rd_rst_n),
        .Q(almost_empty));
endmodule

(* ORIG_REF_NAME = "fifo_flags" *) 
module fifo_flags_0
   (almost_full,
    almost_full_comb,
    wr_clk,
    wr_rst_n);
  output almost_full;
  input almost_full_comb;
  input wr_clk;
  input wr_rst_n;

  wire \<const1> ;
  wire almost_full;
  wire almost_full_comb;
  wire wr_clk;
  wire wr_rst_n;

  VCC VCC
       (.P(\<const1> ));
  FDCE almost_full_reg
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(almost_full_comb),
        .Q(almost_full));
endmodule

module fifo_ptr
   (\gray_ptr_reg[3]_0 ,
    \gray_ptr_reg[3]_1 ,
    \gray_ptr_reg[3]_2 ,
    \gray_ptr_reg[3]_3 ,
    rd_ptr_gray,
    \rd_data_reg[7] ,
    almost_empty_comb,
    empty,
    rd_clk,
    rd_rst_n,
    Q,
    gray2bin2_return__3,
    rd_en);
  output \gray_ptr_reg[3]_0 ;
  output \gray_ptr_reg[3]_1 ;
  output \gray_ptr_reg[3]_2 ;
  output \gray_ptr_reg[3]_3 ;
  output [4:0]rd_ptr_gray;
  output \rd_data_reg[7] ;
  output almost_empty_comb;
  output empty;
  input rd_clk;
  input rd_rst_n;
  input [4:0]Q;
  input [0:0]gray2bin2_return__3;
  input rd_en;

  wire \<const1> ;
  wire [4:0]Q;
  wire almost_empty_comb;
  wire almost_empty_i_2_n_0;
  wire almost_empty_i_3_n_0;
  wire [3:0]bin_next;
  wire [4:4]bin_next__0;
  wire empty;
  wire empty_INST_0_i_1_n_0;
  wire [0:0]gray2bin2_return__3;
  wire [3:0]gray_next;
  wire \gray_ptr_reg[3]_0 ;
  wire \gray_ptr_reg[3]_1 ;
  wire \gray_ptr_reg[3]_2 ;
  wire \gray_ptr_reg[3]_3 ;
  wire p_15_in;
  wire rd_clk;
  wire \rd_data_reg[7] ;
  wire rd_en;
  wire [4:0]rd_ptr_gray;
  wire rd_rst_n;

  VCC VCC
       (.P(\<const1> ));
  LUT6 #(
    .INIT(64'h0000000084600912)) 
    almost_empty_i_1
       (.I0(almost_empty_i_2_n_0),
        .I1(rd_ptr_gray[3]),
        .I2(rd_ptr_gray[4]),
        .I3(Q[3]),
        .I4(Q[4]),
        .I5(almost_empty_i_3_n_0),
        .O(almost_empty_comb));
  LUT6 #(
    .INIT(64'hD5CDCCCC5555DC5D)) 
    almost_empty_i_2
       (.I0(p_15_in),
        .I1(gray2bin2_return__3),
        .I2(Q[0]),
        .I3(rd_ptr_gray[0]),
        .I4(Q[1]),
        .I5(rd_ptr_gray[1]),
        .O(almost_empty_i_2_n_0));
  LUT6 #(
    .INIT(64'h2F8F14FFFF41F8F2)) 
    almost_empty_i_3
       (.I0(rd_ptr_gray[0]),
        .I1(Q[0]),
        .I2(rd_ptr_gray[1]),
        .I3(p_15_in),
        .I4(Q[1]),
        .I5(gray2bin2_return__3),
        .O(almost_empty_i_3_n_0));
  LUT3 #(
    .INIT(8'h96)) 
    almost_empty_i_4
       (.I0(rd_ptr_gray[2]),
        .I1(rd_ptr_gray[4]),
        .I2(rd_ptr_gray[3]),
        .O(p_15_in));
  LUT2 #(
    .INIT(4'h6)) 
    \bin_ptr[0]_i_1__0 
       (.I0(\gray_ptr_reg[3]_3 ),
        .I1(\rd_data_reg[7] ),
        .O(bin_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \bin_ptr[1]_i_1__0 
       (.I0(\gray_ptr_reg[3]_3 ),
        .I1(\rd_data_reg[7] ),
        .I2(\gray_ptr_reg[3]_2 ),
        .O(bin_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \bin_ptr[2]_i_1__0 
       (.I0(\rd_data_reg[7] ),
        .I1(\gray_ptr_reg[3]_3 ),
        .I2(\gray_ptr_reg[3]_2 ),
        .I3(\gray_ptr_reg[3]_1 ),
        .O(bin_next[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \bin_ptr[3]_i_1__0 
       (.I0(\gray_ptr_reg[3]_2 ),
        .I1(\gray_ptr_reg[3]_3 ),
        .I2(\rd_data_reg[7] ),
        .I3(\gray_ptr_reg[3]_1 ),
        .I4(\gray_ptr_reg[3]_0 ),
        .O(bin_next[3]));
  FDCE \bin_ptr_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(bin_next[0]),
        .Q(\gray_ptr_reg[3]_3 ));
  FDCE \bin_ptr_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(bin_next[1]),
        .Q(\gray_ptr_reg[3]_2 ));
  FDCE \bin_ptr_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(bin_next[2]),
        .Q(\gray_ptr_reg[3]_1 ));
  FDCE \bin_ptr_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(bin_next[3]),
        .Q(\gray_ptr_reg[3]_0 ));
  LUT5 #(
    .INIT(32'h90000090)) 
    empty_INST_0
       (.I0(rd_ptr_gray[3]),
        .I1(Q[3]),
        .I2(empty_INST_0_i_1_n_0),
        .I3(Q[4]),
        .I4(rd_ptr_gray[4]),
        .O(empty));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    empty_INST_0_i_1
       (.I0(rd_ptr_gray[0]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(rd_ptr_gray[2]),
        .I4(Q[1]),
        .I5(rd_ptr_gray[1]),
        .O(empty_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h56)) 
    \gray_ptr[0]_i_1__0 
       (.I0(\gray_ptr_reg[3]_2 ),
        .I1(\rd_data_reg[7] ),
        .I2(\gray_ptr_reg[3]_3 ),
        .O(gray_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h5666)) 
    \gray_ptr[1]_i_1__0 
       (.I0(\gray_ptr_reg[3]_1 ),
        .I1(\gray_ptr_reg[3]_2 ),
        .I2(\gray_ptr_reg[3]_3 ),
        .I3(\rd_data_reg[7] ),
        .O(gray_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h56666666)) 
    \gray_ptr[2]_i_1__0 
       (.I0(\gray_ptr_reg[3]_0 ),
        .I1(\gray_ptr_reg[3]_1 ),
        .I2(\rd_data_reg[7] ),
        .I3(\gray_ptr_reg[3]_3 ),
        .I4(\gray_ptr_reg[3]_2 ),
        .O(gray_next[2]));
  LUT6 #(
    .INIT(64'h5666666666666666)) 
    \gray_ptr[3]_i_1__0 
       (.I0(rd_ptr_gray[4]),
        .I1(\gray_ptr_reg[3]_0 ),
        .I2(\gray_ptr_reg[3]_2 ),
        .I3(\gray_ptr_reg[3]_3 ),
        .I4(\rd_data_reg[7] ),
        .I5(\gray_ptr_reg[3]_1 ),
        .O(gray_next[3]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gray_ptr[4]_i_1__0 
       (.I0(\gray_ptr_reg[3]_1 ),
        .I1(\rd_data_reg[7] ),
        .I2(\gray_ptr_reg[3]_3 ),
        .I3(\gray_ptr_reg[3]_2 ),
        .I4(\gray_ptr_reg[3]_0 ),
        .I5(rd_ptr_gray[4]),
        .O(bin_next__0));
  FDCE \gray_ptr_reg[0] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(gray_next[0]),
        .Q(rd_ptr_gray[0]));
  FDCE \gray_ptr_reg[1] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(gray_next[1]),
        .Q(rd_ptr_gray[1]));
  FDCE \gray_ptr_reg[2] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(gray_next[2]),
        .Q(rd_ptr_gray[2]));
  FDCE \gray_ptr_reg[3] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(gray_next[3]),
        .Q(rd_ptr_gray[3]));
  FDCE \gray_ptr_reg[4] 
       (.C(rd_clk),
        .CE(\<const1> ),
        .CLR(rd_rst_n),
        .D(bin_next__0),
        .Q(rd_ptr_gray[4]));
  LUT6 #(
    .INIT(64'h28AAAAAAAAAA28AA)) 
    \rd_data[7]_i_1 
       (.I0(rd_en),
        .I1(rd_ptr_gray[4]),
        .I2(Q[4]),
        .I3(empty_INST_0_i_1_n_0),
        .I4(Q[3]),
        .I5(rd_ptr_gray[3]),
        .O(\rd_data_reg[7] ));
endmodule

(* ORIG_REF_NAME = "fifo_ptr" *) 
module fifo_ptr_2
   (\gray_ptr_reg[2]_0 ,
    \gray_ptr_reg[1]_0 ,
    \gray_ptr_reg[1]_1 ,
    \gray_ptr_reg[1]_2 ,
    wr_ptr_gray,
    wr_incr,
    full,
    almost_full_reg,
    gray2bin_return__3,
    wr_clk,
    wr_rst_n,
    wr_en,
    Q,
    p_25_in);
  output \gray_ptr_reg[2]_0 ;
  output \gray_ptr_reg[1]_0 ;
  output \gray_ptr_reg[1]_1 ;
  output \gray_ptr_reg[1]_2 ;
  output [4:0]wr_ptr_gray;
  output wr_incr;
  output full;
  output almost_full_reg;
  output [0:0]gray2bin_return__3;
  input wr_clk;
  input wr_rst_n;
  input wr_en;
  input [4:0]Q;
  input p_25_in;

  wire \<const1> ;
  wire [4:0]Q;
  wire almost_full_reg;
  wire [3:0]bin_next;
  wire [4:4]bin_next__0;
  wire full;
  wire full_INST_0_i_1_n_0;
  wire [0:0]gray2bin_return__3;
  wire [3:0]gray_next;
  wire \gray_ptr_reg[1]_0 ;
  wire \gray_ptr_reg[1]_1 ;
  wire \gray_ptr_reg[1]_2 ;
  wire \gray_ptr_reg[2]_0 ;
  wire p_25_in;
  wire wr_clk;
  wire wr_en;
  wire wr_incr;
  wire [4:0]wr_ptr_gray;
  wire wr_rst_n;

  VCC VCC
       (.P(\<const1> ));
  LUT6 #(
    .INIT(64'hFE7FBA5D3E7CBFFD)) 
    almost_full_i_4
       (.I0(gray2bin_return__3),
        .I1(wr_ptr_gray[1]),
        .I2(p_25_in),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(wr_ptr_gray[0]),
        .O(almost_full_reg));
  LUT3 #(
    .INIT(8'h96)) 
    almost_full_i_6
       (.I0(wr_ptr_gray[2]),
        .I1(wr_ptr_gray[4]),
        .I2(wr_ptr_gray[3]),
        .O(gray2bin_return__3));
  LUT2 #(
    .INIT(4'h6)) 
    \bin_ptr[0]_i_1 
       (.I0(\gray_ptr_reg[1]_2 ),
        .I1(wr_incr),
        .O(bin_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \bin_ptr[1]_i_1 
       (.I0(\gray_ptr_reg[1]_2 ),
        .I1(wr_incr),
        .I2(\gray_ptr_reg[1]_1 ),
        .O(bin_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \bin_ptr[2]_i_1 
       (.I0(wr_incr),
        .I1(\gray_ptr_reg[1]_2 ),
        .I2(\gray_ptr_reg[1]_1 ),
        .I3(\gray_ptr_reg[1]_0 ),
        .O(bin_next[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \bin_ptr[3]_i_1 
       (.I0(\gray_ptr_reg[1]_1 ),
        .I1(\gray_ptr_reg[1]_2 ),
        .I2(wr_incr),
        .I3(\gray_ptr_reg[1]_0 ),
        .I4(\gray_ptr_reg[2]_0 ),
        .O(bin_next[3]));
  FDCE \bin_ptr_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(bin_next[0]),
        .Q(\gray_ptr_reg[1]_2 ));
  FDCE \bin_ptr_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(bin_next[1]),
        .Q(\gray_ptr_reg[1]_1 ));
  FDCE \bin_ptr_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(bin_next[2]),
        .Q(\gray_ptr_reg[1]_0 ));
  FDCE \bin_ptr_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(bin_next[3]),
        .Q(\gray_ptr_reg[2]_0 ));
  LUT5 #(
    .INIT(32'h82000082)) 
    full_INST_0
       (.I0(full_INST_0_i_1_n_0),
        .I1(Q[1]),
        .I2(wr_ptr_gray[1]),
        .I3(Q[0]),
        .I4(wr_ptr_gray[0]),
        .O(full));
  LUT6 #(
    .INIT(64'h0660000000000660)) 
    full_INST_0_i_1
       (.I0(wr_ptr_gray[4]),
        .I1(Q[4]),
        .I2(wr_ptr_gray[3]),
        .I3(Q[3]),
        .I4(wr_ptr_gray[2]),
        .I5(Q[2]),
        .O(full_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h56)) 
    \gray_ptr[0]_i_1 
       (.I0(\gray_ptr_reg[1]_1 ),
        .I1(wr_incr),
        .I2(\gray_ptr_reg[1]_2 ),
        .O(gray_next[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h5666)) 
    \gray_ptr[1]_i_1 
       (.I0(\gray_ptr_reg[1]_0 ),
        .I1(\gray_ptr_reg[1]_1 ),
        .I2(\gray_ptr_reg[1]_2 ),
        .I3(wr_incr),
        .O(gray_next[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h56666666)) 
    \gray_ptr[2]_i_1 
       (.I0(\gray_ptr_reg[2]_0 ),
        .I1(\gray_ptr_reg[1]_0 ),
        .I2(wr_incr),
        .I3(\gray_ptr_reg[1]_2 ),
        .I4(\gray_ptr_reg[1]_1 ),
        .O(gray_next[2]));
  LUT6 #(
    .INIT(64'h5666666666666666)) 
    \gray_ptr[3]_i_1 
       (.I0(wr_ptr_gray[4]),
        .I1(\gray_ptr_reg[2]_0 ),
        .I2(\gray_ptr_reg[1]_1 ),
        .I3(\gray_ptr_reg[1]_2 ),
        .I4(wr_incr),
        .I5(\gray_ptr_reg[1]_0 ),
        .O(gray_next[3]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \gray_ptr[4]_i_1 
       (.I0(\gray_ptr_reg[1]_0 ),
        .I1(wr_incr),
        .I2(\gray_ptr_reg[1]_2 ),
        .I3(\gray_ptr_reg[1]_1 ),
        .I4(\gray_ptr_reg[2]_0 ),
        .I5(wr_ptr_gray[4]),
        .O(bin_next__0));
  FDCE \gray_ptr_reg[0] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(gray_next[0]),
        .Q(wr_ptr_gray[0]));
  FDCE \gray_ptr_reg[1] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(gray_next[1]),
        .Q(wr_ptr_gray[1]));
  FDCE \gray_ptr_reg[2] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(gray_next[2]),
        .Q(wr_ptr_gray[2]));
  FDCE \gray_ptr_reg[3] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(gray_next[3]),
        .Q(wr_ptr_gray[3]));
  FDCE \gray_ptr_reg[4] 
       (.C(wr_clk),
        .CE(\<const1> ),
        .CLR(wr_rst_n),
        .D(bin_next__0),
        .Q(wr_ptr_gray[4]));
  LUT6 #(
    .INIT(64'h28AAAA28AAAAAAAA)) 
    mem_reg_0_15_0_5_i_1
       (.I0(wr_en),
        .I1(wr_ptr_gray[0]),
        .I2(Q[0]),
        .I3(wr_ptr_gray[1]),
        .I4(Q[1]),
        .I5(full_INST_0_i_1_n_0),
        .O(wr_incr));
endmodule
