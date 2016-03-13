# 3
def print_first_k_args(k):
    def decorator(f):
        def decorated(*args):
            for i in range(0, min(k, len(args))):
                print "Arg " + str(i + 1) + ": " + str(args[i])
            ret = f(*args)
            print "Return: " + str(ret)
            return ret
        return decorated
    return decorator

# 4a
def create_image(w,h,c):
    return [ [ c for j in range(0,w) ] for i in range(0,h) ]

# 4b
def well_formed(img):
    if len(img) == 0: return True

    size = len(img[0])
    for l in img:
        if len(l) != size: return False
        for pixel in l:
            if pixel < 0 or pixel > 255: return False

    return True

# 4c
def fill_rect(img,x0,y0,x1,y1,c):
    for y in range(y0,y1):
        for x in range(x0,x1):
            try:
                img[y][x] = c
            except: pass

# 4d
def fill_region(img, old_color, new_color, x, y):
    img[y][x] = new_color
    for (x1,y1) in [(x+1,y), (x,y+1), (x-1,y), (x,y-1)]:
        try:
            if img[y1][x1] == old_color: fill_region(img, old_color, new_color, x1, y1)
        except:
            pass
