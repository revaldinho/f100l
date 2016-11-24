from .F100_Opcode import *

class OpcodeF15(F100_Opcode) :
    '''
    JMP
    ===
    
    Unconditional jump to the location provided by the operand
    
    Function
    --------
    
    ::
       
       JMP N      PC <- (N)
       JMP ,D     PC <- PC + 1
       JMP /P     PC <- (P)
       JMP /P+    P <- P+1 ; PC <- (P) 
       JMP /P-    PC <- (P) ; P <- P - 1
       JMP .W     PC <- W

    Note that the JMP,D form causes no branching and instruction proceeds to execute the next word (the 
    'D' effectively) as the next instruction. This instruction is effectively a NOP.
    
    Instruction Encoding
    --------------------
    
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |              Opcode Word                |     Operand Word    | Function | Cycle count          |
     +-------+----+----+-----+-----------------+                     |          |                      |
     |       |    | N                          |                     |          |                      |
     |       |    +----+-----+-----------------+                     |          |                      |
     |  F    |  I |    | R   | P               |                     |          |                      |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1111|1'b0|     11'b<non-zero addr>    |           none      | JMP N    | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1111|1'b0|     11'b000000000000       |           none      | JMP ,D   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1111|1'b1|1'bx|2'bx0|8'b<non-zero ptr>|           none      | JMP /P   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
     |4'b1111|1'b1|1'bx|2'b01|8'b<non-zero ptr>|           none      | JMP /P+  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1111|1'b1|1'bx|2'b11|8'b<non-zero ptr>|           none      | JMP /P-  | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+ 
     |4'b1111|1'b1|1'bx|2'bxx|8'b00000000      |1'bx|   15b'<addr>   | JMP .W   | TBC                  |
     +-------+----+----+-----+-----------------+----+----------------+----------+----------------------+
    
      
     Condition Register
     ------------------
    
     +---+---+---+---+---+---+---+
     | F | M | C | S | V | Z | I |
     +---+---+---+---+---+---+---+
     |\- |\- | \-| \-| \-| \-|\- | 
     +---+---+---+---+---+---+---+ 
    
     * The condition register is not affected by this instruction
    '''
    

    def __init__ (self, CPU=None):
        super().__init__( opcode_fn = { "JMP":15}, CPU=CPU) 
        self.F = 15


    
    def assemble(self, opcode_token, operands, symbol_table, suppress_errors=False):
        (addr_mode, first_operand ) = self.get_address_mode(operands[0])
        (code, warnings) = super().assemble(opcode_token, operands, symbol_table, suppress_errors)

        if addr_mode == ADM_IMMEDIATE:
            # In immediate mode the operand is discarded and execution will pass to the next instruction word
            code = code[:-1]

        return (code, warnings)

    def exec(self):
        cycle_count = 0

        IR = self.CPU.IR
        CR = self.CPU.CR    
        
        operand = None
        if ( IR.F != self.F):
            raise UserWarning("Cannot execute opcode %04X using opcode class %s" % (opcode, self.__name__) )
        elif IR.I==0 and IR.N==0:
            # PC has already been incremented
            pass
        elif IR.I==0:
            self.CPU.PC = self.memory_read(IR.N) & 0x7FFF         
        elif IR.I==1 and IR.P==0:
            self.CPU.PC = self.CPU.memory_fetch() & 0x7FFF
        elif IR.I==1:
            if IR.R==1: 
                IR.P += 1
            self.CPU.PC = self.CPU.memory_read(IR.P) & 0x7FFF          
            if IR.R==3:
                IR.P -= 1
                
        return cycle_count
