.code16
.global _start

# ----------------------------
# Embedded BPB (1.44MB FAT12)
# ----------------------------
jmp_boot:                  # 0x00: jump to boot code
    .byte 0xEB, 0x3C, 0x90   # JMP short 0x3E, NOP
    .ascii "MSDOS5.0"         # OEM Name, 8 bytes

# BIOS Parameter Block (BPB)
    .word 512           # Bytes per sector
    .byte 1             # Sectors per cluster
    .word 5             # Reserved sectors
    .byte 2             # Number of FATs
    .word 224           # Max root dir entries
    .word 2880          # Total sectors (for 1.44MB)
    .byte 0xF0          # Media descriptor
    .word 9             # Sectors per FAT
    .word 18            # Sectors per track
    .word 2             # Number of heads
    .long 0             # Hidden sectors
    .long 0             # Large total sectors

# Extended Boot Record / Drive params
    .byte 0             # Drive number (filled by BIOS)
    .byte 0             # Reserved
    .byte 0x29          # Signature
    .long 0x12345678    # Volume ID (dummy)
    .ascii "MICROSPACE " # Volume label, 11 bytes
    .ascii "FAT12   "    # File system type, 8 bytes

# ----------------------------
# Microspace bootloader code
# ----------------------------
_start:
    cli
    xorw %ax, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss
    movw $0x7C00, %sp
    sti

    # Keep BIOS boot drive
    movb %dl, boot_drive

    # Load kernel (1 sector) into 0x0000:0x8000
    movw $0x0000, %ax
    movw %ax, %es
    movw $0x8000, %bx

    movb $0x02, %ah          # INT 13h read sectors
    movb $0x01, %al          # number of sectors
    movb $0x00, %ch          # cylinder
    movb $0x02, %cl          # sector
    movb $0x00, %dh          # head
    movb boot_drive, %dl
    int $0x13

    jc disk_error

    # Jump to kernel
    ljmp $0x0000, $0x8000

disk_error:
    hlt
    jmp disk_error

boot_drive:
    .byte 0

    # Boot signature
    .org 510
    .word 0xAA55
