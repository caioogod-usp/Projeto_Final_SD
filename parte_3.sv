`timescale 1ns/100ps

module contadorMOD10(output reg [3:0]bit_out, output reg carryout, input carryin, reset);
  always @ (posedge carryin or posedge reset)
    begin
      if(~reset)
        bit_out = 0;
      else
        if(bit_out == 9)
          begin
            carryout = 1'b1;
            bit_out = 0;
          end
      	else
          begin
            bit_out++;
            carryout = 1'b0;
          end
    end
endmodule

module registrador (output reg [3:0] Qo, input [3:0] Qi, input clk, load);
  always @ (negedge clk)
    begin
      if(load)
        Qo = Qi;
    end
endmodule

module bcd27seg (output reg [6:0] DISP, input [3:0] BCD);
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
