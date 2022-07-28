`timescale 1ns/100ps

module contadorMOD10(output reg [3:0]bit_out, output reg en_out, input en_in, clk, reset);
  always @ (posedge clk or posedge reset)
    begin
      en_out = 1'b0;
      if(reset)
        bit_out = 0;
      else if(en_in)
        if(bit_out == 9)
          begin
            bit_out = 0;
            en_out = 1'b0;
          end
      	else
          begin
            bit_out++;
            if(bit_out == 9)
              en_out = 1'b1;
          end
    end
endmodule

module registrador (output reg [3:0] Qo, input [3:0] Qi, input clk, load);
  always @ (posedge clk)
    begin
      if(load)
        Qo = Qi;
    end
endmodule

module bcd_7seg (output reg [6:0] DISP, input [3:0] BCD);
  always @* begin
    case (BCD)
      4'b0000: DISP = 7'b1111110; //0
      4'b0001: DISP = 7'b0110000; //1
      4'b0010: DISP = 7'b1101101; //2
      4'b0011: DISP = 7'b1111001; //3
      4'b0100: DISP = 7'b0110011; //4
      4'b0101: DISP = 7'b1011011; //5
      4'b0110: DISP = 7'b1011111; //6
      4'b0111: DISP = 7'b1110000; //7
      4'b1000: DISP = 7'b1111111; //8
      4'b1001: DISP = 7'b1111011; //9
      default: DISP = 7'b000000 ;
    endcase
  end
endmodule

module celulaContagem (output [6:0] out_7seg, output en_out, input reg en_in, clk, reset, load);
  reg [3:0] b_in, b_out;
  contadorMOD10 C (.bit_out(b_in), .en_out(en_out), .en_in(en_in), .clk(clk), .reset(reset));
  registrador R (.Qo(b_out), .Qi(b_in), .clk(clk), .load(load));
  bcd_7seg B (.DISP(out_7seg), .BCD(b_out));
endmodule

module contadorMOD1000 (output [6:0] outA,outB,outC, output en_out, input en_in, clk, reset, load);
  reg [3:0] enable;
  assign enable[0] = en_in;
  celulaContagem C (.out_7seg(outC), .en_out(enable[1]), .en_in(enable[0]), .clk(clk), .reset(reset), .load(load));
  celulaContagem B (.out_7seg(outB), .en_out(enable[2]), .en_in(enable[1]), .clk(clk), .reset(reset), .load(load));
  celulaContagem A (.out_7seg(outA), .en_out(enable[3]), .en_in(enable[2]), .clk(clk), .reset(reset), .load(load));
  assign en_out = enable[3];
endmodule
