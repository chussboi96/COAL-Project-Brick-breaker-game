
; BRICKBREAKER GAME
; GROUP PROJECT BY: HAMMAD JAVAID       i21-1661
;                   MUHAMMAD SOBAN      i21-1730
;                   TALHA RASHID        i21-1365
;                   SHAHBAZ HAIDER      i21-2674



EXTERNDELAY = 3
.stack 100h
.model small
.data
msg1 db "NEW GAME$"
msg2 db "Instructions.$"
msg3 db "High Score$"
msg4 db "Exit$"
msg5 db "  BRICK BREAKER GAME  $"
msg6 db "Your Name=$"
msg7 db "->$"
n db 30(?)
var1 db ?
instr db "Use arrow keys to navigate space to fire & ESC to exit.$"

score db 'YOUR SCORE: $'
scoreCount dw 0
lives db '            LIVES: '
livesCount db 51
ending db ' $'


ballY dw 163
ballX dw 158
ballLeft db 1
ballUp db 1
color db ?
startx dw ?
starty dw ?
endx dw ?
endy dw ?       
begin db 0
strikerX dw 140
strikerY dw 170
innerDelay db 0
boundaryEnd dw 250
boundaryStart dw 30

brick1x dw 45
brick1y dw 25
brick2x dw 80
brick2y dw 25
brick3x dw 115
brick3y dw 25
brick4x dw 150
brick4y dw 25
brick5x dw 185
brick5y dw 25
brick6x dw 220
brick6y dw 25

brick7x dw 45
brick7y dw 35
brick8x dw 80
brick8y dw 35
brick9x dw 115
brick9y dw 35
brick10x dw 150
brick10y dw 35
brick11x dw 185
brick11y dw 35
brick12x dw 220
brick12y dw 35

brick13x dw 45
brick13y dw 45
brick14x dw 80
brick14y dw 45
brick15x dw 115
brick15y dw 45
brick16x dw 150
brick16y dw 45
brick17x dw 185
brick17y dw 45
brick18x dw 220
brick18y dw 45

brick19x dw 45
brick19y dw 55
brick20x dw 80
brick20y dw 55
brick21x dw 115
brick21y dw 55
brick22x dw 150
brick22y dw 55
brick23x dw 185
brick23y dw 55
brick24x dw 220
brick24y dw 55

brick25x dw 45
brick25y dw 65
brick26x dw 80
brick26y dw 65
brick27x dw 115
brick27y dw 65
brick28x dw 150
brick28y dw 65
brick29x dw 185
brick29y dw 65
brick30x dw 220
brick30y dw 65

.code
redrawStriker macro visColor

mov color, visColor
call drawStriker
endm

redrawBall macro visColor
    mov color, visColor
    call drawball
endm

BuildBrick macro  A, B
    push ax
    push bx
    mov ax, A
    mov bx, B
    call AddBrick
    pop bx
    pop ax
endm

DestroyBrick macro  A, B
    push ax
    push bx
    mov ax, A
    mov bx, B
    call RemoveBrick
    call beep     
    inc scoreCount
    call DrawLivesScores
    pop bx
    pop ax
endm

BrickCollision MACRO X, Y
local copper
    push ax
    push bx
    push cx
    push dx
    mov ax, ballY
    mov bx, ballX
    mov cx, X
    mov dx, Y
    
    cmp dx, ballY
    jl copper
    sub dx, 7
    
    cmp ballY, dx
    jl copper
    
    mov dx, X 
    
    cmp ballX, dx
    jl copper
    add dx, 30
    cmp dx, ballX
    jl copper
    
    call switcher
    DestroyBrick X, Y
    mov Y, 300
    cmp scoreCount, 30
    jne copper
    mov ah,4ch
    int 21h
    
    copper:
    pop dx
    pop cx
    pop bx
    pop ax                      
    
endm

main proc
    mov ax,@data
    mov ds,ax
    Mov ah,00h
    Mov al,12h
    Int 10h
    mov ah, 6        
    mov al, 0          
    mov bh, 00001000b   
    mov ch, 0           
    mov cl, 0           
    mov dh, 30          
    mov dl, 90         
    int 10h

    Mov si,offset msg1
Mov cx,8
mov dh, 6        
mov dl, 37 

loop1:
	mov ah, 2          
	mov bh, 0           
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop1


