; multi-segment executable file template.


; Find the mean and median of array of 9 elements

ASSUME CS:CODE, DS:DATA
data segment
    ; add your data here!
    count equ 09h
    vec1 db 0ch,0fh,11h,14h,18h,1ch,1eh,1fh,20h
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
;finding the mean 
    lea si,vec1    
    mov cl,count   
    mov ax,0
sum:add al,[si]
    inc si         ; this sum loop finds the total of all elements in array  
    dec cl
    jnz sum
      
    mov cl,count   ; no of elements in array in cl as divisor
    div cl         ;
    
    mov dx,0000h   ; to store the result at 03000H
    mov ds,dx      ; making ds as 0000h
 
    mov bx,3000H   ; storing the quotient of mean
    mov [bx], al
    
    mov bx,3001H   ; storing the remainder of mean
    mov [bx],ah
                  
    mov ax,data
    mov ds,ax
    
;sorting the array      
            mov ch,count       ; ch will act as counter for outer loop in bubble sort
outer_loop: mov cl,count       ; cl will acts as counter for inner loop in bubble sort
            dec cl
            lea si,vec1
inner_loop: mov al,[si]        ; storing the arr[i] element in al
            mov ah,[si][1]     ; storing the arr[i+1] element in ah
            cmp ah,al          ; compare arr[i],arr[i+1]
            JNC ahead          ; if arr[i+1] > arr[i],dont excahnge move to next iteration
            mov [si],ah        ; else excahnge the arr[i],arr[i+1] in its memory location
            mov [si][1],al
ahead:      inc si             ; i++
            dec cl
            jnz inner_loop     
            dec ch
            jnz outer_loop
;finding the median
            lea bx,vec1[4]     ; since elements are predefined 9, median will be
            mov cl,[bx]        ; at 5th element after sorting the array
            mov ax,0           ; to store the result at 03100H, making DS as 0000H
            mov ds,ax
            mov bx,3100H       ; store the result            
            mov [bx],cl
      
ends
end start
            
   