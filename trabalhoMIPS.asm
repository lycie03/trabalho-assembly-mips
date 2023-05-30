.data
	new_line:  .asciiz "\n"	
	
	Menu: .asciiz "\n=== ESCOLHA UMA DAS OP��ES A SEGUIR ==="
	Escolhas: .asciiz "1 - Farenheint --> Celcius\n2 - Fibonnacci\n3 - En�simo Par\n4 - Sair.\n"
	
	Farenheint: .asciiz "==> Insira a temperatura em Farenheint (OBS: o resultado da covers�o em �C aparecer� em seguida): "
	Faren: .float 1.8
	Faren1: .float 32.0
	
	Fibonacci: .asciiz "==> Qual o n� da sequ�ncia voc� quer encontrar?\nR: "
	Fibonacci1: .asciiz "==> O n�mero que est� nessa posi��o da sequ�ncia � o n�mero "
	Limite: .asciiz" ==> Valor m�ximo ultrapassado (limite: 40)\n"
	
	Enesimopar: .asciiz "==> Qual n� par voc� deseja encontrar?\nR: "
	Resultado_Par: .asciiz "==> O n�mero par que est� nessa posi��o � o n�mero "
	
	Saida: .asciiz "\nFechando..."
.text 

main:
	# Aqui s�o defini��es dos valores para serem comparados pro Menu
	li $t0, 1 # Neste caso ele atribui o valor 1 ao $t0, os outros seguem o mesmo racioc�nio
	li $t1, 2
	li $t2, 3
	li $t3, 4
	
	#Print do Menu
	la $a0, Menu # Carrega a string Menu
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o
	
	la $a0, Escolhas # Carrega a string Escolhas
	li $v0, 4 # Define para a fun��o print
	syscall # Chama a fun��o print
	
	li $v0, 5 # Carrega a fun��o read_int
	syscall # Chama a fun��o read_int
	move $s0, $v0 # Move o valor digitado para $s0	
	
	beq $s0, $t0, FARENHEINT # Compara o $s0 com o $t0 se for igual pula para a fun��o FARENHEINT
	beq $s0, $t1, FIBONNACCI # Compara o $s0 com o $t1 se for igual pula para a fun��o FIBONNACCI
	beq $s0, $t2, ENENPAR # Compara o $s0 com o $t2 se for igual pula para a fun��o ENEMPAR
	beq $s0, $t3, SAIR # Compara o $s0 com o $t3 se for igual pula para a fun��o SAIR

FARENHEINT:
	la $a0, Farenheint  # Carrega a string Farenheit
	li $v0, 4          # Define para a fun��o Print_String
	syscall            # DChama a fun��o Print_String
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o	
	
	li $v0, 6          # Carrega a fun��o Read_float
	syscall            # Chama a fun��o Read_float
	mov.s $f2, $f0     # Move o valor de entrada($f0) para $f2 (Valor em Fahrenheit)
	
	l.s $f4, Faren1     # Carrega o valor 32.0 em $f4
	sub.s $f2, $f2, $f4  # Subtrai 32.0 de $f2
	
	l.s $f6, Faren # Carrega o valor de 1.8 em $f6
	div.s $f4, $f2, $f6  # Divide $f2 por 1.8 (convers�o para Celsius)
	
	mov.s $f12, $f4   # Move o resultado para $f12
	li $v0, 2          # Carrega a fun��o Print_float	
	syscall            # Chama a fun��o print_float
	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o	
	
	j main # Retorna ao in�cio do programa


FIBONNACCI: # Esta � a fun��o inicial para carregar o �ndice que o usu�rio quer encontrar
	la $a0, Fibonacci # Carrega a string Fibonacci
	li $v0, 4 # Carrega a fun��o print_string
	syscall # Chama a fun��o
	
	li $v0, 5 # Carrega a fun��o read_int
	syscall
	move $s0, $v0 # Move o valor digitado para $s0
	
	li $t5, 0  # Inicializa $t5 com 0 (valor atual)
	li $t6, 1  # Inicializa $t6 com 1 (pr�ximo valor)	
	
    	li $t4, 40     # O limite m�ximo da sequ�ncia (neste caso, 40)

    	ble $s0, $t4, FIBONACCI_CALC  # Verifica se o valor est� abaixo ou igual ao limite

	la $a0, Limite # Carrega a string Limite
	li $v0, 4  # Carrega a fun��o print_string
	syscall # Chama a fun��o
	j main # Retorna ao in�cio do programa


	    
