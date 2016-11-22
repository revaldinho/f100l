## ============================================================================
## F100Asm.py - Assembler for the Ferranti F100-L CPU
##
## COPYRIGHT 2016 Richard Evans, Ed Spittles
##
## This file is part of f100l - an set of utilities for programming and 
## emulation of the Ferranti F100-L CPU and peripheral components.
##
## f100l is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## f100l is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## See  <http://www.gnu.org/licenses/> for a copy of the GNU Lesser General 
## Public License
##
## ============================================================================
'''
  USAGE: 

    F100Asm is an assembler for the Ferranti F100-L CPU. 

  REQUIRED SWITCHES 

    -f  --filename  <filename>       specify the assembler source file

  OPTIONAL SWITCHES

    -h  --help                       print this help message

  EXAMPLES

    python F100Asm -f testfile.asm 


Using the Assembler
===================

The standard command line is

``F100ASM  -f|--filename <assembler_file.txt> -h|--help``

All output is sent only to a listing file currently.

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


**``.ORG``** sets the current instruction address to the value supplied before assembling the next instruction. e.g. ::

.ORG 0x0800 ; Instruction execution starts at 0x800 following a reset when AdSel is left floating or tied high

**``.EQU``** is used to assign expressions or values to variable names. e.g. ::

.EQU  PTR_START 0x100
.EQU  STK_PTR1  PTR_START+1
.EQU  MEMTOP    0x7FFF
.EQU  STK_SIZE  0x0400
.EQU  STK_BOT   MEMTOP - STK_SIZE

F100ASM uses the Python ASR parser class to allow parsing of any valid Python expression. All expressions must evaulate to an integer number by the end of the first pass through the assembler. Expressions or symbols may be used anywhere a numerical value is allowed. 

Like labels all variable names must start with an alphabetic character or an underscore but subsequent characters may be alphanumeric. All variable names are case insensitive.

Note that the two symbols A and C are reserved words and may not be used as variable names.

Labels are treated like any other variable as far as expression parsing is concerned. 

**``.DATA``** and **``.WORD``** are synonyms of each other. These can be followed by a list of comma separated numeric values or expressions on the same line. e.g.::

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
      19:      0032: 0181 0020  JBC 0x01 C L1
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


'''

from SymbolTable import SymbolTable
from F100_Opcode import *
import string
import re
import getopt
import time
import sys


header_text = '''
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
# ----:-----------:--------------------------------------------------------------------------'''
line_sep = '''# -------------------------------------------------------------------------------------------'''
directive_re  = re.compile(".(:?WORD|DATA|EQU|ORG)")


def usage():
    print( __doc__ )
    sys.exit(0)

