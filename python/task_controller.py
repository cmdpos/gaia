import sys
import subprocess
import threading
import Queue
import logging
import json
import os
import time

import codecs
from time import sleep
from copy import deepcopy
from itertools import permutations

if __name__ == '__main__':


    L = ['holiday', 'relief', 'seat', 'stomach', 'limb', 'sing', 'learn', 'culture', 'push', ' deer', 'brick', 'wrong']


    def permutations(L):
        if len(L) == 1:
            yield L
        else:
            a = [L.pop(0)]
            for p in permutations(L):
                for i in range(len(p) + 1):
                    yield p[:i] + a + p[i:]


    # Print the obtained permutations
    for l in permutations(L):
        print(l)

    pass

