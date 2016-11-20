'''
SymbolTable

SymbolTable is a class for holding symbols and expressions, together with the
means of evaluating those expressions or any other expressions which are defined
using the symbols. It is intended for use in an assembler.

SymbolTable extends the built-in dictionary type, and so inherits that type's 
ability to store keys (variable or label names) and associate them with a string
holding either a numeric literal or an expression. It extends the base type 
functionality to provide a single method 'eval_expr' which uses the Python 
Abstract Syntax Tree class to parse and evaluate any arbitary expression 
which uses these variables.

Example

    s = SymbolTable( {"A":"1", "B":"2", "C":"A+B" } )
    
    s.eval_expr('A') will return the integer 1
    s.eval_expr('B') will return the integer 2
    s.eval_expr('C') will return the integer 3
    s.eval_expr('A+2*B-C') will return the integer 2
'''

import ast
import operator as op

operators = {ast.Add: op.add, ast.BitAnd: op.__and__, ast.BitOr: op.__or__,
             ast.BitXor: op.xor, ast.Div: op.truediv, ast.LShift: op.__lshift__,
             ast.Mult: op.mul, ast.Pow: op.pow, ast.RShift: op.__rshift__,
             ast.Sub: op.sub, ast.USub: op.neg }

class SymbolTable (dict) :
    def __init__ (self, labels=dict()):
        self.update(labels)

    def eval_expr(self, expr):
        return self.eval_(ast.parse(expr, mode='eval').body)

    def eval_(self, node):
        if isinstance(node, ast.Num):
            return node.n
        elif isinstance(node, ast.BinOp): 
            return operators[type(node.op)](self.eval_(node.left), self.eval_(node.right))
        elif isinstance(node, ast.UnaryOp): 
            return operators[type(node.op)](self.eval_(node.operand))
        elif isinstance(node, ast.Name): # Variable name
            if node.id in self:
                return self.eval_expr(self[node.id])
            else:
                raise ValueError("SymbolTable Error: Undefined value for label %s " % node.id)
        else:
            raise TypeError(node)

    def tostring( self ) :
        marker = "%-32s: %-32s : %s" % ("-"*32,"-"*32,"-"*22)
        lines = [marker, "%-32s: %-32s : %s" % ("Symbol","Definition","Value Hex (Decimal)"), marker]        
        for s in sorted(self):
            lines.append("%-32s: %-32s : %04X (%d)" % (s, self[s], self.eval_expr(s), self.eval_expr(s) ))
        lines.append(marker)
        return('\n'.join(lines))





if __name__ == "__main__":
    #
    # Some simple test code for the class if run as the main program
    # 

    labels = {"F1":"1",
              "F2":"F1 + F1",
              "F3":"(F2>>1) + (F4>> F1)",
              "F4":"F2 * 2",
              "F5":"F4 + F2 - F1",
              "F6":"(0xFFFF & 0x1000) << 4",
              "undef_pass1":"some_rubbish_which_isnt_defined",
              "recursive":"recursive >> 1",
              "syntaxE":"oh I do like to be beside the seaside" 
              }

    ep = SymbolTable(labels)    

    for iteration in range (0, 2):
        print ("\nIteration %d" % iteration)
        print ("----------------------------------------------------------------")
        print ("%-12s  %-24s  %-12s  %-8s" % ("Label","Definition", "Value (Dec)", "Value (Hex)"))
        for L in sorted(ep):
            try:
                print ("%-12s  %-24s  %-12d  0x%08x" % ( L, ep[L], ep.eval_expr(L), ep.eval_expr(L)))
            except ValueError as e:
                print (e)
            except SyntaxError as e:
                print ("SymbolTable Error: Syntax error in definition of label %s" % L)
                del ep[L]          # remove the bad variable for second pass
            except TypeError as e:
                print (e)
            except RuntimeError:
                print ("SymbolTable Error: Recursive definition of label %s" % L)
                del ep[L]          # remove the bad variable for second pass
        ep["undef_pass1"] = "100"  # update this variable for second pass

