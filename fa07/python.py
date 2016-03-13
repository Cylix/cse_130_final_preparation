# 5a
# ans => (["a", "b", "c"], ["r", 2, 3])

# 5b
# ans => (8990, -10)

# 5c
# ans => (120, 0)

# 6a
# Conflict when multiple parents have same method
# Diamond-shape problem

# 6b
# Because not method is defined (there is only their prototype)

# 6c
# Anybody can modify the variable ctr without calling tick

# 6d
def tick():
    tick.ctr += 1
    return tick.ctr

tick.ctr = 0

# 7a
def valid(es,c):
    for (lhs, rhs) in es:
        if c[lhs] == c[rhs]: return False
    return True

# 7b
# fuck up, this exercise is just so boooring
# 7c
# same

#  8a
def tracked(C):
    class CC(C):
        insts = []
        def __init__(self, *args):
            C.__init__(self, *args)
            CC.insts += [self]
            self.inst_id = len(CC.insts) - 1
        def instId(self): return self.inst_id
        def getInst(self, j): return CC.insts[j]
    return CC

# 8b
def automap(f):
    def decorated(xs):
        if type(xs) != list: return f(xs)
        else: return [ f(x) for x in xs ]
    return decorated

# 8c
def automap(f):
    def decorated(xs):
        if hasattr(xs, "__iter__"): return [ f(x) for x in xs ]
        else: return f(xs)
    return decorated
