
import os
import numpy as np
from sympy import *
x, y, z, t = symbols('x y z t')
k, m, n = symbols('k m n', integer=True)
f, g, h = symbols('f g h', cls=Function)
init_printing()

def import_all(modules):
    """ Usage: import_all("os sys") """
    for m in modules.split():
        ip.ex("from %s import *" % m)

import stackprinter
stackprinter.set_excepthook(style='color')

import pyconrad.autoinit
from pyconrad import imshow

