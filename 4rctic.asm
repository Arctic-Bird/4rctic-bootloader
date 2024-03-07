; Credit: http://3zanders.co.uk/2017/10/13/writing-a-bootloader/
bits 16 ; 16 bit code
org 0x7c00 ; This transfers control over to the bootloader!
boot:
	mov si,hello
	mov ah,0x0e ; 0x0e = Write Character in TTY mode
.loop:
	lodsb
	or al,al ; Equivalent to "if al == 0"
	jz halt ; "if al == 0 jump to halt label"
	int 0x10 ; BIOS interrupt 0x10 (video services)
	jmp .loop
halt:
	cli ; Clear interrupt flag
	hlt ; Halt execution
hello: db "Hello world!",0

times 510 - ($-$$) db 0 ; pad remaining 510 bytes with 0
dw 0xaa55 ; Marks 512 byte sector bootable