Mov si,offset msg2
Mov cx,12
mov dh, 8        
mov dl, 35 

loop2:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop2

Mov si,offset msg3
Mov cx,10
mov dh, 10        
mov dl, 36 

loop3:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop3

Mov si,offset msg4
Mov cx,4
mov dh, 12        
mov dl, 39 

loop4:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop4


Mov si,offset msg5
Mov cx,18
mov dh, 2        
mov dl, 32 

loop5:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop5

Mov si,offset msg6
Mov cx,10
mov dh, 1        
mov dl,55 

loop6:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

	Mov ah,2
	Mov bh,0
	Mov dh,6
	Mov dl,37
	Int 10h

	Mov si,offset msg7
	Mov cx,2
	mov dh, 6        
	mov dl, 33 

loop10:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop10

Mov ah,1
Int 21h
Mov var1,al
Cmp var1,13
je j1
jmp j2

j1:
	Mov ah,00h
	Mov al,12h
	Int 10h
	jmp exit_zero

j2:
	Mov ah,2
	Mov bh,0
	Mov dh,8
	Mov dl,30
	Int 10h

	Mov si,offset msg7
	Mov cx,2
	mov dh, 8        
	mov dl, 30 
loop11:

	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop11

Mov ah,1
Int 21h
Mov var1,al
Cmp var1,13
je j3
jmp j4

j3:
	Mov ah,00h
	Mov al,12h
	Int 10h

	Mov si,offset instr
	Mov cx,58
	mov dh, 6        
	mov dl, 37 
	int 10h
	jmp exit_zero

loop12:
	mov ah, 2          
	mov bh, 0           
        
	int 10h         

	mov ah, 9    
	mov al, [si]       
	mov bl, 00000110b        
	mov bh, 0             
                
	int 10h

	Add dl,1
	Add si,1

Loop loop12

j4:

    call setVideoMode
    call drawBoundary
    BuildBrick brick1x brick1y
    BuildBrick brick2x brick2y
    BuildBrick brick3x brick3y
    BuildBrick brick4x brick4y
    BuildBrick brick5x brick5y
    BuildBrick brick6x brick6y
    BuildBrick brick7x brick7y
    BuildBrick brick8x brick8y
    BuildBrick brick9x brick9y
    BuildBrick brick10x brick10y
    BuildBrick brick11x brick11y
    BuildBrick brick12x brick12y
    BuildBrick brick13x brick13y
    BuildBrick brick14x brick14y
    BuildBrick brick15x brick15y
    BuildBrick brick16x brick16y
    BuildBrick brick17x brick17y
    BuildBrick brick18x brick18y
    BuildBrick brick19x brick19y
    BuildBrick brick20x brick20y
    BuildBrick brick21x brick21y
    BuildBrick brick22x brick22y
    BuildBrick brick23x brick23y
    BuildBrick brick24x brick24y
    BuildBrick brick25x brick25y
    BuildBrick brick26x brick26y
    BuildBrick brick27x brick27y
    BuildBrick brick28x brick28y
    BuildBrick brick29x brick29y
    BuildBrick brick30x brick30y

    redrawStriker 69
    redrawBall 4                
    call DrawLivesScores
    
    call gameLoop      
    
    mov ah,4ch
    int 21h

exit_zero:
    mov ah, 4ch
    int 21h

DrawLivesScores proc
    push dx
    push ax
                 
    mov dh, 23 ;row
    mov dl, 5 ;col
    mov ah, 2 
    int 10h
    
    lea dx, score
    mov ah, 9
    int 21h
    
    call printScore
    
    lea dx,lives
    mov ah,9
    int 21h  

    pop ax
    pop dx
    ret
    DrawLivesScores endp

printScore proc
    push ax
    push bx
    push cx
    push dx
    
    mov cx,0
    
    mov ax,scoreCount
    ll:
    mov bx,10
    mov dx,0
    div bx
    push dx
    inc cx
    cmp ax,0
    jne ll
    
    l2:
    pop dx
    mov ah,2
    add dl,'0'
    int 21h
    loop l2
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
    printScore endp

sleep proc

mov cx,111111111111111b 

l:
loop l
ret
sleep endp

