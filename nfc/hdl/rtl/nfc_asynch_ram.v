module nfc_asynch_ram(
                    wclk,
                    rclk,

                    write,
                    read,

                    addr_wr,
                    addr_rd,

                    data_in,
                    data_out

                    );

parameter  WIDTH  = 16;
parameter  ADDR   = 4;
parameter  DEPTH  = 16;

input          wclk;
input          rclk;
input [1:0]    write;
input          read;

input [ADDR-1:0]  addr_wr;
input [ADDR-1:0]  addr_rd;

input [WIDTH-1:0] data_in;
output [WIDTH-1:0] data_out;



reg [WIDTH-1:0] ram [0:DEPTH-1];
reg [ADDR-1:0]  addr_rd_p1;
reg [WIDTH-1:0] dummy;
reg             LAST_CLK;

always @( wclk)
begin
    casez({LAST_CLK,wclk})	
      2'b01: begin	    
           dummy = ram[addr_wr];
           case(write[1:0])
           2'b01: ram[addr_wr] = { dummy[15:8], data_in[7:0] };
           2'b10: ram[addr_wr] = { data_in[15:8], dummy[7:0] };
           2'b11: ram[addr_wr] = data_in;
           default:ram[addr_wr] = dummy;
           endcase
           end	   
      2'b10,
      2'bx?,
      2'b00,
      2'b11: ;
      endcase      
      LAST_CLK =wclk;
end

always @(posedge rclk)
begin
  if(read)
    addr_rd_p1 <= #1 addr_rd;
end

assign data_out = ram[addr_rd_p1];


endmodule

