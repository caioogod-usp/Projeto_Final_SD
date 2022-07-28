// Write your modules here!
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
