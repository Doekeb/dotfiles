import datetime as dt
import json
import typing

import pandas as doody
from numpy import array
from pandas import DataFrame

import lib

array([1, 2, 3])
lib.libfunc(2, 3, 5)

thingy: list[int] = []

doody
dood = 2

dood = dood + 7


do


def my_sweet_ass_function():
    """Look at how long and fantastically cool this docstring is. It has so many words
    in it! Some of the words are really long like hunkadorydoodlydimpkus. Others are
    shorter like a. Well, that's all! Well well well. Here's another damn line. I wasn't
    expected to write a whole other line like that!
    """


# Here is a comment version of the thing that I was doing above. What's going to happen
# when
class dingus:
    def do_something(this):
        return this


def my_function():
    pass


class Dingus:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def do_something(this):
        return this.x + this.y

    @property
    def my_excellent_property(self):
        return self.x


print(Dingus)
print(Dingus(2, 3).my_excellent_property)


def bingus():
    pass


print(dingus.do_something)


@typing.overload
def ThingyDing(x: int) -> int:
    """Do a thing."""


@typing.overload
def ThingyDing(x: str) -> str:
    """Do somethin different"""


# def ThingyDing(x: str | int) -> str | int:
#     return x + x


ThingyDing


def my_function(  # An updated comment which is much much better.
    bazzy: int, y: str, dood: float  # another comment?
):
    my_dumb_var = 2
    print(dood)
    dood = dood + 7
    if bazzy > 10:
        print("yes")
    else:
        print("no")
    print(my_dumb_var)
    bazzy += 2
    return bazzy + 7 - 2


for i in itertools.chain([1, 2, 3], [4, 5, 6]):
    print(i)

print(thingy)

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
