# 3a
def lookup(d, k):
    return [val for (key, val) in d if key == k]

# 3b
def cond(b, t, f):
    if b: return t
    else: return f

def update(d, k, v):
    return [ cond(key == k, (key, v), (key, val)) for (key, val) in d ]

# 3c
def delete(d, k):
    return [(key, val) for (key, val) in d if key != k]

# 3d
def add(d, k, v):
    return d + [(k, v)]

# 3e
def update(d, k, v):
    res = []
    for i in range(0, len(d)):
        res += [(k, v) if d[i][0] == k else d[i]]
    return res

# 4
def in_range(i, r):
    def decorator(f):
        def decorated(*args):
            if i == -1:
                ret = f(*args)
                if ret > r[1]: raise Exception("Return value " + str(ret) + " too big")
                elif ret < r[0]: raise Exception("Return value " + str(ret) + " too small")
                else: return ret
            else:
                if args[i] > r[1]: raise Exception(str(i) + "th arg " + str(args[i]) + " too big")
                elif args[i] < r[0]: raise Exception(str(i) + "th arg " + str(args[i]) + " too small")
                else: return f(*args)
        return decorated
    return decorator
