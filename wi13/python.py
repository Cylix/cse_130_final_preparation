# 3
def transpose(m):
    height = len(m)
    width = len(m[0])
    return [ [ m[j][i] for j in range(0, height) ] for i in range(0, width) ]

# 4a
def access(g, x, y):
    try: return g[y][x]
    except: return 0

def count_live_neighbours(g, x, y):
    live = 0
    for x_delta in [ -1 , 0, 1 ]:
        for y_delta in [ -1, 0, 1 ]:
            if x_delta != 0 and y_delta != 0 and access(g, y + y_delta, x + x_delta) == 1:
                live += 1
    return live

# 4b
def new_val(g, x, y):
    live = count_live_neighbours(g, x, y)
    is_alive = access(g, x, y)

    if is_alive and live < 2: return 0
    if is_alive and live > 3: return 0
    if ! is_alive and live == 3: return 1
    return is_alive

# 4c
def step(g):
    height = len(g)
    wdith = len(g[0])
    return [ [ new_val(g, x, y) for x in width ] for y in height ]

# 5a
def lift_1(f):
    def decorated(x):
        return [ f(val) for val in x ]
    return decorated

def lift_2(f):
    def decorated(x, y):
        return [ f(val1, val2) for (val1,val2) in zip(x,y) ]
    return decorated

# 5c
# The given function just does a 2D matrix sum

# 5d
def lift(f):
    def decorated(*args):
        return [ f(*val) for val in zip(*args) ]
    return decorated
