#!/usr/bin/env python3
# NONSTANDARD! Ggf. mit pip3 in venv installieren
#
# python3 -m venv .
# . bin/activate
# pip3 install requests
# python3 restclient-calc.py

import requests   
import sys, random, time
from multiprocessing import Process

if len(sys.argv) != 2:
    print("FEHLER - bitte Anzahl Worker angeben")
    sys.exit(1)


URL = "http://localhost:5000/calc?a={a}&b={b}"
NWORKERS = int(sys.argv[1])
A,B = 2, 0

class Worker(Process):
    def run(self):
        print("Worker started",self)
        t0 = time.time()
        a = A
        b = B
        req = requests.get(URL.format(a=a,b=b))
        print("Worker finished",self)


workers = [ Worker() for i in range(NWORKERS) ]
anfang = time.time()
[ w.start() for w in workers ]

print("Waiting for all processes to complete...")
for w in workers:
    w.join()

ende = time.time()
delta = ende - anfang

print("Laufzeit mit {NWORKERS} Workern und Params a={A}, b={B}: {delta}s".format(**vars()))

