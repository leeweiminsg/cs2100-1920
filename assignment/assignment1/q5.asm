    addi $t1  , $s2  ,   4
    addi $t2  , $s2  ,  64
    addi $t3  , $zero, 136
LA: lw   $t4  , 0($t1)
    addi $t1  , $t1  ,  4
    addi $t3  , $t3  , -1
    beq  $t4  , $zero, LA
    add  $t5  , $zero, $zero
LB: beq  $t1  , $t2  , EX
    lw   $t4  , 0($t1)
    sll  $t5  , $t5  , 1
    add  $t5  , $t5  , $t4
    addi $t1  , $t1  , 4
E:  j    LB
EX: addi $t6  , $t3  , -136
    sll  $t3  , $t3  ,   23
    sll  $t5  , $t5  ,    8
SL: beq  $t6  , $zero, AN
    sll  $t5  , $t5  , 1
    addi $t6  , $t6  , 1
    j    SL
AN: or   $s3  , $zero, $t3
    or   $s3  , $s3  , $t5

Assume that the first instruction addi $t1, $s2, 4 is at address 0x21004208 and the initial value of $s2 is 0x11060040.

Memory
Address	Value
11060038	1
1106003C	0
11060040	0
11060044	0
11060048	0
1106004C	0
11060050	1
11060054	0
11060058	0
1106005C	1
11060060	0
11060064	0
11060068	0
1106006C	0
11060070	0
11060074	0
11060078	1
1106007C	0
11060080	1
11060084	0

$s2 = 285605952
$s3 = 1116741632
$t1 = 285605968                        
$t2 = 285606016
$t3 = 1107296256
$t4 = 1
$t5 = 9445376
$t6 = -4