FIBONACCI_CALC: # Este j� � o c�lculo do �ndice, usando um sistema de "Quantos loops faltam para chegar ao indice"	
   	beq $s0, $s0, PRIMEIRO_FIBONACCI  # Salta para a fun��o PRIMEIRO_FIBONACCI para corrigir o indice

SEQUENCIA_PRIMARIA: #Este � o c�lculo normal da sequ�ncia
   	beq $s0, $zero, FIM_FIBONACCI  # Verifica se X � igual a 0, sai do loop
    
    	add $t0, $t5, $t6  # Calcula o pr�ximo n�mero da sequ�ncia
    	move $t5, $t6      # Atualiza $t0 com o valor de $t1
    	move $t6, $t0      # Atualiza $t1 com o valor de $t2

PRIMEIRO_FIBONACCI: # Neste caso isso � para que a fun��o comece com 1 sendo valor inicial, pois se n�o o 3� valor ser� 3 e n�o 2, como � na sequ�ncia. Essa foi a melhor forma que encontramos para arrumar isso.   
	sub $s0, $s0, 1    # Decrementa o valor de X em 1, ao in�cio do c�lculo conferindo se est� tudo certo
    
    j SEQUENCIA_PRIMARIA        # Volta para o loop do c�lculo, novamente para corrigir o indice
 
FIM_FIBONACCI:    	   	
    	la $a0, Fibonacci1 # Carrega a string Fibonacci1
    	li $v0, 4 # Carrega a fun��o read_string
    	syscall # Chama a fun��o
    	
    	move $a0, $t0 # Move o valor de $t0 para o $a0
    	li $v0, 1 # Carrega a fun��o read int
    	syscall # Chama a fun��o
    	
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o	    	
    	
    	j main # Retorna ao in�cio do programa
    		
ENENPAR: # Pensamos em colocar um par�metro de overflow, mas pra dar overflow tem que ser um valor MUUUUITO GRANDE e ESPECIFICO. O Fibonnacci mexe com n�meros maiores muito mais r�pido ent�o � necessario, mas nesse n�o.
    	la $a0, Enesimopar # Imprime a mensagem "Qual n�mero par voc� deseja encontrar?"
    	li $v0, 4 # Carrega a fun��o read_string
    	syscall # Chamada da fun��o
    	
    	
    	li $v0, 5 # L� o valor de n, o en�simo n�mero par
    	syscall # Chamada da fun��o
    	move $s0, $v0 # Manda o valor de $v0 para $s0
    	
    	# Calcula o en�simo n�mero par
    	li $t0, 2  # Constante 2 para multiplica��o
    	mul $t1, $s0, $t0  # Multiplica n por 2 e armazena em $t1
    	
    	# Imprime o resultado
    	la $a0, Resultado_Par # Carrega a string Resultado_Par
    	li $v0, 4 # Carrega a fun��o Print_string
    	syscall # Chama a fun��o
    
    	move $a0, $t1 # Carrega o valor de $t1 no $a0
    	li $v0, 1 # Carrega a fun��o read_int 
	syscall # Chama a Fun��o
    
	la $a0, new_line # Carrega a New_Line
	li $v0, 4 # Defini��o da fun��o print
	syscall # Chamada da fun��o    
    	
    	j main # Retorna ao in�cio do programa
SAIR:
	la $a0, Saida #Carrega a string Saida
	li $v0, 4 # Carrega a fun��o print_string
	syscall # Chamada da fun��o
	
	li $v0, 10 # Carrega a fun��o EXIT
	syscall	# Chamada da fun��o
	
	


