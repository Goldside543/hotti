int main() {
    putc('H');
    putc('e');
    putc('l');
    putc('l');
    putc('o');
    putc(' ');
    putc('f');
    putc('r');
    putc('o');
    putc('m');
    putc(' ');
    putc('C');
    putc('!');
    putc('\r');
    putc('\n');

    #asm
        cli
        hlt
    #endasm
}
