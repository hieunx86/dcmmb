//
//      CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF ARTISAN COMPONENTS, INC.
//      
//      Copyright (c) 2010 Artisan Components, Inc.  All Rights Reserved.
//      
//      Use of this Software/Data is subject to the terms and conditions of
//      the applicable license agreement between Artisan Components, Inc. and
//      Taiwan Semiconductor Manufacturing Company, Ltd..  In addition, this Software/Data
//      is protected by copyright law and international treaties.
//      
//      The copyright notice(s) in this Software/Data does not indicate actual
//      or intended publication of this Software/Data.
//      name:			SRAM-DP-HS SRAM Generator
//           			TSMC CL013G Process
//      version:		2005Q2V1
//      comment:		
//      configuration:	 -instname sramdphs8192x6 -words 8192 -bits 6 -frequency 70 -ring_width 2 -mux 16 -drive 6 -write_mask off -wp_size 8 -top_layer met5 -power_type rings -horiz met3 -vert met4 -cust_comment "" -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,GND:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type GND
//
//      Verilog model for Synchronous Dual-Port Ram
//
//      Instance Name:  sramdphs8192x6
//      Words:          8192
//      Word Width:     6
//      Pipeline:       No
//
//      Creation Date:  2010-03-24 01:26:26Z
//      Version: 	2005Q2V1
//
//      Verified With: Cadence Verilog-XL
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: The output hold function has been deleted
//          completely from this model.  Most Verilog simulators are 
//          incapable of scheduling more than 1 event on the rising 
//          edge of clock.  Therefore, it is impossible to model
//          the output hold (to x) action correctly.  It is necessary
//          to run static path timing tools using Artisan supplied
//          timing models to insure that the output hold time is
//          sufficient enough to not violate hold time constraints
//          of downstream flip-flops.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
module sramdphs8192x6 (
   QA,
   CLKA,
   CENA,
   WENA,
   AA,
   DA,
   QB,
   CLKB,
   CENB,
   WENB,
   AB,
   DB
);
   parameter		   BITS = 6;
   parameter		   word_depth = 8192;
   parameter		   addr_width = 13;
   parameter		   wordx = {BITS{1'bx}};
   parameter		   addrx = {addr_width{1'bx}};
	
   output [5:0] QA;
   input CLKA;
   input CENA;
   input WENA;
   input [12:0] AA;
   input [5:0] DA;
   output [5:0] QB;
   input CLKB;
   input CENB;
   input WENB;
   input [12:0] AB;
   input [5:0] DB;

   reg [BITS-1:0]	   mem [word_depth-1:0];
   reg                     NOT_CONTA;
   reg                     NOT_CONTB;

   reg			   NOT_CENA;
   reg			   NOT_WENA;

   reg			   NOT_AA0;
   reg			   NOT_AA1;
   reg			   NOT_AA2;
   reg			   NOT_AA3;
   reg			   NOT_AA4;
   reg			   NOT_AA5;
   reg			   NOT_AA6;
   reg			   NOT_AA7;
   reg			   NOT_AA8;
   reg			   NOT_AA9;
   reg			   NOT_AA10;
   reg			   NOT_AA11;
   reg			   NOT_AA12;
   reg [addr_width-1:0]	   NOT_AA;
   reg			   NOT_DA0;
   reg			   NOT_DA1;
   reg			   NOT_DA2;
   reg			   NOT_DA3;
   reg			   NOT_DA4;
   reg			   NOT_DA5;
   reg [BITS-1:0]	   NOT_DA;
   reg			   NOT_CLKA_PER;
   reg			   NOT_CLKA_MINH;
   reg			   NOT_CLKA_MINL;
   reg			   NOT_CENB;
   reg			   NOT_WENB;

   reg			   NOT_AB0;
   reg			   NOT_AB1;
   reg			   NOT_AB2;
   reg			   NOT_AB3;
   reg			   NOT_AB4;
   reg			   NOT_AB5;
   reg			   NOT_AB6;
   reg			   NOT_AB7;
   reg			   NOT_AB8;
   reg			   NOT_AB9;
   reg			   NOT_AB10;
   reg			   NOT_AB11;
   reg			   NOT_AB12;
   reg [addr_width-1:0]	   NOT_AB;
   reg			   NOT_DB0;
   reg			   NOT_DB1;
   reg			   NOT_DB2;
   reg			   NOT_DB3;
   reg			   NOT_DB4;
   reg			   NOT_DB5;
   reg [BITS-1:0]	   NOT_DB;
   reg			   NOT_CLKB_PER;
   reg			   NOT_CLKB_MINH;
   reg			   NOT_CLKB_MINL;

   reg			   LAST_NOT_CENA;
   reg			   LAST_NOT_WENA;
   reg [addr_width-1:0]	   LAST_NOT_AA;
   reg [BITS-1:0]	   LAST_NOT_DA;
   reg			   LAST_NOT_CLKA_PER;
   reg			   LAST_NOT_CLKA_MINH;
   reg			   LAST_NOT_CLKA_MINL;
   reg			   LAST_NOT_CENB;
   reg			   LAST_NOT_WENB;
   reg [addr_width-1:0]	   LAST_NOT_AB;
   reg [BITS-1:0]	   LAST_NOT_DB;
   reg			   LAST_NOT_CLKB_PER;
   reg			   LAST_NOT_CLKB_MINH;
   reg			   LAST_NOT_CLKB_MINL;

   reg                     LAST_NOT_CONTA;
   reg                     LAST_NOT_CONTB;
   wire                    contA_flag;
   wire                    contB_flag;
   wire                    cont_flag;

   wire [BITS-1:0]   _QA;
   wire [addr_width-1:0]   _AA;
   wire			   _CLKA;
   wire			   _CENA;
   wire                    _WENA;

   wire [BITS-1:0]   _DA;
   wire                    re_flagA;
   wire                    re_data_flagA;

   wire [BITS-1:0]   _QB;
   wire [addr_width-1:0]   _AB;
   wire			   _CLKB;
   wire			   _CENB;
   wire                    _WENB;

   wire [BITS-1:0]   _DB;
   wire                    re_flagB;
   wire                    re_data_flagB;


   reg			   LATCHED_CENA;
   reg	                  LATCHED_WENA;
   reg [addr_width-1:0]	   LATCHED_AA;
   reg [BITS-1:0]	   LATCHED_DA;
   reg			   LATCHED_CENB;
   reg	                  LATCHED_WENB;
   reg [addr_width-1:0]	   LATCHED_AB;
   reg [BITS-1:0]	   LATCHED_DB;

   reg			   CENAi;
   reg           	   WENAi;
   reg [addr_width-1:0]	   AAi;
   reg [BITS-1:0]	   DAi;
   reg [BITS-1:0]	   QAi;
   reg [BITS-1:0]	   LAST_QAi;
   reg			   CENBi;
   reg           	   WENBi;
   reg [addr_width-1:0]	   ABi;
   reg [BITS-1:0]	   DBi;
   reg [BITS-1:0]	   QBi;
   reg [BITS-1:0]	   LAST_QBi;



   reg			   LAST_CLKA;
   reg			   LAST_CLKB;



   reg                     valid_cycleA;
   reg                     valid_cycleB;


   task update_Anotifier_buses;
   begin
      NOT_AA = {
               NOT_AA12,
               NOT_AA11,
               NOT_AA10,
               NOT_AA9,
               NOT_AA8,
               NOT_AA7,
               NOT_AA6,
               NOT_AA5,
               NOT_AA4,
               NOT_AA3,
               NOT_AA2,
               NOT_AA1,
               NOT_AA0};
      NOT_DA = {
               NOT_DA5,
               NOT_DA4,
               NOT_DA3,
               NOT_DA2,
               NOT_DA1,
               NOT_DA0};
   end
   endtask
   task update_Bnotifier_buses;
   begin
      NOT_AB = {
               NOT_AB12,
               NOT_AB11,
               NOT_AB10,
               NOT_AB9,
               NOT_AB8,
               NOT_AB7,
               NOT_AB6,
               NOT_AB5,
               NOT_AB4,
               NOT_AB3,
               NOT_AB2,
               NOT_AB1,
               NOT_AB0};
      NOT_DB = {
               NOT_DB5,
               NOT_DB4,
               NOT_DB3,
               NOT_DB2,
               NOT_DB1,
               NOT_DB0};
   end
   endtask

   task mem_cycleA;
   begin
      valid_cycleA = 1'bx;
      casez({WENAi,CENAi})

	2'b10: begin
	   valid_cycleA = 1;
	   read_memA(1,0);
	end
	2'b00: begin
	   valid_cycleA = 0;
	   write_mem(AAi,DAi);
	   read_memA(0,0);
	end
	2'b?1: ;
	2'b1x: begin
	   valid_cycleA = 1;
	   read_memA(0,1);
	end
	2'bx0: begin
	   valid_cycleA = 0;
	   write_mem_x(AAi);
	   read_memA(0,1);
	end
	2'b0x,
	2'bxx: begin
	   valid_cycleA = 0;
	   write_mem_x(AAi);
	   read_memA(0,1);
	end
      endcase
   end
   endtask
   task mem_cycleB;
   begin
      valid_cycleB = 1'bx;
      casez({WENBi,CENBi})

	2'b10: begin
	   valid_cycleB = 1;
	   read_memB(1,0);
	end
	2'b00: begin
	   valid_cycleB = 0;
	   write_mem(ABi,DBi);
	   read_memB(0,0);
	end
	2'b?1: ;
	2'b1x: begin
	   valid_cycleB = 1;
	   read_memB(0,1);
	end
	2'bx0: begin
	   valid_cycleB = 0;
	   write_mem_x(ABi);
	   read_memB(0,1);
	end
	2'b0x,
	2'bxx: begin
	   valid_cycleB = 0;
	   write_mem_x(ABi);
	   read_memB(0,1);
	end
      endcase
   end
   endtask
      
   task contentionA;
   begin
      casez({valid_cycleB,WENAi})
	2'bx?: ;
	2'b00,
	2'b0x:begin
           write_mem_x(AAi);
	end
	2'b10,
	2'b1x:begin
           write_mem_x(AAi);
	   read_memB(0,1);
	end
	2'b01:begin
           write_mem_x(AAi);
	   read_memA(0,1);
	end
	2'b11: ;
      endcase
   end
   endtask

   task contentionB;
   begin
      casez({valid_cycleA,WENBi})
	2'bx?: ;
	2'b00,
	2'b0x:begin
	   write_mem_x(ABi);
	end
	2'b10,
	2'b1x:begin
	   write_mem_x(ABi);
	   read_memA(0,1);
	end
	2'b01:begin
	   write_mem_x(ABi);
	   read_memB(0,1);
	end
	2'b11: ;
      endcase
   end
   endtask

   task update_Alast_notifiers;
   begin
      LAST_NOT_AA = NOT_AA;
      LAST_NOT_DA = NOT_DA;
      LAST_NOT_WENA = NOT_WENA;
      LAST_NOT_CENA = NOT_CENA;
      LAST_NOT_CLKA_PER = NOT_CLKA_PER;
      LAST_NOT_CLKA_MINH = NOT_CLKA_MINH;
      LAST_NOT_CLKA_MINL = NOT_CLKA_MINL;
      LAST_NOT_CONTA = NOT_CONTA;
   end
   endtask
   task update_Blast_notifiers;
   begin
      LAST_NOT_AB = NOT_AB;
      LAST_NOT_DB = NOT_DB;
      LAST_NOT_WENB = NOT_WENB;
      LAST_NOT_CENB = NOT_CENB;
      LAST_NOT_CLKB_PER = NOT_CLKB_PER;
      LAST_NOT_CLKB_MINH = NOT_CLKB_MINH;
      LAST_NOT_CLKB_MINL = NOT_CLKB_MINL;
      LAST_NOT_CONTB = NOT_CONTB;
   end
   endtask

   task latch_Ainputs;
   begin
      LATCHED_AA = _AA ;
      LATCHED_DA = _DA ;
      LATCHED_WENA = _WENA ;
      LATCHED_CENA = _CENA ;
      LAST_QAi = QAi;
   end
   endtask
   task latch_Binputs;
   begin
      LATCHED_AB = _AB ;
      LATCHED_DB = _DB ;
      LATCHED_WENB = _WENB ;
      LATCHED_CENB = _CENB ;
      LAST_QBi = QBi;
   end
   endtask


   task update_Alogic;
   begin
      CENAi = LATCHED_CENA;
      WENAi = LATCHED_WENA;
      AAi = LATCHED_AA;
      DAi = LATCHED_DA;
   end
   endtask
   task update_Blogic;
   begin
      CENBi = LATCHED_CENB;
      WENBi = LATCHED_WENB;
      ABi = LATCHED_AB;
      DBi = LATCHED_DB;
   end
   endtask



   task x_Ainputs;
      integer n;
   begin
      for (n=0; n<addr_width; n=n+1)
	 begin
	    LATCHED_AA[n] = (NOT_AA[n]!==LAST_NOT_AA[n]) ? 1'bx : LATCHED_AA[n] ;
	 end
      for (n=0; n<BITS; n=n+1)
	 begin
	    LATCHED_DA[n] = (NOT_DA[n]!==LAST_NOT_DA[n]) ? 1'bx : LATCHED_DA[n] ;
	 end
      LATCHED_WENA = (NOT_WENA!==LAST_NOT_WENA) ? 1'bx : LATCHED_WENA ;

      LATCHED_CENA = (NOT_CENA!==LAST_NOT_CENA) ? 1'bx : LATCHED_CENA ;
   end
   endtask
   task x_Binputs;
      integer n;
   begin
      for (n=0; n<addr_width; n=n+1)
	 begin
	    LATCHED_AB[n] = (NOT_AB[n]!==LAST_NOT_AB[n]) ? 1'bx : LATCHED_AB[n] ;
	 end
      for (n=0; n<BITS; n=n+1)
	 begin
	    LATCHED_DB[n] = (NOT_DB[n]!==LAST_NOT_DB[n]) ? 1'bx : LATCHED_DB[n] ;
	 end
      LATCHED_WENB = (NOT_WENB!==LAST_NOT_WENB) ? 1'bx : LATCHED_WENB ;

      LATCHED_CENB = (NOT_CENB!==LAST_NOT_CENB) ? 1'bx : LATCHED_CENB ;
   end
   endtask

   task read_memA;
      input r_wb;
      input xflag;
   begin
      if (r_wb)
	 begin
	    if (valid_address(AAi))
	       begin
                     QAi=mem[AAi];
	       end
	    else
	       begin
	          x_mem;
		  QAi=wordx;
	       end
	 end
      else
	 begin
	    if (xflag)
	       begin
		  QAi=wordx;
	       end
	    else
	       begin
	          QAi=DAi;
	       end
	 end
   end
   endtask
   task read_memB;
      input r_wb;
      input xflag;
   begin
      if (r_wb)
	 begin
	    if (valid_address(ABi))
	       begin
                     QBi=mem[ABi];
	       end
	    else
	       begin
	          x_mem;
		  QBi=wordx;
	       end
	 end
      else
	 begin
	    if (xflag)
	       begin
		  QBi=wordx;
	       end
	    else
	       begin
	          QBi=DBi;
	       end
	 end
   end
   endtask

   task write_mem;
      input [addr_width-1:0] a;
      input [BITS-1:0] d;
 
   begin
      casez({valid_address(a)})
	1'b0: 
		x_mem;
	1'b1: mem[a]=d;
      endcase
   end
   endtask

   task write_mem_x;
      input [addr_width-1:0] a;
   begin
      casez({valid_address(a)})
	1'b0: 
		x_mem;
	1'b1: mem[a]=wordx;
      endcase
   end
   endtask

   task x_mem;
      integer n;
   begin
      for (n=0; n<word_depth; n=n+1)
	 mem[n]=wordx;
   end
   endtask

   task process_violationsA;
   begin
      if ((NOT_CLKA_PER!==LAST_NOT_CLKA_PER) ||
	  (NOT_CLKA_MINH!==LAST_NOT_CLKA_MINH) ||
	  (NOT_CLKA_MINL!==LAST_NOT_CLKA_MINL))
	 begin
	    if (CENAi !== 1'b1)
               begin
		  x_mem;
		  read_memA(0,1);
	       end
	 end
      else
	 begin
	    update_Anotifier_buses;
	    x_Ainputs;
	    update_Alogic;
            if (NOT_CONTA!==LAST_NOT_CONTA)
               begin
		  contentionA;
               end
            else
               begin
                  mem_cycleA;
               end
	 end
      update_Alast_notifiers;
   end
   endtask

   task process_violationsB;
   begin
      if ((NOT_CLKB_PER!==LAST_NOT_CLKB_PER) ||
	  (NOT_CLKB_MINH!==LAST_NOT_CLKB_MINH) ||
	  (NOT_CLKB_MINL!==LAST_NOT_CLKB_MINL))
	 begin
	    if (CENBi !== 1'b1)
               begin
		  x_mem;
		  read_memB(0,1);
	       end
	 end
      else
	 begin
	    update_Bnotifier_buses;
	    x_Binputs;
	    update_Blogic;
            if (NOT_CONTB!==LAST_NOT_CONTB)
               begin
		  contentionB;
               end
            else
               begin
                  mem_cycleB;
               end
	 end
      update_Blast_notifiers;
   end
   endtask

   function valid_address;
      input [addr_width-1:0] a;
   begin
      valid_address = (^(a) !== 1'bx);
   end
   endfunction


   buf (QA[0], _QA[0]);
   buf (QA[1], _QA[1]);
   buf (QA[2], _QA[2]);
   buf (QA[3], _QA[3]);
   buf (QA[4], _QA[4]);
   buf (QA[5], _QA[5]);
   buf (_DA[0], DA[0]);
   buf (_DA[1], DA[1]);
   buf (_DA[2], DA[2]);
   buf (_DA[3], DA[3]);
   buf (_DA[4], DA[4]);
   buf (_DA[5], DA[5]);
   buf (_AA[0], AA[0]);
   buf (_AA[1], AA[1]);
   buf (_AA[2], AA[2]);
   buf (_AA[3], AA[3]);
   buf (_AA[4], AA[4]);
   buf (_AA[5], AA[5]);
   buf (_AA[6], AA[6]);
   buf (_AA[7], AA[7]);
   buf (_AA[8], AA[8]);
   buf (_AA[9], AA[9]);
   buf (_AA[10], AA[10]);
   buf (_AA[11], AA[11]);
   buf (_AA[12], AA[12]);
   buf (_CLKA, CLKA);
   buf (_WENA, WENA);
   buf (_CENA, CENA);
   buf (QB[0], _QB[0]);
   buf (QB[1], _QB[1]);
   buf (QB[2], _QB[2]);
   buf (QB[3], _QB[3]);
   buf (QB[4], _QB[4]);
   buf (QB[5], _QB[5]);
   buf (_DB[0], DB[0]);
   buf (_DB[1], DB[1]);
   buf (_DB[2], DB[2]);
   buf (_DB[3], DB[3]);
   buf (_DB[4], DB[4]);
   buf (_DB[5], DB[5]);
   buf (_AB[0], AB[0]);
   buf (_AB[1], AB[1]);
   buf (_AB[2], AB[2]);
   buf (_AB[3], AB[3]);
   buf (_AB[4], AB[4]);
   buf (_AB[5], AB[5]);
   buf (_AB[6], AB[6]);
   buf (_AB[7], AB[7]);
   buf (_AB[8], AB[8]);
   buf (_AB[9], AB[9]);
   buf (_AB[10], AB[10]);
   buf (_AB[11], AB[11]);
   buf (_AB[12], AB[12]);
   buf (_CLKB, CLKB);
   buf (_WENB, WENB);
   buf (_CENB, CENB);


   assign _QA = QAi;
   assign re_flagA = !(_CENA);
   assign re_data_flagA = !(_CENA || _WENA);
   assign _QB = QBi;
   assign re_flagB = !(_CENB);
   assign re_data_flagB = !(_CENB || _WENB);

   assign contA_flag = 
      (_AA === ABi) && 
      !((_WENA === 1'b1) && (WENBi === 1'b1)) &&
      (_CENA !== 1'b1) &&
      (CENBi !== 1'b1);
   
   assign contB_flag = 
      (_AB === AAi) && 
      !((_WENB === 1'b1) && (WENAi === 1'b1)) &&
      (_CENB !== 1'b1) &&
      (CENAi !== 1'b1);

   assign cont_flag = 
      (_AB === _AA) && 
      !((_WENB === 1'b1) && (_WENA === 1'b1)) &&
      (_CENB !== 1'b1) &&
      (_CENA !== 1'b1);

   always @(
	    NOT_AA0 or
	    NOT_AA1 or
	    NOT_AA2 or
	    NOT_AA3 or
	    NOT_AA4 or
	    NOT_AA5 or
	    NOT_AA6 or
	    NOT_AA7 or
	    NOT_AA8 or
	    NOT_AA9 or
	    NOT_AA10 or
	    NOT_AA11 or
	    NOT_AA12 or
	    NOT_DA0 or
	    NOT_DA1 or
	    NOT_DA2 or
	    NOT_DA3 or
	    NOT_DA4 or
	    NOT_DA5 or
	    NOT_WENA or
	    NOT_CENA or
            NOT_CONTA or
	    NOT_CLKA_PER or
	    NOT_CLKA_MINH or
	    NOT_CLKA_MINL
	    )
      begin
         process_violationsA;
      end
   always @(
	    NOT_AB0 or
	    NOT_AB1 or
	    NOT_AB2 or
	    NOT_AB3 or
	    NOT_AB4 or
	    NOT_AB5 or
	    NOT_AB6 or
	    NOT_AB7 or
	    NOT_AB8 or
	    NOT_AB9 or
	    NOT_AB10 or
	    NOT_AB11 or
	    NOT_AB12 or
	    NOT_DB0 or
	    NOT_DB1 or
	    NOT_DB2 or
	    NOT_DB3 or
	    NOT_DB4 or
	    NOT_DB5 or
	    NOT_WENB or
	    NOT_CENB or
            NOT_CONTB or
	    NOT_CLKB_PER or
	    NOT_CLKB_MINH or
	    NOT_CLKB_MINL
	    )
      begin
         process_violationsB;
      end

   always @( _CLKA )
      begin
         casez({LAST_CLKA,_CLKA})
	   2'b01: begin
	      latch_Ainputs;
	      update_Alogic;
	      mem_cycleA;
	   end

	   2'b10,
	   2'bx?,
	   2'b00,
	   2'b11: ;

	   2'b?x: begin
	      x_mem;
              read_memA(0,1);
	   end
	   
	 endcase
	 LAST_CLKA = _CLKA;
      end
   always @( _CLKB )
      begin
         casez({LAST_CLKB,_CLKB})
	   2'b01: begin
	      latch_Binputs;
	      update_Blogic;
	      mem_cycleB;
	   end

	   2'b10,
	   2'bx?,
	   2'b00,
	   2'b11: ;

	   2'b?x: begin
	      x_mem;
              read_memB(0,1);
	   end
	   
	 endcase
	 LAST_CLKB = _CLKB;
      end

   specify
      $setuphold(posedge CLKA, posedge CENA, 1.000, 0.500, NOT_CENA);
      $setuphold(posedge CLKA, negedge CENA, 1.000, 0.500, NOT_CENA);
      $setuphold(posedge CLKA &&& re_flagA, posedge WENA, 1.000, 0.500, NOT_WENA);
      $setuphold(posedge CLKA &&& re_flagA, negedge WENA, 1.000, 0.500, NOT_WENA);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[0], 1.000, 0.500, NOT_AA0);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[0], 1.000, 0.500, NOT_AA0);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[1], 1.000, 0.500, NOT_AA1);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[1], 1.000, 0.500, NOT_AA1);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[2], 1.000, 0.500, NOT_AA2);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[2], 1.000, 0.500, NOT_AA2);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[3], 1.000, 0.500, NOT_AA3);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[3], 1.000, 0.500, NOT_AA3);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[4], 1.000, 0.500, NOT_AA4);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[4], 1.000, 0.500, NOT_AA4);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[5], 1.000, 0.500, NOT_AA5);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[5], 1.000, 0.500, NOT_AA5);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[6], 1.000, 0.500, NOT_AA6);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[6], 1.000, 0.500, NOT_AA6);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[7], 1.000, 0.500, NOT_AA7);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[7], 1.000, 0.500, NOT_AA7);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[8], 1.000, 0.500, NOT_AA8);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[8], 1.000, 0.500, NOT_AA8);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[9], 1.000, 0.500, NOT_AA9);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[9], 1.000, 0.500, NOT_AA9);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[10], 1.000, 0.500, NOT_AA10);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[10], 1.000, 0.500, NOT_AA10);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[11], 1.000, 0.500, NOT_AA11);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[11], 1.000, 0.500, NOT_AA11);
      $setuphold(posedge CLKA &&& re_flagA, posedge AA[12], 1.000, 0.500, NOT_AA12);
      $setuphold(posedge CLKA &&& re_flagA, negedge AA[12], 1.000, 0.500, NOT_AA12);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[0], 1.000, 0.500, NOT_DA0);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[0], 1.000, 0.500, NOT_DA0);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[1], 1.000, 0.500, NOT_DA1);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[1], 1.000, 0.500, NOT_DA1);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[2], 1.000, 0.500, NOT_DA2);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[2], 1.000, 0.500, NOT_DA2);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[3], 1.000, 0.500, NOT_DA3);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[3], 1.000, 0.500, NOT_DA3);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[4], 1.000, 0.500, NOT_DA4);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[4], 1.000, 0.500, NOT_DA4);
      $setuphold(posedge CLKA &&& re_data_flagA, posedge DA[5], 1.000, 0.500, NOT_DA5);
      $setuphold(posedge CLKA &&& re_data_flagA, negedge DA[5], 1.000, 0.500, NOT_DA5);
      $setuphold(posedge CLKB, posedge CENB, 1.000, 0.500, NOT_CENB);
      $setuphold(posedge CLKB, negedge CENB, 1.000, 0.500, NOT_CENB);
      $setuphold(posedge CLKB &&& re_flagB, posedge WENB, 1.000, 0.500, NOT_WENB);
      $setuphold(posedge CLKB &&& re_flagB, negedge WENB, 1.000, 0.500, NOT_WENB);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[0], 1.000, 0.500, NOT_AB0);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[0], 1.000, 0.500, NOT_AB0);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[1], 1.000, 0.500, NOT_AB1);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[1], 1.000, 0.500, NOT_AB1);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[2], 1.000, 0.500, NOT_AB2);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[2], 1.000, 0.500, NOT_AB2);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[3], 1.000, 0.500, NOT_AB3);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[3], 1.000, 0.500, NOT_AB3);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[4], 1.000, 0.500, NOT_AB4);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[4], 1.000, 0.500, NOT_AB4);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[5], 1.000, 0.500, NOT_AB5);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[5], 1.000, 0.500, NOT_AB5);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[6], 1.000, 0.500, NOT_AB6);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[6], 1.000, 0.500, NOT_AB6);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[7], 1.000, 0.500, NOT_AB7);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[7], 1.000, 0.500, NOT_AB7);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[8], 1.000, 0.500, NOT_AB8);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[8], 1.000, 0.500, NOT_AB8);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[9], 1.000, 0.500, NOT_AB9);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[9], 1.000, 0.500, NOT_AB9);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[10], 1.000, 0.500, NOT_AB10);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[10], 1.000, 0.500, NOT_AB10);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[11], 1.000, 0.500, NOT_AB11);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[11], 1.000, 0.500, NOT_AB11);
      $setuphold(posedge CLKB &&& re_flagB, posedge AB[12], 1.000, 0.500, NOT_AB12);
      $setuphold(posedge CLKB &&& re_flagB, negedge AB[12], 1.000, 0.500, NOT_AB12);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[0], 1.000, 0.500, NOT_DB0);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[0], 1.000, 0.500, NOT_DB0);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[1], 1.000, 0.500, NOT_DB1);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[1], 1.000, 0.500, NOT_DB1);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[2], 1.000, 0.500, NOT_DB2);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[2], 1.000, 0.500, NOT_DB2);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[3], 1.000, 0.500, NOT_DB3);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[3], 1.000, 0.500, NOT_DB3);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[4], 1.000, 0.500, NOT_DB4);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[4], 1.000, 0.500, NOT_DB4);
      $setuphold(posedge CLKB &&& re_data_flagB, posedge DB[5], 1.000, 0.500, NOT_DB5);
      $setuphold(posedge CLKB &&& re_data_flagB, negedge DB[5], 1.000, 0.500, NOT_DB5);
      $setup(posedge CLKA, posedge CLKB &&& contB_flag, 3.000, NOT_CONTB);
      $setup(posedge CLKB, posedge CLKA &&& contA_flag, 3.000, NOT_CONTA);
      $hold(posedge CLKA, posedge CLKB &&& cont_flag, 0.001, NOT_CONTB);

      $period(posedge CLKA, 3.000, NOT_CLKA_PER);
      $width(posedge CLKA, 1.000, 0, NOT_CLKA_MINH);
      $width(negedge CLKA, 1.000, 0, NOT_CLKA_MINL);
      $period(posedge CLKB, 3.000, NOT_CLKB_PER);
      $width(posedge CLKB, 1.000, 0, NOT_CLKB_MINH);
      $width(negedge CLKB, 1.000, 0, NOT_CLKB_MINL);

      (CLKA => QA[0])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKA => QA[1])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKA => QA[2])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKA => QA[3])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKA => QA[4])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKA => QA[5])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[0])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[1])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[2])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[3])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[4])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
      (CLKB => QB[5])=(1.000, 1.000, 0.500, 1.000, 0.500, 1.000);
   endspecify

endmodule
`endcelldefine
