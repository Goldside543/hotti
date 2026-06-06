# Hotti
A small 16-bit real mode operating system. Perhaps I should give some backstory.

Basically, I got sick of Goldspace. No, I'm not cancelling it, I just got sick of it. It's been in development for over a year and it can hardly get into ring 3. So I decided to start a new, easier OS dev project.

Introducing Hotti, a 16-bit operating system where I can freely rely on BIOS interrupts and not have to worry about pesky protected mode things like paging or preemptive multitasking.

Hotti's big thing is that applications are on floppies and you switch between em by ejecting a floppy and inputting a new one. Hot swapping.
