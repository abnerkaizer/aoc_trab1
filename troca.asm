#n,t,p,j - $s0, $s1, $s2, $s3
#cima
.data
	cima: .space 400000 #4*10^5
	baixo: .space 400000 #4*10^5
.text
#Lê n
li $v0,5
syscall
add $s0, $v0, $zero #s0 = n
sll $s0, $s0, 2#n*4
#Lê t
li $v0,5
syscall
add $s1, $v0, $zero #s1 = t

#index = $t0
li $t0,0
#Lê cima[]
loop1:
	li $v0,5
	syscall
	sw $v0, cima($t0) #cima[i] = v0
	addi $t0, $t0, 4 #i++
	bne $t0, $s0, loop1 # i != n
end1:
#index = $t0
li $t0,0
#Lê baixo[]
loop2:
	li $v0,5
	syscall
	sw $v0, baixo($t0)#baixo[i] = v0
	addi $t0, $t0, 4#i++
	bne $t0, $s0, loop2# i != n
end2:
#trocas
loop3:
	#p recebe posição inicial de troca
	li $v0,5
	syscall
	add $s2,$v0,$zero
	#j recebe posição final de troca
	li $v0,5
	syscall
	add $s3,$v0,$zero
	addi $s2, $s2, -1 #p--
	addi $s3, $s3, -1 #j--
	sll $s2,$s2,2 #p*4
	sll $s3,$s3,2 #j*4
	jal loop4
	addi $s1, $s1, -1 #t--
	bne $s1, $zero, loop3 #t != 0
	j exit
#Executa as trocas
loop4:
	lw $t0, cima($s2) #t0 = cima[p]
	lw $t1, baixo($s2) #t1 = baixo[p]
	sw $t1, cima($s2) #cima[p] = t1
	sw $t0, baixo($s2) #baixo[p] = t0
	addi $s2, $s2, 4 #p++
	slt $t2, $s3, $s2 #t2 = 1 se p > j
	beq $t2, $zero, loop4 # se p <=j
	jr $ra # retorno ao loop3
exit:
#index - i
li $t0,0
#while loop para printar cima[]
print:
	beq $t0, $s0, END #t0 == n
	lw $t1, cima($t0) #t1 = cima[i]
	#printa cima[i]
	li $v0,1
	add $a0, $t1,$zero #a0 = cima[i]
	syscall
	#printa os espaços entre os números
	li $v0,4
	li $t2,0x20
	sw $t2,0($gp)
	add $a0,$gp,$zero
	syscall
	addi $t0, $t0, 4 #i++
	j print
END: