#!/bin/bash

ssh "-L $(echo $* | sed "s/ / -L /g")" login1
