label1:
addi $t1, $zero, 10
blez $t1, label1
sub $t1, $zero, $t1
blez $t1, label1