.data
	new_line:  .asciiz "\n"	
	
	Menu: .asciiz "\n=== ESCOLHA UMA DAS OPÇÕES A SEGUIR ==="
	Escolhas: .asciiz "1 - Farenheint --> Celcius\n2 - Fibonnacci\n3 - Enésimo Par\n4 - Sair.\n"
	
	Farenheint: .asciiz "==> Insira a temperatura em Farenheint (OBS: o resultado da coversão em ºC aparecerá em seguida): "
	Faren: .float 1.8
	Faren1: .float 32.0
	
	Fibonacci: .asciiz "==> Qual o nº da sequência você quer encontrar?\nR: "
	Fibonacci1: .asciiz "==> O número que está nessa posição da sequência é o número "
	Limite: .asciiz" ==> Valor máximo ultrapassado (limite: 40)\n"
	
	Enesimopar: .asciiz "==> Qual nº par você deseja encontrar?\nR: "
	Resultado_Par: .asciiz "==> O número par que está nessa posição é o número "
	
	Saida: .asciiz "\nFechando..."
.text 

main:
	# Aqui são definições dos valores para serem comparados pro Menu
	li $t0, 1 # Neste caso ele atribui o valor 1 ao $t0, os outros seguem o mesmo raciocínio
	li $t1, 2
	li $t2, 3
	li $t3, 4
	
	#Print do Menu
	la $a0, Menu # Carrega a string Menu
	li $v0, 4 # Definição da função print
	syscall # Chamada da função
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Definição da função print
	syscall # Chamada da função
	
	la $a0, Escolhas # Carrega a string Escolhas
	li $v0, 4 # Define para a função print
	syscall # Chama a função print
	
	li $v0, 5 # Carrega a função read_int
	syscall # Chama a função read_int
	move $s0, $v0 # Move o valor digitado para $s0	
	
	beq $s0, $t0, FARENHEINT # Compara o $s0 com o $t0 se for igual pula para a função FARENHEINT
	beq $s0, $t1, FIBONNACCI # Compara o $s0 com o $t1 se for igual pula para a função FIBONNACCI
	beq $s0, $t2, ENENPAR # Compara o $s0 com o $t2 se for igual pula para a função ENEMPAR
	beq $s0, $t3, SAIR # Compara o $s0 com o $t3 se for igual pula para a função SAIR

FARENHEINT:
	la $a0, Farenheint  # Carrega a string Farenheit
	li $v0, 4          # Define para a função Print_String
	syscall            # DChama a função Print_String
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Definição da função print
	syscall # Chamada da função	
	
	li $v0, 6          # Carrega a função Read_float
	syscall            # Chama a função Read_float
	mov.s $f2, $f0     # Move o valor de entrada($f0) para $f2 (Valor em Fahrenheit)
	
	l.s $f4, Faren1     # Carrega o valor 32.0 em $f4
	sub.s $f2, $f2, $f4  # Subtrai 32.0 de $f2
	
	l.s $f6, Faren # Carrega o valor de 1.8 em $f6
	div.s $f4, $f2, $f6  # Divide $f2 por 1.8 (conversão para Celsius)
	
	mov.s $f12, $f4   # Move o resultado para $f12
	li $v0, 2          # Carrega a função Print_float	
	syscall            # Chama a função print_float
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Definição da função print
	syscall # Chamada da função	
	
	j main # Retorna ao início do programa


FIBONNACCI: # Esta é a função inicial para carregar o índice que o usuário quer encontrar
	la $a0, Fibonacci # Carrega a string Fibonacci
	li $v0, 4 # Carrega a função print_string
	syscall # Chama a função
	
	li $v0, 5 # Carrega a função read_int
	syscall
	move $s0, $v0 # Move o valor digitado para $s0
	
	li $t5, 0  # Inicializa $t5 com 0 (valor atual)
	li $t6, 1  # Inicializa $t6 com 1 (próximo valor)	
	
    	li $t4, 40     # O limite máximo da sequência (neste caso, 40)

    	ble $s0, $t4, FIBONACCI_CALC  # Verifica se o valor está abaixo ou igual ao limite

	la $a0, Limite # Carrega a string Limite
	li $v0, 4  # Carrega a função print_string
	syscall # Chama a função
	j main # Retorna ao início do programa


	    
FIBONACCI_CALC: # Este já é o cálculo do índice, usando um sistema de "Quantos loops faltam para chegar ao indice"	
   	beq $s0, $s0, PRIMEIRO_FIBONACCI  # Salta para a função PRIMEIRO_FIBONACCI para corrigir o indice

SEQUENCIA_PRIMARIA: #Este é o cálculo normal da sequência
   	beq $s0, $zero, FIM_FIBONACCI  # Verifica se X é igual a 0, sai do loop
    
    	add $t0, $t5, $t6  # Calcula o próximo número da sequência
    	move $t5, $t6      # Atualiza $t0 com o valor de $t1
    	move $t6, $t0      # Atualiza $t1 com o valor de $t2

PRIMEIRO_FIBONACCI: # Neste caso isso é para que a função comece com 1 sendo valor inicial, pois se não o 3º valor será 3 e não 2, como é na sequência. Essa foi a melhor forma que encontramos para arrumar isso.   
	sub $s0, $s0, 1    # Decrementa o valor de X em 1, ao início do cálculo conferindo se está tudo certo
    
    j SEQUENCIA_PRIMARIA        # Volta para o loop do cálculo, novamente para corrigir o indice
 
FIM_FIBONACCI:    	   	
    	la $a0, Fibonacci1 # Carrega a string Fibonacci1
    	li $v0, 4 # Carrega a função read_string
    	syscall # Chama a função
    	
    	move $a0, $t0 # Move o valor de $t0 para o $a0
    	li $v0, 1 # Carrega a função read int
    	syscall # Chama a função
    	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Definição da função print
	syscall # Chamada da função	    	
    	
    	j main # Retorna ao início do programa
    		
ENENPAR: # Pensamos em colocar um parâmetro de overflow, mas pra dar overflow tem que ser um valor MUUUUITO GRANDE e ESPECIFICO. O Fibonnacci mexe com números maiores muito mais rápido então é necessario, mas nesse não.
    	la $a0, Enesimopar # Imprime a mensagem "Qual número par você deseja encontrar?"
    	li $v0, 4 # Carrega a função read_string
    	syscall # Chamada da função
    	
    	
    	li $v0, 5 # Lê o valor de n, o enésimo número par
    	syscall # Chamada da função
    	move $s0, $v0 # Manda o valor de $v0 para $s0
    	
    	# Calcula o enésimo número par
    	li $t0, 2  # Constante 2 para multiplicação
    	mul $t1, $s0, $t0  # Multiplica n por 2 e armazena em $t1
    	
    	# Imprime o resultado
    	la $a0, Resultado_Par # Carrega a string Resultado_Par
    	li $v0, 4 # Carrega a função Print_string
    	syscall # Chama a função
    
    	move $a0, $t1 # Carrega o valor de $t1 no $a0
    	li $v0, 1 # Carrega a função read_int 
	syscall # Chama a Função
    
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Definição da função print
	syscall # Chamada da função    
    	
    	j main # Retorna ao início do programa
SAIR:
	la $a0, Saida #Carrega a string Saida
	li $v0, 4 # Carrega a função print_string
	syscall # Chamada da função
	
	li $v0, 10 # Carrega a função EXIT
	syscall	# Chamada da função
	
	


