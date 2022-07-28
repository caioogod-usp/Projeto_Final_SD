`timescale 1ns/100ps

module contadorMOD10(output reg [3:0]bit_out, output reg carryout, input carryin, reset);
  always @ (negedge carryin or negedge reset)
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

module bcd27seg (output a, b, c, d, e, f, g, input [3:0] BCD);
assign {a, b, c, d, e, f, g} = ( BCD == 4'b0000 ) ? 7'b1111110 : //0
                               ( BCD == 4'b0001 ) ? 7'b0110000 : //1
                               ( BCD == 4'b0010 ) ? 7'b1101101 : //2
                               ( BCD == 4'b0011 ) ? 7'b1111001 : //3
                               ( BCD == 4'b0100 ) ? 7'b0110011 : //4
                               ( BCD == 4'b0101 ) ? 7'b1011011 : //5
                               ( BCD == 4'b0110 ) ? 7'b1011111 : //6
                               ( BCD == 4'b0111 ) ? 7'b1110000 : //7
                               ( BCD == 4'b1000 ) ? 7'b1111111 : //8
                               ( BCD == 4'b1001 ) ? 7'b1111011 : //9
                               7'b0000001 ;
endmodule
