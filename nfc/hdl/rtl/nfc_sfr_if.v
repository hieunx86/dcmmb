
//Project: 3901U421
//Initial By : Gu Fumin        2009.04
//Modified By: Yongliu Wang    2010.05


`timescale 1 ns/10 ps

module nfc_sfr_if(
                nfc_clk,
                rstb_nfc,
       
                mif_nfc_reg_wr,
                mif_nfc_reg_rd,
                mif_nfc_reg_addr,
                mif_nfc_reg_din,
                nfc_mif_reg_dout,

                rnb_i,
                addr_clear,
                data_clear,
                ecc_rdata,
                block_over,
                data_over,
                status_wr,
                status,

                nf_cmd,
                nf_cmd_valid,
                nf_rng_sel,
                nf_dat_end,
                nf_dir,
                nf_dat_inv,
                nf_addr_en,
                nf_dat_en,
                nf_blk_len,
                nf_trn_cnt,

                nf_mode,
                nf_ceb,
                nf_wpb,

                nf_spare_en,
                nf_spare_len,
                nf_ecc_en,
                nf_ecc_len,                
                nf_edo_en,
                nf_total_cycle,
                nf_high_cycle,
                nf_data_addr,
                nf_spare_addr,

                nf_column_addr_cnt,
                nf_row_addr_cnt,
                nf_column_addr,
                nf_row_addr,
         
                nf_rand_seed 



);

input         nfc_clk;
input         rstb_nfc;

input         mif_nfc_reg_wr;
input         mif_nfc_reg_rd;
input  [8:0]  mif_nfc_reg_addr;
input  [7:0]  mif_nfc_reg_din;
output [7:0]  nfc_mif_reg_dout;

input  [31:0]   ecc_rdata;
input           rnb_i;

input           addr_clear;
input           data_clear;

input           block_over;
input           data_over;
input           status_wr;
input  [15:0]   status;

output [7:0]    nf_cmd;
output          nf_cmd_valid;
output [2:0]    nf_rng_sel;
output          nf_dat_end;
output          nf_dir;
output          nf_dat_inv;
output          nf_addr_en;
output          nf_dat_en;

output [9:0]    nf_blk_len;
output [3:0]    nf_trn_cnt;

output [1:0]    nf_mode;
output [3:0]    nf_ceb;
output          nf_wpb;

output [4:0]    nf_spare_len;
output          nf_spare_en;
output          nf_ecc_en;
output          nf_ecc_len;

output          nf_edo_en;
output [2:0]    nf_total_cycle;
output [3:0]    nf_high_cycle;
output [15:0]   nf_data_addr;
output [15:0]   nf_spare_addr;

output [2:0]    nf_column_addr_cnt;
output [2:0]    nf_row_addr_cnt;
output [31:0]   nf_column_addr;
output [31:0]   nf_row_addr;

output [31:0]   nf_rand_seed; 


reg    [7:0]    nfc_mif_reg_dout;
parameter     NF_ECC_CTRL_OFFSET       = 6'h00;
parameter     NF_IF_CMD_OFFSET         = 6'h10;
parameter     NF_IF_CTRL0_OFFSET       = 6'h11;
parameter     NF_IF_CTRL1_OFFSET       = 6'h12;
parameter     NF_DATA_STATUS0_OFFSET   = 6'h13;
parameter     NF_DATA_STATUS1_OFFSET   = 6'h14;
parameter     NF_TIMING_CONF_OFFSET    = 6'h15;
parameter     NF_DATA_ADDR0_OFFSET     = 6'h16;
parameter     NF_DATA_ADDR1_OFFSET     = 6'h17;
parameter     NF_SPARE_ADDR0_OFFSET    = 6'h18;
parameter     NF_SPARE_ADDR1_OFFSET    = 6'h19;
parameter     NF_TRN_CNT_OFFSET        = 6'h1a;
//parameter     NF_TRN_CNT1_OFFSET       = 6'h1b;
parameter     NF_BLK_LEN0_OFFSET       = 6'h1c;
parameter     NF_BLK_LEN1_OFFSET       = 6'h1d;
parameter     NF_RED_LEN_OFFSET        = 6'h1e;
parameter     NF_ADDR_CNT_OFFSET       = 6'h1f;
parameter     NF_COLUMN_ADDR0_OFFSET   = 6'h20;
parameter     NF_COLUMN_ADDR1_OFFSET   = 6'h21;
parameter     NF_COLUMN_ADDR2_OFFSET   = 6'h22;
parameter     NF_COLUMN_ADDR3_OFFSET   = 6'h23;
parameter     NF_ROW_ADDR0_OFFSET      = 6'h24;
parameter     NF_ROW_ADDR1_OFFSET      = 6'h25;
parameter     NF_ROW_ADDR2_OFFSET      = 6'h26;
parameter     NF_ROW_ADDR3_OFFSET      = 6'h27;
parameter     NF_LOGIC_ADDR0_OFFSET    = 6'h28;
parameter     NF_LOGIC_ADDR1_OFFSET    = 6'h29;
parameter     NF_LOGIC_ADDR2_OFFSET    = 6'h2a;
parameter     NF_PHY_ADDR0_OFFSET      = 6'h2b;
parameter     NF_PHY_ADDR1_OFFSET      = 6'h2c;
parameter     NF_PHY_ADDR2_OFFSET      = 6'h2d;
parameter     NF_BIT0_LOC_OFFSET       = 6'h2e;
parameter     NF_BIT1_LOC_OFFSET       = 6'h2f;
parameter     NF_BIT2_LOC_OFFSET       = 6'h30;
parameter     NF_BIT_STATUS_OFFSET     = 6'h31;
parameter     NF_RAND_SEED0_OFFSET     = 6'h32;
parameter     NF_RAND_SEED1_OFFSET     = 6'h33;
parameter     NF_RAND_SEED2_OFFSET     = 6'h34;
parameter     NF_RAND_SEED3_OFFSET     = 6'h35;




reg [7:0]     nf_cmd;
reg           nf_cmd_valid;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_cmd         <=   8'h00;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CMD_OFFSET))
    nf_cmd         <=   mif_nfc_reg_din;
end


always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_cmd_valid   <=  1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CMD_OFFSET))
    nf_cmd_valid   <=  1'b1;
  else 
    nf_cmd_valid   <=  1'b0;
end

reg  [2:0]  nf_rng_sel;
reg         nf_dat_end;
reg         nf_dir;
reg         nf_dat_inv;
reg         nf_addr_en;
reg         nf_dat_en;

wire [7:0]  nf_ctrl0 = {nf_rng_sel,nf_dat_end,nf_dir,nf_dat_inv,nf_addr_en,nf_dat_en};


always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_rng_sel    <= 3'b0;
    nf_dat_end    <= 1'b0;
    nf_dir        <= 1'b0;
    nf_dat_inv    <= 1'b0;
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET)) begin
    nf_rng_sel    <= mif_nfc_reg_din[7:5];
    nf_dat_end    <= mif_nfc_reg_din[4];
    nf_dir        <= mif_nfc_reg_din[3];
    nf_dat_inv    <= mif_nfc_reg_din[2];
    end
end
   
always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) 
    nf_addr_en <= 1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET)) 
    nf_addr_en <= mif_nfc_reg_din[1];
  else if(addr_clear)
    nf_addr_en <= 1'b0;
end
   
always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) 
    nf_dat_en <= 1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET)) 
    nf_dat_en <= mif_nfc_reg_din[0];
  else if(data_clear)
    nf_dat_en <= 1'b0;
end
   
reg [1:0]      nf_mode;
reg [3:0]      nf_ceb;
reg            nf_wpb;
wire [7:0]     nf_ctrl1 = {2'b0, nf_mode,nf_ceb};

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_mode   <= 2'b00;
    nf_ceb       <= 4'b1110;
    nf_wpb    <= 1'b1; 
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL1_OFFSET)) begin
    nf_mode   <= mif_nfc_reg_din[5:4];
    nf_ceb       <= mif_nfc_reg_din[3:0];
    nf_wpb    <= mif_nfc_reg_din[6];
    end
end

reg [15:0]  nf_data_status;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_data_status  <= 16'h0;
    end
  else if(status_wr) begin
    nf_data_status  <= status;
    end
end

reg       nf_edo_en;
reg [2:0] nf_total_cycle;
reg [3:0] nf_high_cycle;

wire [7:0] nf_timing_conf = {nf_edo_en,nf_total_cycle,nf_high_cycle};

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_edo_en       <= 1'b0;
    nf_total_cycle  <= 3'h0;
    nf_high_cycle   <= 4'h0;
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_TIMING_CONF_OFFSET)) begin
    nf_edo_en       <= mif_nfc_reg_din[7];
    nf_total_cycle  <= mif_nfc_reg_din[6:4];
    nf_high_cycle   <= mif_nfc_reg_din[3:0];
    end
end

reg [15:0] nf_data_addr;     

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_data_addr <= 16'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr ==NF_DATA_ADDR0_OFFSET))
      nf_data_addr[7:0]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr ==NF_DATA_ADDR1_OFFSET))
      nf_data_addr[15:8] <= mif_nfc_reg_din[7:0];
    end
end

reg [15:0] nf_spare_addr;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_spare_addr <= 16'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr ==NF_SPARE_ADDR0_OFFSET))
      nf_spare_addr[7:0]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr ==NF_SPARE_ADDR1_OFFSET))
      nf_spare_addr[15:8] <= mif_nfc_reg_din[7:0];
    end
end

reg [3:0] nf_trn_cnt;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_trn_cnt       <= 4'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr ==NF_TRN_CNT_OFFSET))
      nf_trn_cnt     <= mif_nfc_reg_din[3:0];
    end
end

reg [9:0] nf_blk_len;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_blk_len       <= 12'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_BLK_LEN0_OFFSET))
      nf_blk_len[7:0]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_BLK_LEN1_OFFSET))
      nf_blk_len[9:8]  <= mif_nfc_reg_din[1:0];
    end
end

reg [4:0] nf_spare_len;
reg       nf_spare_en;
reg       nf_ecc_en;
reg       nf_ecc_len;

wire [7:0] nf_spare = { 2'b0, nf_spare_en,nf_spare_len};

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_spare_len    <= 5'b0;
    nf_spare_en     <= 1'b0;
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_RED_LEN_OFFSET)) begin
    nf_spare_len    <= mif_nfc_reg_din[4:0];
    nf_spare_en     <= mif_nfc_reg_din[5];
    end
end

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_ecc_en   <= 1'b0;
    nf_ecc_len  <= 1'b0;
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ECC_CTRL_OFFSET)) begin
    nf_ecc_en   <= mif_nfc_reg_din[0];
    nf_ecc_len  <= mif_nfc_reg_din[1];
    end
end



reg [2:0] nf_row_addr_cnt;
reg [2:0] nf_column_addr_cnt;

wire [7:0] nf_addr_cnt = {2'b0, nf_column_addr_cnt,nf_row_addr_cnt};

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc) begin
    nf_row_addr_cnt     <= 3'b0;
    nf_column_addr_cnt  <= 3'b0;
    end
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ADDR_CNT_OFFSET)) begin
    nf_row_addr_cnt     <= mif_nfc_reg_din[2:0];
    nf_column_addr_cnt  <= mif_nfc_reg_din[5:3];
    end
end

reg [31:0] nf_column_addr;    

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_column_addr      <= 32'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_COLUMN_ADDR0_OFFSET))
      nf_column_addr[7:0]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_COLUMN_ADDR1_OFFSET))
      nf_column_addr[15:8]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_COLUMN_ADDR2_OFFSET))
      nf_column_addr[23:16]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_COLUMN_ADDR3_OFFSET))
      nf_column_addr[31:24]  <= mif_nfc_reg_din[7:0];
    end
end


reg [31:0] nf_row_addr;    

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_row_addr      <= 32'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ROW_ADDR0_OFFSET))
      nf_row_addr[7:0]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ROW_ADDR1_OFFSET))
      nf_row_addr[15:8]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ROW_ADDR2_OFFSET))
      nf_row_addr[23:16]  <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_ROW_ADDR3_OFFSET))
      nf_row_addr[31:24]  <= mif_nfc_reg_din[7:0];
    end
end

reg [23:0] nf_logic_addr;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_logic_addr       <= 24'h0;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_LOGIC_ADDR0_OFFSET))
      nf_logic_addr[7:0] <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_LOGIC_ADDR1_OFFSET))
      nf_logic_addr[15:8] <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_LOGIC_ADDR2_OFFSET))
      nf_logic_addr[23:16] <= mif_nfc_reg_din[7:0];
    end
end

reg [4:0] nf_bit0_loc;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_bit0_loc    <= 5'h0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_BIT0_LOC_OFFSET))
    nf_bit0_loc    <= mif_nfc_reg_din[4:0];
end

reg [4:0] nf_bit1_loc;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_bit1_loc    <= 5'h0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_BIT1_LOC_OFFSET))
    nf_bit1_loc    <= mif_nfc_reg_din[4:0];
end

reg [4:0] nf_bit2_loc;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_bit2_loc    <= 5'h0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_BIT2_LOC_OFFSET))
    nf_bit2_loc    <= mif_nfc_reg_din[4:0];
end

reg [23:0] nf_phy_addr;


reg [31:0] nf_rand_seed;

always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_rand_seed   <= 32'hffff_ffff;
  else begin
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_RAND_SEED0_OFFSET))
      nf_rand_seed[7:0]   <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_RAND_SEED1_OFFSET))
      nf_rand_seed[15:8]   <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_RAND_SEED2_OFFSET))
      nf_rand_seed[23:16]   <= mif_nfc_reg_din[7:0];
    if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_RAND_SEED3_OFFSET))
      nf_rand_seed[31:24]   <= mif_nfc_reg_din[7:0];
    end
end

reg  nf_rnb;
always @(posedge  nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_rnb          <= 1'b0;
  else 
    nf_rnb          <= rnb_i;
end

reg nf_cmd_done;
always @(posedge nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_cmd_done     <= 1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CMD_OFFSET))
    nf_cmd_done     <= 1'b0;
//  else if(cmd_clear)
//    nf_cmd_done     <= 1'b1;
end
reg nf_addr_done;
always @(posedge nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_addr_done     <= 1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET) && mif_nfc_reg_din[1])
    nf_addr_done     <= 1'b0;
  else if(addr_clear)
    nf_addr_done     <= 1'b1;
end
reg nf_blk_done;
always @(posedge nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_blk_done     <= 1'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET) && mif_nfc_reg_din[0])
    nf_blk_done     <= 1'b0;
  else if(data_over)
    nf_blk_done     <= 1'b1;
end
reg [3:0] nf_blk_status;
always @(posedge nfc_clk or negedge rstb_nfc)
begin
  if(!rstb_nfc)
    nf_blk_status   <= 4'b0;
  else if(mif_nfc_reg_wr && (mif_nfc_reg_addr == NF_IF_CTRL0_OFFSET) && mif_nfc_reg_din[0])
    nf_blk_status   <= 4'b0;
  else if(block_over)
    nf_blk_status   <= nf_blk_status + 1'b1;
end

wire [7:0] nf_bit_status = {nf_cmd_done, nf_addr_done, nf_blk_done, nf_blk_status, nf_rnb};
reg [7:0] rd_data_tmp;

always @(*)
begin
  if(mif_nfc_reg_rd)
  casex(mif_nfc_reg_addr[5:0])
  6'b00xx00: nfc_mif_reg_dout = ecc_rdata[7:0];
  6'b00xx01: nfc_mif_reg_dout = ecc_rdata[15:8];
  6'b00xx10: nfc_mif_reg_dout = ecc_rdata[23:16];
  6'b00xx11: nfc_mif_reg_dout = ecc_rdata[31:24];
  6'h10: nfc_mif_reg_dout = nf_cmd;
  6'h11: nfc_mif_reg_dout = nf_ctrl0;
  6'h12: nfc_mif_reg_dout = nf_ctrl1;
//  6'h13: nfc_mif_reg_dout = nf_data_status[7:0];
//  6'h14: nfc_mif_reg_dout = nf_data_status[15:8];
  6'h13: nfc_mif_reg_dout = status[7:0];
  6'h14: nfc_mif_reg_dout = status[15:8];  
  6'h15: nfc_mif_reg_dout = nf_timing_conf;
  6'h16: nfc_mif_reg_dout = nf_data_addr[7:0];
  6'h17: nfc_mif_reg_dout = nf_data_addr[15:8];
  6'h18: nfc_mif_reg_dout = nf_spare_addr[7:0];
  6'h19: nfc_mif_reg_dout = nf_spare_addr[15:8];
  6'h1a: nfc_mif_reg_dout = {4'h0,nf_trn_cnt[3:0]};
  6'h1b: nfc_mif_reg_dout = 8'h0;
  6'h1c: nfc_mif_reg_dout = nf_blk_len[7:0];
  6'h1d: nfc_mif_reg_dout = {6'h0, nf_blk_len[9:8]};
  6'h1e: nfc_mif_reg_dout = nf_spare;
  6'h1f: nfc_mif_reg_dout = nf_addr_cnt;
  6'h20: nfc_mif_reg_dout = nf_column_addr[7:0];
  6'h21: nfc_mif_reg_dout = nf_column_addr[15:8];
  6'h22: nfc_mif_reg_dout = nf_column_addr[23:16];
  6'h23: nfc_mif_reg_dout = nf_column_addr[31:24];
  6'h24: nfc_mif_reg_dout = nf_row_addr[7:0];
  6'h25: nfc_mif_reg_dout = nf_row_addr[15:8];
  6'h26: nfc_mif_reg_dout = nf_row_addr[23:16];
  6'h27: nfc_mif_reg_dout = nf_row_addr[31:24];
  6'h28: nfc_mif_reg_dout = nf_logic_addr[7:0];
  6'h29: nfc_mif_reg_dout = nf_logic_addr[15:8];
  6'h2a: nfc_mif_reg_dout = nf_logic_addr[23:16];
  6'h2b: nfc_mif_reg_dout = nf_phy_addr[7:0];
  6'h2c: nfc_mif_reg_dout = nf_phy_addr[15:8];
  6'h2d: nfc_mif_reg_dout = nf_phy_addr[23:16];
  6'h2e: nfc_mif_reg_dout = nf_bit0_loc;
  6'h2f: nfc_mif_reg_dout = nf_bit1_loc;
  6'h30: nfc_mif_reg_dout = nf_bit2_loc;
  6'h31: nfc_mif_reg_dout = nf_bit_status;
  6'h32: nfc_mif_reg_dout = nf_rand_seed[7:0];
  6'h33: nfc_mif_reg_dout = nf_rand_seed[15:8];
  6'h34: nfc_mif_reg_dout = nf_rand_seed[23:16];
  6'h35: nfc_mif_reg_dout = nf_rand_seed[31:24];
  default: nfc_mif_reg_dout = 8'h0;
  endcase
  else 
    nfc_mif_reg_dout = 8'h0;
end

endmodule
