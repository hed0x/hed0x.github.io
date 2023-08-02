; -----------------------------------------------------------------------------
; Binary Golf Grand Prix '23
;
; by hed0x 
;	~ hed0x@linuxmail.org
; -----------------------------------------------------------------------------
; NASM: 
;	nasm -f bin self_rep.asm -o self_rep.com
;
; Checksum:
; 	sha256sum self_rep.com
;	99622d24b81ec6ec663669a00679e8fd02cba2400d2ce1893420122622ec336d *self_rep.com
;	sha256sum 4.COM
;	99622d24b81ec6ec663669a00679e8fd02cba2400d2ce1893420122622ec336d *4.COM
;
; Base64 encoding:
;	base64 self_rep.com
;	jMiO2I7AvgABv8AHuQAE/POktA6wNM0QujABtDzNIYnDuTYAugABtEDNIbQ+zSHDNC5DT00A
; -----------------------------------------------------------------------------

org 100h

start:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov si, start
    mov di, 7C0h
    mov cx, 1024
    cld
    rep movsb

    ; Print the number 4 on the screen
    mov ah, 0x0E ; BIOS teletype function
    mov al, '4'  ; Character to print (ASCII code for '4')
    int 0x10

    ; Rename the copy to "4.COM"
    mov dx, fn
    mov ah, 0x3C ; Create or open file function
    int 0x21
    mov bx, ax   ; Store the file handle

    ; Write the contents to the new file
    mov cx, size
    mov dx, start
    mov ah, 0x40 ; Write to file function
    int 0x21

    ; Close the new file
    mov ah, 0x3E ; Close file function
    int 0x21

    ret

fn db '4.COM', 0
size equ $ - start
