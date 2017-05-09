#! /usr/bin/env python

import string
import subprocess
import sys
import re

framework=sys.argv[1]

command="./ex_ceg.sh "+framework
process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=None, shell=True)
uscita = process.communicate()


##CHECK CHE USCITA INCLUDA QUALCOSA

if uscita[0].find("]") != -1:
	print uscita[0]
else:	
	command="./ex_gris.sh "+framework
	process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=None, shell=True)
	uscita = process.communicate()
	if uscita[0].find(']') != -1:
		print uscita[0]
