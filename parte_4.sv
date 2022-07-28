module fsm (output reg [2:0] ch, output en_0, reset, input en_3, Vint_z, clk, input iniciar);
  //ch[0]: ch_vm; ch[1]: ch_ref; ch[2]: ch_zr;
  always @ (negedge clk or posedge iniciar)
    begin
      if (iniciar)
        begin
          en_0 = 1'b1;
          reset = 1'b0;
          ch[0] = 1'b1;
          ch[1] = 1'b0;
          ch[2] = 1'b0;
        end
      else
        begin
          if (en_3)
            begin
              ch[0] = 1'b0;
              ch[1] = 1'b1;
              ch[2] = 1'b0;
            end
          if (Vint_z)
            begin
              en_0 = 1'b0;
              ch[0] = 1'b0;
              ch[1] = 1'b0;
              ch[2] = 1'b1;
              reset = 1'b1;
            end
        end
    end
endmodule
