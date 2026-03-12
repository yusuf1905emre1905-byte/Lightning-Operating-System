[bits 16]
[org 0x7c00]

start:
    mov ax, 0x0013
    int 0x10

    mov ax, 0xA000
    mov es, ax

    mov cx, 64000
    mov al, 0x09
    xor di, di
    rep stosb

.loop:
    hlt
    jmp .loop

times 510-($-$$) db 0
dw 0xAA55