drawball proc
    push bx
    mov bx, ballX
    mov startx, bx
    add bx, 4 
    mov endx,   bx
    mov bx, ballY
    mov starty, bx
    add bx, 4
    mov endy,   bx
    
    pop bx
    
    call draw
ret
drawball endp

CollisionStriker proc    
    push ax
    push bx
    push cx
    push dx
    
    mov dx, ballY
    cmp dx, 165 
    ; striker surface check
    jl go
    cmp dx, 170 ; striker missed
    jg fail 
    
    
    mov cx,strikerX   
    mov ax, ballX   
    cmp ax, cx  
    jl go
    add cx , 40 
    cmp ax, cx
    jg go
    
    mov ballUp, 1
    jmp go
    
    
    fail:
    mov begin,0 
    dec livesCount
    cmp livesCount,48
    je end1
    push ax
    push bx
    push cx
    push dx
    
    
    redrawBall 0
    
    mov ax, strikerX
    mov ballX,ax
    add ballX,18
    
    mov ballY,  163
    
    redrawBall 4
    mov ballUp, 1     ;monis
    mov ballLeft,0
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    call DrawLivesScores
    jmp go
    
    end1:             
    call DrawLivesScores
    mov ah,4ch
    int 21h 
                  
    go:  
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    CollisionStriker endp


switcher:
    cmp ballUp, 1
    je DownT
    jne UpT
    UpT:
    inc ballUp
    ret
    DownT:
    dec ballUp
    ret

AddBrick proc
    push ax
    push bx    
    mov startx, ax
    mov color, 13  
    mov ax, bx
    mov bx, startx

    add bx, 30
    mov endx,bx

    mov starty, ax 
    mov bx,starty 
    add bx, 7
    mov endy,bx
     
    call draw
    pop bx
    pop ax 
    ret
    AddBrick endp

RemoveBrick proc 
    push ax
    push bx
    push cx
    push dx
       
    mov startx, ax
    mov color, 0  
    mov ax, bx
    mov bx, startx
    
    add bx, 30
    
    mov endx,bx
    
    mov starty, ax 
    mov bx,starty
    
    add bx, 7
    mov endy,bx
     
    call draw 
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    RemoveBrick endp

Collisionwall proc     
    mov bx, ballX
    mov cx, ballY
    
    checkLR:
    cmp bx, 25; max left
    jl goRight
    cmp bx, 290; Max Right
    jg goLeft
    jmp checkUpDown
    goRight:
    mov ballLeft, 0 
    jmp checkUpDown;
    goLeft:
    mov ballLeft, 1

    checkUpDown:
    cmp cx, 13;max top
    jl goDown
    cmp cx, 184;max bottom
    jg goUp
    
    
    jmp noInput
    goUp:                                            
    mov ballUp,1
    jmp noInput
    goDown: 
    mov ballUp, 0
  
    ret
    Collisionwall endp

gameOver proc
    
    mov ah,4ch
    int 21h
    gameOver endp

wierd:
ret
baller proc  
    
	inc innerDelay
	cmp innerDelay, EXTERNDELAY
	jne wierd 
	mov innerDelay, 0
    redrawBall 0  
    
	mov bx,ballX 
	cmp ballLeft, 1
	je Left
	jne Right
	
	Left:   
	sub bx, 2 
	jmp P2;  
	Right:   
	add bx, 2
	
	P2:
	mov ballX,  bx
	mov bx, ballY
	cmp ballUp, 1   
	je Up
	jne Down
	Up:
    sub bx, 2
	jmp P3
	Down:
    add bx, 2
	P3:
    mov ballY,  bx
   
    redrawBall 4
    
ret
baller endp   


