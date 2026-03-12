[bits 16]
[org 0x7c00]

start:
    mov ax, 0x0013      ; Set VGA 320x200
    int 0x10

    call draw_splash_screen
    call wait_timer     ; Keep logo on screen
    call clear_screen   ; Prepare for main interface
    jmp main_interface

draw_splash_screen:
    ; Paint background blue
    mov ax, 0xA000
    mov es, ax
    mov cx, 64000
    mov al, 0x09        ; Electric Blue
    xor di, di
    rep stosb

    ; Draw simple "LIGHTNINGS" logo (starting offset)
    mov di, (80 * 320) + 100
    mov byte [es:di], 0x0F    ; Pixel for L
    mov byte [es:di+320], 0x0F
    mov byte [es:di+640], 0x0F
    mov byte [es:di+960], 0x0F
    mov byte [es:di+1280], 0x0F
    mov byte [es:di+1281], 0x0F ; L finished
    ret

wait_timer:
    mov cx, 0xFFFF
    .outer_loop:
        push cx
        mov cx, 0xFFFF
        .inner_loop: loop .inner_loop
        pop cx
        loop .outer_loop
    ret

clear_screen:
    mov ax, 0xA000
    mov es, ax
    mov cx, 64000
    mov al, 0x00        ; Black
    xor di, di
    rep stosb
    ret

main_interface:
    ; Main OS kernel logic
    hlt
    jmp main_interface

times 510-($-$$) db 0
dw 0xAA55
