#!/usr/bin/python3

import sys


def colStr(data, col):
    return ''.join([str(c) for c in data[col]])

def rowStr(data, row):
    return ''.join([str(l[row]) for l in data])



data = [l.rstrip('\n') for l in sys.stdin.readlines()]
data = [list(l) for l in data]
data = [[int(c) for c in l if c.isnumeric()] for l in data]


print(data)
print(rowStr(data, 0))
print(colStr(data, 0))

def compose(f, g): return lambda x : f(g(x))






# for i in sys.stdin:
#     print(i)
