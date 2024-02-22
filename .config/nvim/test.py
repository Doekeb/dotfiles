import datetime as dt
import json

import numpy as np
import pandas as pd

import lib

lib.libfunc(2, 3, 5)
thingy=2

def my_function(  # An updated comment which is much much better.
    thingy: int, y: str  # another comment?
):
    my_dumb_var = 2
    if thingy > 10:
        print("yes")
    else:
        print("no")
    print(my_dumb_var)
    return thingy


print(my_fun_var)

print(my_function(2, "hi"))

df = pd.DataFrame([1, 2, 3])

df


def f(x: str) -> str:
    def g(z: str) -> str:
        return z + 7

    hoopity = 7

    print(dt.datetime.utcnow())
    print(x)
    for i in range(10):
        hoopity += i
    return 2


hoopity

y = 88

print(y + 2)
my_cool_variable = 2

print(my_cool_variable)

g(5)

f(3)

df = pd.DataFrame([1, 2, 3])
df.plot()
df
