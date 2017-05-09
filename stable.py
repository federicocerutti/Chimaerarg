#! /usr/bin/env python

import string
import subprocess
import sys
import re

framework=sys.argv[1]

command="./ex_nof.sh "+framework
process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=None, shell=True)
uscita = process.communicate()
##	check il tempo, poi check valore uscita. "NO" se niente
in_file = open("tempo","r")
in_line=in_file.readline()
in_file.close()

tempo=float(in_line)

if tempo < 295.0:
	if uscita[0].rstrip() == "[]":
		print "NO"
	else:
		print uscita[0]
else:	
	command="./ex_lab.sh "+framework
	process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=None, shell=True)
	uscita = process.communicate()
##	check il tempo, poi check valore uscita. "NO" se niente
	if len(uscita[0]) > 1:
		print uscita[0]


