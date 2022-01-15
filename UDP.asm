bits    64
global  main
extern  scanf                               ; 调用外部函数scanf
section .data
    format   db "%s", 0
    ; socket_struct 接受数据主机地址的结构体              
    send_struct dw 2                        ; family ： 2
                db 10H,00H                  ; port,定义端口号
                db 127,0,0,1                ; address,采用局域网内广播
                db 0,0,0,0,0,0,0,0          ; empty byte

section .bss
       input        resb 128
       outputstr    resb 128

section .text

main:
    sub RSP, 8
    ; sys_socket
    mov rax,41          ;系统调用号
    mov rdi,2           ;family(协议族)    AF_INET
    mov rsi,2           ;type（传输方式、套接子类型）
    mov rdx,0           ;protocol（传输协议）
    syscall
    mov r11,rax

Asm_scanf:
    lea RDI, [format]
    lea RSI, [input]    
    mov RAX, 0
    call    scanf wrt ..plt
    lea     RDI, [outputstr]           
    lea     RSI, [input]            
    mov     RCX, 1024               
    cld                      
    rep     movsb 

UDP_Send:                   
    ; sys_sendto
    mov rdi,r11         ;df套接字接口的描述符
    mov rax,44          ;调用号
    mov rsi,input       ;指针类型，代表发送文件的缓冲区
    mov rdx,128         ;发送数据的长度
    mov r10,0           ;调用方式的标志位
    mov r8,send_struct  ;ip结构体
    mov r9,16           ;ip结构体长度
    syscall
    jmp Asm_scanf
