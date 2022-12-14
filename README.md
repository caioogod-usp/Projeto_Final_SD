# Projeto_Final_SD
  Trabalho final da disciplina de Sistemas Digitais, no qual foi utilizada Verilog para criar simulações de um contador BCD (parte 3) e um Controlador de um conversor analógico para digital de rampa dupla (parte 4).

## Integrantes do Grupo
Artur Weber - 12675451, <br>
Caio Oliveira Godinho - 12731996, <br>
Daniel Contente Romanzini -12547614 , <br>
Gabriel Henrique Brioto - 12547764, <br>
Guilherme Chiarotto de Moraes - 12745229, <br>
Hugo Hiroyuki Nakamura - 12732037.

## Parte 3
  Nessa parte do projeto, foram criados módulos em verilog para o contador (contadorMOD10), registrador (registrador) e conversor de BCD para display de 7 segmentos (bcd_7seg). EM seguida foi criado o módulo contendo todos os 3 anteriores (celulaContagem), formando uma única estrutura, ou célula. Por fim, foi feito o módulo contendo 3 estruturas do tipo  celulaContagem, de forma que elas formam o contador BCD requisitado pela descrição do projeto. Todos os módulos estão no arquivo parte_3.sv, na pasta Parte3, junto a imagens das representações dos circuitos de cada módulo em RTL.
  
 
## Parte 4
  <p>Na última parte do projeto, foi criado o módulo para um conversor análógico para digital do tipo rampa dupla (fsm). O módulo encontra-se na pasta Parte4, junto com a representação em RTL do seu circuito.</p>
  <p>O conversor analógico-digital de rampa dupla implementado recebe um sinal de entrada (Vm) e o reproduz em um sinal digital de 0 a 999. A partir de uma máquina de estados, controla-se o carregamento e o descarregamento de um circuito integrador, gerando um sinal triangular (rampa dupla). Esse sinal triangular tem o pico em 'Vm' e sempre leva um tempo 'tx' no seu carregamento. É no tempo de descarregamento 'tm' que a medida do sinal é feita, pois, o contador zera no instante de tempo 'tx' e conta durante todo o intervalo 'tm'. No fim, quando o integrador descarrega completamente, um sinal é mandado ao registrador, que salva o valor do contador. Depois, tudo é reiniciado, o display de 7 segmentos mostra o valor digital de 'Vm' e a máquina de estados espera o comando de reinicio.</p>