repeat:
gameLoop:        
   CALL    checkKeyboard
   cmp begin,1
   jne repeat
   

   call Collisionwall
   call CollisionStriker 
   BrickCollision Brick1x, Brick1y
   BrickCollision Brick2x, Brick2y
   BrickCollision Brick3x, Brick3y
   BrickCollision Brick4x, Brick4y
   BrickCollision Brick5x, Brick5y
   BrickCollision Brick6x, Brick6y 
   BrickCollision Brick7x, Brick7y
   BrickCollision Brick8x, Brick8y
   BrickCollision Brick9x, Brick9y
   BrickCollision Brick10x, Brick10y
   BrickCollision Brick11x, Brick11y
   BrickCollision Brick12x, Brick12y
   BrickCollision Brick13x, Brick13y
   BrickCollision Brick14x, Brick14y
   BrickCollision Brick15x, Brick15y
   BrickCollision Brick16x, Brick16y
   BrickCollision Brick17x, Brick17y
   BrickCollision Brick18x, Brick18y 
   BrickCollision Brick19x, Brick19y
   BrickCollision Brick20x, Brick20y
   BrickCollision Brick21x, Brick21y
   BrickCollision Brick22x, Brick22y
   BrickCollision Brick23x, Brick23y
   BrickCollision Brick24x, Brick24y
   BrickCollision Brick25x, Brick25y
   BrickCollision Brick26x, Brick26y
   BrickCollision Brick27x, Brick27y
   BrickCollision Brick28x, Brick28y
   BrickCollision Brick29x, Brick29y
   BrickCollision Brick30x, Brick30y 
   
   CALL baller  
   CALL sleep
   JMP  gameLoop 
    
exit:
    mov ah, 4ch
    int 21h

checkKeyboard proc
    mov     ah,     1h
    int     16h         ; check keypress
    jz      noInput     ; no keypress
    mov     ah,     0h
    int     16h
    cmp     ax,     4D00h
    je      rightKey
    cmp     ax,     4B00h
    je      leftKey
    cmp     al,     27D
    je      exit
    cmp     ax,     3920h;space to begin
    je      beg
    jne     noInput
    
    beg:
    mov begin,1
    
    noInput:
    ret  

    rightKey:     
    mov bx, boundaryEnd
    cmp     strikerX, bx ;max right limit
    jg      noInput
    redrawStriker 0
    add     strikerX, 5
    redrawStriker 69
    cmp begin,0
    jz moveBallRight
    jmp     noInput
    
    
    leftKey:   
    mov bx, boundaryStart                            
    cmp     strikerX, bx ;max left limit
    jl      noInput
    redrawStriker 0
    sub     strikerX, 5
    redrawStriker 69
    cmp begin,0
    jz moveBallLeft
    jmp     noInput
    
    
    moveBallLeft:
    redrawBall 0
    sub     ballX, 5
    redrawBall 4
    jmp     noInput
    
    
    moveBallRight:
    redrawBall 0
    add     ballX, 5
    redrawBall 4
    jmp     noInput

checkKeyboard endp

draw proc
    push ax
    push cx
    push dx
     
    mov dx,starty
    mov cx,startx
    mov ah,0ch
    mov al,color
    c:
    inc cx
    int 10h
    cmp cx,endx
    jne c

    mov cx,startx
    inc dx
    cmp dx,endy
    jne c 
    
    pop dx
    pop cx
    pop ax
    ret
draw endp

drawStriker proc
    push bx
    push cx
        
    mov bx, strikerX
    mov cx, strikerY   
    mov startx, bx
    add bx, 40
    mov endx, bx
    mov starty, cx
    mov endy, 175
    call draw
    
    pop cx
    pop bx
    ret
    drawStriker endp

drawBoundary proc
    mov color, 9  
    ;------TOP------------
    mov startx, 10
    mov endx, 310
    mov starty,5
    mov endy,8
    call draw
    ;------RIGHT------------
    mov startx, 307
    mov endx, 310
    mov starty, 7
    mov endy, 180
    call draw
    ;------LEFT------------
    mov startx, 10
    mov endx, 13
    mov starty,7
    mov endy, 180
    call draw
    ;------BOTTOM------------
    mov startx,10
    mov endx, 310
    mov starty,177
    mov endy,180
    call draw 
   
    ret
    drawBoundary endp


setVideoMode proc
    
    mov ah, 0   ; set display mode function.
    mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    int 10h     
    
    ret
    setVideoMode endp

beep proc
        push ax
        push bx
        push cx
        push dx
        mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, 400        ; Frequency number (in decimal)
                                ;  for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        in      al, 61h         
        or      al, 00000011b   
        out     61h, al         
        mov     bx, 2          
.pause1:
        mov     cx, 65535
.pause2:
        dec     cx
        jne     .pause2
        dec     bx
        jne     .pause1
        in      al, 61h         
        and     al, 11111100b   
        out     61h, al         

        pop dx
        pop cx
        pop bx
        pop ax

ret
beep endp


main endp
end main