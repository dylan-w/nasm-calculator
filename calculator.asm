bits    64    ; 64 bit mode

section .data
    prompt     db  "Enter a number: ", 0     ; Prompt message (null-terminated)
    prompt_len equ $ - prompt                ; Length of the prompt

    prompt2    db  "The number is: ", 0      ; Prompt message (null-terminated)
    prompt2_len equ $ - prompt2              ; Length of the prompt

    buffer     db  0, 0, 0, 0, 0, 0, 0, 0, 0 ; Buffer for storing user input
    buffer_len equ 9                         ; Max input length

section .bss
    num resb 4 ; Reserve space for the integer

section .text
    global _main

_main:
    ; Display prompt
    mov     rax, 0x2000004    ; sys_write system call number
    mov     rdi, 1            ; file descriptor 1 (stdout)
    lea     rsi, [rel prompt] ; pointer to prompt message
    mov     rdx, prompt_len   ; length of the prompt
    syscall                   ; call kernel

    ; Read user input
    mov     rax, 0x2000003    ; sys_read system call number
    mov     rdi, 0            ; file descriptor 0 (stdin)
    lea     rsi, [rel buffer] ; pointer to buffer for input
    mov     rdx, buffer_len   ; max number of bytes to read
    syscall                   ; call kernel

    ; Display prompt2
    mov     rax, 0x2000004    ; sys_write system call number
    mov     rdi, 1            ; file descriptor 1 (stdout)
    lea     rsi, [rel prompt2] ; pointer to buffer
    mov     rdx, prompt2_len   ; length of the buffer
    syscall                   ; call kernel

    ; Display the number
    mov     rax, 0x2000004    ; sys_write system call number
    mov     rdi, 1            ; file descriptor 1 (stdout)
    lea     rsi, [rel buffer] ; pointer to prompt message
    mov     rdx, buffer_len   ; length of the prompt
    syscall                   ; call kernel

    ; (Optional) Add code here to convert ASCII input in buffer to an integer

    ; Exit program
    mov     rax, 0x2000001 ; sys_exit system call number
    xor     rdi, rdi       ; exit code 0
    syscall                ; call kernel
