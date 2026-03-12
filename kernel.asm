[bits 16]
[org 0x7c00]

start:
    ; Set VGA 320x200 graphics mode
    mov ax, 0x0013
    int 0x10

    ; Set ES to video memory
    mov ax, 0xA000
    mov es, ax

    ; Draw Main Interface (Dark Blue background)
    mov cx, 64000
    mov al, 0x01        ; Dark Blue color
    xor di, di
    rep stosb

.idle:
    hlt
    jmp .idle

times 510-($-$$) db 0
dw 0xAA55
