# 5a
def rev(l):
    return [ l[len(l) - 1 - i] for i in range(0, len(l)) ]

# 5b
def rev(l):
    def fold_fn(acc, elm): return [elm] + acc
    return reduce(fold_fn, l, [])

# 6
def print_some(l):
    def decorator(f):
        def decorated(*args):
            print_ret = False
            for idx in l:
                if idx == -1: print_ret = True
                elif idx >= 0 and idx < len(args): print "Arg " + str(idx) + ": " + str(args[idx])
            ret = f(*args)
            if print_ret: print "Return: " + str(ret)
            return ret
        return decorated
    return decorator

# 7a
def apply_to_tree(s, t):
    if not t.is_var():
        return node(t.name, [apply_to_tree(s, c) for c in t.children])
    elif t.name in s:
        return apply_to_tree(s, s[t.name])
    else:
        return t

# 7b
# Not sure of the result
def unify(a,b,s={}):
    a = apply_to_tree(s, a)
    b = apply_to_tree(s, b)
    result = s.copy()
    if a.is_var() and b.is_var(): result = unify(s.get(a.name, a), s.get(b.name, b), s)
    elif a.is_var() and not b.is_var():
        if a.name in result: result = unify(result[a.name], b, s)
        else: result = b
    elif not a.is_var() and b.is_var():
        return unify(b, a, s)
    elif not a.is_var() and not b.is_var():
        if a.name != b.name: return False
        if len(a.children) != len(b.children): return False
        for (a_child, b_child) in zip(a.children, b.children):
            result = unify(a_child, b_child, result)
    return result
