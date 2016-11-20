F100L  
=====

F100L is a set of utilities for programming and emulation of the Ferranti F100-L CPU and associated peripheral chips.

Currently this is a work in progress and the only component checked in is an initial draft of the assembler, F100Asm.

Using the Assembler
===================

The standard command line is

``F100ASM  -f|--filename <assembler_file.txt> -h|--help``

All output is sent only to a listing file currently.

Assembler File Format
=====================


**Comments**

Comments can be placed anywhere in the code and start with the semi-colon (;) character, e.g.

``ADDS 0x134 ; add the magic number to the accumulator``


**Labels**

Labels can be placed anywhere in the code and will be evaluated during the first assembly pass.

Labels must start with an alphabetic character or an underscore, end with a ':' and any combination of alphanumeric characters or underscores is allowed in between.

All labels and variables are case insensitive; they will all be converted to upper case during symbol table processing. e.g.

``LOOP_TOP:    SRL  0x01 A``


**Directives**

F100ASM supports the following directives, all of which start with the dot (.) character

``.ORG <address>``

``.EQU <variable name> <expression>``

``.DATA <data> [, <data> [, ... ]]]``

``.WORD <data> [, <data> [, ... ]]]``


``.ORG`` sets the current instruction address to the value supplied before assembling the next instruction. e.g.

``.ORG 0x0800 ; Instruction execution starts at 0x800 following a reset when AdSel is left floating or tied high``


``.EQU`` is used to assign expressions or values to variable names. e.g.  

``.EQU  PTR_START 0x100``

``.EQU  STK_PTR1  PTR_START+1``

``.EQU  MEMTOP    0x7FFF`` 

``.EQU  STK_SIZE  0x0400``   

``.EQU  STK_BOT   MEMTOP - STK_SIZE``

F100ASM uses the Python ASR parser class to allow parsing of any valid Python expression. All expressions must evaulate to an integer number by the end of the first pass through the assembler. Expressions or symbols may be used anywhere a numerical value is allowed. 

Like labels all variable names must start with an alphabetic character or an underscore but subsequent characters may be alphanumeric. All variable names are case insensitive.

Note that the two symbols A and C are reserved words and may not be used as variable names.

Labels are treated like any other variable as far as expression parsing is concerned. 

``.DATA`` and ``.WORD`` are synonyms of each other. These can be followed by a list of comma separated numeric values or expressions on the same line. e.g.

``WORD 1,1,2,3,5,8 ; Fibonacci numbers``
     
``WORD STK_PTR1, MEMTOP - STKSIZE  ; examples of expressions``


**Unsupported features**

F100ASM doesn't directly support definition of macros or conditional assembly. These features are easily added by pre-processing the assembly source using the C-preprocessor (cpp).


License
-------

f100l is free software: you can redistribute it and/or modify it 
under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

f100l is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

See see <http://www.gnu.org/licenses/> for a copy of the GNU Lesser General Public License
