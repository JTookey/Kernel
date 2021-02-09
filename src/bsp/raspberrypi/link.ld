/* SPDX-License-Identifier: MIT OR Apache-2.0
 *
 * Copyright (c) 2018-2021 Andre Richter <andre.o.richter@gmail.com>
 */

KERNEL_OFFSET = 0x80000;

SECTIONS
{
    /* Set current address to the value from which the RPi starts execution */
    . = KERNEL_OFFSET;

    __ro_start = .;
    .text :
    {
        *(.text._start) *(.text*)
    }


    .exception_vectors :
    {
        *(.exception_vectors*)
    }


    .rodata :
    {
        *(.rodata*)
    }
    . = ALIGN(65536); /* Fill up to 64 KiB */
    __ro_end = .;


    .data :
    {
        *(.data*)
    }


    /* Section is zeroed in u64 chunks, align start and end to 8 bytes */
    .bss ALIGN(8):
    {
        __bss_start = .;
        *(.bss*);
        . = ALIGN(8);

        /* Fill for the bss == 0 case, so that __bss_start <= __bss_end_inclusive holds */
        . += 8;
        __bss_end_inclusive = . - 8;
    }

    /DISCARD/ : { *(.comment*) }
}