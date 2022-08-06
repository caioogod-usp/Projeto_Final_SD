//MODULO DA MÁQUINA DE ESTADOS.
module fsm (output reg [2:0] ch, output en_0, reset, input en_3, Vint_z, clk, iniciar);
  always @ (posedge clk or posedge iniciar) //toda vez que ocorrer uma borda positiva de clock ou iniciar.
    begin
      if (iniciar) //se sinal de iniciar foi recebido.
        begin
          en_0 = 1'b1; //habilita a contagem.
          reset = 1'b0;//desabilita o reinicio.
          
          ch[0] = 1'b1; //ativa a chave ch_vm, amplificador integrador carrega.
          ch[1] = 1'b0; //desativa a chave ch_ref.
          ch[2] = 1'b0; //desativa a chave ch_zr.
        end
      else
        begin
          if (en_3) //se o contador chegou no último valor da contagem
            begin
              ch[0] = 1'b0; //desativa a chave ch_vm.
              ch[1] = 1'b1; //ativa a chave ch_ref, permite que o amplificador integrador descarregue.
              ch[2] = 1'b0; //desativa a chave ch_zr.
            end
          if (Vint_z) //quando o amplificador integrador descarregar.
            //Quando Vint_Z chega em 1, os registradores salvam o valor da contagem.
            begin
              en_0 = 1'b0; //desabilita a contagem.
              reset = 1'b1;//reinicia o sistema.
              
              ch[0] = 1'b0; //desativa a chave ch_vm.
              ch[1] = 1'b0; //desativa a chave ch_ref.
              ch[2] = 1'b1; //ativa a chave ch_zr, a saída Vint_z vai a zero.
            end
        end
    end
endmodule
