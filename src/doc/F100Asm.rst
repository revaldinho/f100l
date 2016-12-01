====================
The F100-L Assembler
====================

Invoking The Assembler
======================

.. automodule:: F100Asm
   :members:


Assembler File Format
=====================

Comments
--------

Comments can be placed anywhere in the code and start with the semi-colon (;) character, e.g. ::

 ADDS 0x134 ; add the magic number to the accumulator


Labels
------

Labels can be placed anywhere in the code and will be evaluated during the first assembly pass.

Labels must start with an alphabetic character or an underscore, end with a ':' and any combination of alphanumeric characters or underscores is allowed in between.

All labels and variables are case insensitive; they will all be converted to upper case during symbol table processing. e.g. ::

 LOOP_TOP:    SRL  0x01 A


Directives
----------

F100ASM supports the following directives, all of which start with the dot (.) character

* ``.ORG <address>``

* ``.EQU <variable name> <expression>``

* ``.DATA <data> [, <data> [, ... ]]]``

* ``.WORD <data> [, <data> [, ... ]]]``

.ORG
^^^^

``.ORG`` sets the current instruction address to the value supplied before assembling the next instruction. e.g. ::

  .ORG 0x0800 ; Instruction execution starts at 0x800 following a reset when AdSel is left floating or tied high

.EQU
^^^^

``.EQU`` is used to assign expressions or values to variable names. e.g. ::

  .EQU  PTR_START 0x100
  .EQU  STK_PTR1  PTR_START+1
  .EQU  MEMTOP    0x7FFF
  .EQU  STK_SIZE  0x0400
  .EQU  STK_BOT   MEMTOP - STK_SIZE

F100ASM uses the Python ASR parser class to allow parsing of any valid Python expression. All expressions must evaulate to an integer number by the end of the first pass through the assembler. Expressions or symbols may be used anywhere a numerical value is allowed.

Like labels all variable names must start with an alphabetic character or an underscore but subsequent characters may be alphanumeric. All variable names are case insensitive.

Note that the two symbols A and C are reserved words and may not be used as variable names.

Labels are treated like any other variable as far as expression parsing is concerned.

.DATA and .WORD
^^^^^^^^^^^^^^^

``.DATA`` and ``.WORD`` are synonyms of each other. These can be followed by a list of comma separated numeric values or expressions on the same line. e.g.::

 .WORD 1,1,2,3,5,8 ; Fibonacci numbers
 .WORD STK_PTR1, MEMTOP - STKSIZE  ; examples of expressions

**Unsupported features**

F100ASM doesn't directly support definition of macros or conditional assembly. These features are easily added by pre-processing the assembly source using the C-preprocessor (cpp).

Example
-------

::

  # -------------------------------------------------------------------------------------------
  #     _____________  ____        __       ___                             __    __
  #    / ____<  / __ \/ __ \      / /      /   |  _____________  ____ ___  / /_  / /__  _____
  #   / /_   / / / / / / / /_____/ /      / /| | / ___/ ___/ _ \/ __ `__ \/ __ \/ / _ \/ ___/
  #  / __/  / / /_/ / /_/ /_____/ /___   / ___ |(__  |__  )  __/ / / / / / /_/ / /  __/ /
  # /_/    /_/\____/\____/     /_____/  /_/  |_/____/____/\___/_/ /_/ /_/_.___/_/\___/_/
  #
  #
  # F 1 0 0 - L * A S S E M B L E R (c) 2016 Revaldinho & BigEd
  # -------------------------------------------------------------------------------------------
  #
  # LINE:       ADDR: CODE     SOURCE
  # ----:-----------:--------------------------------------------------------------------------
       1:                       .EQU  _TMP 0x3E8
       2:                       .EQU  ping 0x3EA
       3:      001A: 8001       LDA 0x0001
       4:      001B: 4800 03EA  STO .ping
       5:                       .EQU  pong 0x3EC
       6:      001D: 8001       LDA 0x0001
       7:      001E: 4800 03EC  STO .pong
       8:                       .EQU  new_pong 0x3EE
       9:                       L1:
      10:      0020: 8800 03EA  LDA .ping
      11:      0022: 9800 03EC  ADD .pong
      12:      0024: 4800 03EE  STO .new_pong
      13:      0026: 8800 03EC  LDA .pong
      14:      0028: 4800 03EA  STO .ping
      15:      002A: 8800 03EE  LDA .new_pong
      16:      002C: 4800 03EC  STO .pong
      17:      002E: 8800 03EA  LDA .ping
      18:      0030: D000 0262  NEQ ,610
      19:      0032: 0181 0020  JBC 0x01 CR L1
  # -------------------------------------------------------------------------------------------
  # 0 Errors
  # 0 Warnings
  # -------------------------------------------------------------------------------------------
  # SymbolTable
  # --------------------------------: -------------------------------- : ----------------------
  # Symbol                          : Definition                       : Value Hex (Decimal)
  # --------------------------------: -------------------------------- : ----------------------
  # L1                              : 32                               : 0020 (32)
  # NEW_PONG                        : 0X3EE                            : 03EE (1006)
  # PING                            : 0X3EA                            : 03EA (1002)
  # PONG                            : 0X3EC                            : 03EC (1004)
  # _TMP                            : 0X3E8                            : 03E8 (1000)
  # --------------------------------: -------------------------------- : ----------------------
  # Run time = 0.004 s
  # -------------------------------------------------------------------------------------------