class F100Asm():

    def __init__(self):
        self.st = SymbolTable()
        self.pc = 0
        self.opcodes = [ o() for o in (OpcodeClass0a, OpcodeClass0b, OpcodeClass013, OpcodeClass2, 
                                       OpcodeClass4, OpcodeClass7, OpcodeF11, OpcodeF12, OpcodeF13 ) ]

    def is_valid_opcode(self, opcode_str):
        for o in self.opcodes:
            if o.opcode_regexp.match(opcode_str):
                return o.__class__()
        return None

    def line_assemble(self, opcode, operands, symbol_table, suppress_errors=False):
        assembled_words = []
        warnings = []
        op =  self.is_valid_opcode(opcode)
        if op == None:
            raise UserWarning("Unrecognized opcode %s" % opcode )  
        (assembled_words, warnings) = op.assemble(opcode, operands, symbol_table, suppress_errors)            
        return (assembled_words, warnings)

    def twopass_assemble(self, text):
        for i in range(0,2):
            self.assemble(text, i)

    def assemble( self, text, pass_number ):
        ''' Build the text into lines of tokens and expressions'''

        error_count = 0
        warning_count = 0
        lineno = 1

        if pass_number > 0:
            print(header_text)

        for textline in text:      

            warnings = []            
            line_pc = self.pc
            line_words = []

            line = textline.strip()
            ## Strip out comments from the end of the line
            comment_start = line.find(";")
            if comment_start > -1 :
                line = line[:comment_start].strip()
            ## Strip out label from the start of the line
            if re.match("([a-zA-Z_][a-zA-Z0-9_]*:)", line):                
                line_label = str.upper(re.match("([a-zA-Z_][a-zA-Z0-9_]*):", line).group(1))
                self.st[line_label] = str(self.pc)
                line = line[len(line_label)+1:].strip()
            ## Left now with a line which is either blank, directive or opcode
            if line != "":
                fields = [str.upper(f) for f in line.split() ]
                t = fields[0]
                if directive_re.match(t):
                    try:
                        (self.pc, line_words) = self.process_directive(t, fields[1:])
                    except ValueError as v:
                        if pass_number < 1:
                            pass
                        else:
                            error_count += 1
                            raise v
                else:
                    try:
                        (line_words, warnings) = self.line_assemble(t, fields[1:], self.st, suppress_errors = True if pass_number < 1 else False)            
                    except ValueError as v:
                        if pass_number >0:
                            # Ignore undefined symbols on first pass
                            error_count+= 1
                            print(v)                        
                    except UserWarning as e:                            
                        error_count += 1
                        if pass_number > 0:
                            print("Error on line %d" % lineno)
                            print(e)
                        
                    if len(warnings) > 0 :
                        for w in warnings:
                            if pass_number > 0 :
                                print(w)
                    warning_count += len(warnings)
                    self.pc += len(line_words)

            if pass_number > 0 :   
                ## Simple listing code
                fields = []
                fields.append(" %5d:" % lineno)                                
                if len(line_words) > 0 :
                    if len(line_words)>1:
                        fields.append("     %04X: %04X %04X "% (line_pc, line_words[0], line_words[1]))
                    else:
                        fields.append("     %04X: %04X      "% (line_pc, line_words[0]))
                else:
                    fields.append(' '*21)
                fields.append(textline.strip())
                print (' '.join(fields))
                for d in line_words[2:]:
                    print ("                   %04X " % d),

            lineno +=1
        
        if pass_number > 0:
            print (line_sep)
            print ("# %d Error%s" % ( error_count, '' if error_count == 1 else 's'))
            print ("# %d Warning%s" % ( warning_count, '' if warning_count == 1 else 's'))
            print (line_sep)
            print("# SymbolTable")         
            for s in self.st.tostring().split('\n'):
                print( "# %s" % s )

    def process_directive(self, directive, operands ) :
        new_pc = self.pc
        words = []
        if directive == ".EQU":
            self.st[operands[0]] = ''.join(operands[1:])            
        elif directive == ".ORG":        
            new_pc = self.st.eval_expr(operands[0])
        elif directive == ".DATA" or directive == ".WORD":
            ## Need to resplit by commas rather than spaces
            data_words = (''.join(operands).split(','))
            new_pc += len(data_words)
            
            for d in data_words:
                ## Cant eval all expressions on first pass so return dummy data
                try:
                    words.append(self.st.eval_expr(d))
                except ValueError as v:
                    words.append(0xFF)   

        return(new_pc, words)                
                




if __name__ == "__main__":
    """
    Command line option parsing.
    """
    filename = ""
    try:
        opts, args = getopt.getopt( sys.argv[1:], "f:h", ["filename=","help"])
    except getopt.GetoptError as  err:
        print(err)
        usage()
        
    for opt, arg in opts:
        if opt in ( "-f", "--filename" ) :
            filename = arg
        elif opt in ("-h", "--help" ) :
            usage()

    if filename != "":
        asm = F100Asm()
        with open(filename) as f:
            text = f.readlines()
        f.close()
        s = time.time()
        asm.twopass_assemble(text)
        e = time.time()
        print ("# Run time = %1.3f s" % (e-s))
        print (line_sep)
    else:
        usage()

    sys.exit(0)
