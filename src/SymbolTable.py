
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
        if isinstance(node, ast.Num): # <number>
            return node.n
        elif isinstance(node, ast.BinOp): # <left> <operator> <right>
            return operators[type(node.op)](self.eval_(node.left), self.eval_(node.right))
        elif isinstance(node, ast.UnaryOp): # <operator> <operand> e.g., -1
            return operators[type(node.op)](self.eval_(node.operand))
        elif isinstance(node, ast.Name): # Variable name
            if node.id in self:
                return self.eval_expr(self[node.id])
            else:
                raise ValueError("SymbolTable Error: Undefined value for label %s " % node.id)
        else:
            raise TypeError(node)



if __name__ == "__main__":

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
                print e
            except RuntimeError:
                print ("SymbolTable Error: Recursive definition of label %s" % L)
                del ep[L]          # remove the bad variable for second pass
        ep["undef_pass1"] = "100"  # update this variable for second pass

