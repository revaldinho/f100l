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

REQUIRED SWITCHES ::

  -f  --filename  <filename>       specify the assembler source file

OPTIONAL SWITCHES ::

  -h  --help                       print this help message

EXAMPLES ::

  python F100Asm -f testfile.asm 


BUGS ::

All output is sent only to a listing file currently.

'''

from SymbolTable import SymbolTable
from F100_Opcodes.F100_Opcode import *
from F100_Opcodes.OpcodeF15 import *
from F100_Opcodes.OpcodeF13 import *
from F100_Opcodes.OpcodeF12 import *
from F100_Opcodes.OpcodeF11 import *
from F100_Opcodes.OpcodeF10 import *
from F100_Opcodes.OpcodeF9 import *
from F100_Opcodes.OpcodeF8 import *
from F100_Opcodes.OpcodeF7 import *
from F100_Opcodes.OpcodeF6 import *
from F100_Opcodes.OpcodeF5 import *
from F100_Opcodes.OpcodeF4 import *
from F100_Opcodes.OpcodeF3 import *
from F100_Opcodes.OpcodeF2 import *
from F100_Opcodes.OpcodeF1 import *
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
        self.opcodes = [ o() for o in (OpcodeClass0a, OpcodeClass0b, OpcodeClass013,
                                       OpcodeF1, OpcodeF2, OpcodeF3, FOpcodeF4, OpcodeF5,
                                       OpcodeF6, OpcodeF7,  OpcodeF8, OpcodeF9,
                                       OpcodeF10, OpcodeF11, OpcodeF12, OpcodeF13, OpcodeF15 ) ]

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
