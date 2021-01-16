#!/usr/bin/env python3

import sys

incomment = False

for line in sys.stdin: 
    realline = line.strip()
    
    if len(realline) >= 2 and realline[0] == '/' and realline[1] == '*':
    	incomment = True
    
    if incomment:
    	nw = 0
    	while line[nw] == ' ':
    		nw += 1
    	print(line[:nw] + "// " + line[nw:], end="")
    else:
    	print(line, end="")
    	
    if len(realline) >= 2 and realline[-1] == '/' and realline[-2] == '*':
    	incomment = False
    	