# 2a
def square_img(img):
    return [ [ x*x for x in l ] for l in img ]

# 2b
def crop_img(img,x1,y1,x2,y2):
    return [ [ img[i][j] for j in range(x1,x2) ] for i in range(y1,y2) ]

# 2c
def zip(l1,l2):
    return [ (l1[i], l2[i]) for i in range(0, min(len(l1), len(l2))) ]

# 2d
def add_imgs(img1, img2):
    return [ [ x1+x2 for (x1,x2) in zip(l1,l2) ] for (l1,l2) in zip(img1, img2) ]

# 3
def derivative(delta):
    def decorator(f):
        def decorated(x):
            return round((f(x+delta) - f(x)) / delta, 2)
        return decorated
    return decorator

# 3 Bonus
def derivative(delta):
    class decorator:
        def __init__(self,f):
            self.f = f
        def __call__(self,x):
            return round((self.f(x+delta) - self.f(x)) / delta, 2)
    return decorator
