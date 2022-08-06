`timescale 1ns/100ps

//MÓDULO CONTADOR MOD 10.
module contadorMOD10(output reg [3:0]bit_out, output reg en_out, input en_in, clk, reset);
  always @ (posedge clk or posedge reset) //toda vez que ocorrer uma posedge de clock ou uma posedge de reset.
    begin
      if(reset) bit_out = 0; //se o botao de reset for acionado, saída vai a '0'.
      else if(en_in)
        if(bit_out == 9) bit_out = 0; //se a contagem chegar em '9', no próximo clock, a contagem reinicia.
      	else bit_out++; //senão, adiciona mais um a contagem.
    end
  
  assign en_out = en_in & bit_out[0] & bit_out[3]; //quando a en_in estiver habilitada e bit_out = 9, en_out vai a 1.
endmodule

//REGISTRADOR COM FLIF FLOP TIPO D.
module registrador (output reg [3:0] Qo, input [3:0] Qi, input clk, load);
  always @ (posedge clk)  //Em toda borda positiva de clock.
    begin
      if(load)  //se a entrada LOAD estiver habilitada
        Qo = Qi;  //a saída recebe o valor da entrada.
    end
endmodule

//MÓDULO DECODIFICADOR BCD PARA 7 SEGMENTOS.
module bcd_7seg (output reg [6:0] DISP, input [3:0] BCD);
  always @* begin
    case (BCD)
      4'b0000: DISP = 7'b1111110; //caso a entrada BCD for 0000, reproduz 0.
      4'b0001: DISP = 7'b0110000; //caso a entrada BCD for 0001, reproduz 1
      4'b0010: DISP = 7'b1101101; //caso a entrada BCD for 0010, reproduz 2
      4'b0011: DISP = 7'b1111001; //caso a entrada BCD for 0011, reproduz 3
      4'b0100: DISP = 7'b0110011; //caso a entrada BCD for 0100, reproduz 4
      4'b0101: DISP = 7'b1011011; //caso a entrada BCD for 0101, reproduz 5
      4'b0110: DISP = 7'b1011111; //caso a entrada BCD for 0110, reproduz 6
      4'b0111: DISP = 7'b1110000; //caso a entrada BCD for 0111, reproduz 7
      4'b1000: DISP = 7'b1111111; //caso a entrada BCD for 1000, reproduz 8
      4'b1001: DISP = 7'b1111011; //caso a entrada BCD for 1001, reproduz 9
      default: DISP = 7'b000000 ; //caso contrário, gera tela desligada.
    endcase
  end
endmodule

//MÓDULO DE UMA CÉLULA DO CONTADOR.
module celulaContagem (output [6:0] out_7seg, output en_out, input reg en_in, clk, reset, load);
  reg [3:0] b_in, b_out;
  contadorMOD10 C (.bit_out(b_in), .en_out(en_out), .en_in(en_in), .clk(clk), .reset(reset)); //realiza a contagem.
  registrador R (.Qo(b_out), .Qi(b_in), .clk(clk), .load(load));  //salva o valor do contador.
  bcd_7seg B (.DISP(out_7seg), .BCD(b_out));  //reproduz no display de 7 segmentos.
endmodule

//JUNÇÃO DE TRÊS CÉLULAS PARA UM CONTADOR MOD 1000.
module contadorMOD1000 (output [6:0] outA,outB,outC, output en_out, input en_in, clk, reset, load);
  reg [3:0] enable; //a variável 'enable' guarda as saídas/entradas 'en' de todos os contadores.
  assign enable[0] = en_in;
  celulaContagem C (.out_7seg(outC), .en_out(enable[1]), .en_in(enable[0]), .clk(clk), .reset(reset), .load(load)); //célula menos significativa.
  celulaContagem B (.out_7seg(outB), .en_out(enable[2]), .en_in(enable[1]), .clk(clk), .reset(reset), .load(load)); //célula do meio.
  celulaContagem A (.out_7seg(outA), .en_out(enable[3]), .en_in(enable[2]), .clk(clk), .reset(reset), .load(load)); //célula mais significativa.
  assign en_out = enable[3];
endmodule
