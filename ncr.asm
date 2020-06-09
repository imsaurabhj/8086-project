data segment
    n db 50
    r db 1 
    result db 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
      assume cs:code,ds:data
start:
      mov ax, data
      mov ds, ax
      mov al,n
      mov bl,r
      mov result,0
      call ncr
      mov ah,4ch
      int 21h
      
ncr proc
      cmp al,bl
      je ncr1                
      cmp bl,0
      je ncr1
      cmp bl,1
      je ncr2
      dec al
      push ax
      push bx
      call ncr
      pop bx
      pop ax
      dec bl
      push ax
      push bx
      call ncr
      pop bx
      pop ax
      ret
ncr1: 	      
      inc result
      ret
ncr2:	     
      add result,al
      ret
ncr endp
ends    

end start
