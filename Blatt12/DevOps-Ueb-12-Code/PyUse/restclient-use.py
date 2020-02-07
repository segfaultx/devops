#!/usr/bin/env python3

import requests   # NONSTANDARD! Ggf. mit pip3 in venv installieren
import sys, time
from multiprocessing import Process

if len(sys.argv) != 2:
    print("FEHLER - bitte Anzahl Worker angeben")
    sys.exit(1)


URL = "http://localhost:6000/dabbel?x={x}"
NWORKERS = int(sys.argv[1])
X = NWORKERS

class Worker(Process):
    def run(self):
        print("Worker started",self)
        t0 = time.time()
        req = requests.get(URL.format(x=X))
        print("Worker finished",self,"-> [[%s]]"%req.text)


workers = [ Worker() for i in range(NWORKERS) ]
anfang = time.time()
[ w.start() for w in workers ]

print("Waiting for all processes to complete...")
for w in workers:
    w.join()

ende = time.time()
delta = ende - anfang

print("Laufzeit mit {NWORKERS} Workern und Params x={X}: {delta}s".format(**vars()))

