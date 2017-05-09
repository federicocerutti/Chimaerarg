#!/bin/bash
# (c)2014 Federico Cerutti <federico.cerutti@acm.org> --- MIT LICENCE
# adapted 2016 by Thomas Linsbichler <linsbich@dbai.tuwien.ac.at> --- MIT LICENSE
# Generic script interface for ICCMA 2017
# Please feel free to customize it for your own solver


# function for echoing on standard error
echoerr()
{
	# to remove standard error echoing, please comment the following line
	echo "$@" 1>&2; 
}

################################################################
# C O N F I G U R A T I O N
# 
# this script must be customized by defining:
# 1) procedure for printing author and version information of the solver
#	(function "information")
# 2) suitable procedures for invoking your solver (function "solver");
# 3) suitable procedures for parsing your solver's output 
#	(function "parse_output");
# 4) list of supported format (array "formats");
# 5) list of supported problems (array "problems").

# output information
function information
{
	# to be adapted
	echo "MySolver0.8.15"
	echo "Mauro Vallati, University of Huddersield"
	echo "Federico Cerutti, Cardiff University"
	echo "Massimiliano Giacomin, Universita degli studi di Brescia"
}

# how to invoke your solver: this function must be customized
function solver
{
	fileinput=$1	# input file with correct path

	format=$2	# format of the input file (see below)

	task=$3    	# task to solve (see below)

	additional=$4	# additional information, i.e. name of an argument


	# dummy output
	echoerr "input file: $fileinput"
	echoerr "format: $format"
	echoerr "task: $task"
	echoerr "additional: $additional"

	# example for ArgSemSATv0.2
	if [ "$format" = "apx" -a "$task" = "EE-PR" ];
	then
		python ./preferred.py $fileinput
	elif [ "$format" = "apx" -a "$task" = "EE-ST" ];
	then
		python ./stable.py $fileinput
	
	else
		echoerr "unsupported format or task"
		exit 1
	fi
}


# how to parse the output of your solver in order to be compliant with ICCMA 2017:
# this function must be customized
# solutions must be of the following form:
#	[arg1,arg2,...,argN]                     for single extension (SE)
#	[[arg1,arg2,...,argN],[...],...]         for extension(s) enumeration (EE)
#	YES/NO                                   for decision problems (DC and DS)
#       [[arg1,...argN]],[[...],...],[[...],...] for Dung's triatholon (D3)
function parse_output
{
	task=$1
	output="$2"

	echo $2
	#echoerr "original output: $output"

	#example of parsing EE-tasks for MySolver0.8.15, which returns "{arg1,arg2,...}\n{...}\n..."
	#if [[ "$task" == "EE-"* ]];
	#then
	#	echo -n "["
	#	echo $output | sed 's/{/[/g' | sed 's/}/]/g' | tr -d '\n' \
	#	       | sed 's/\]\[/\],\[/g' | sed 's/\] \[/\],\[/g'
	#	echo "]"
	#elif [ "$task" = "D3" ];
	#then
	#	echo $output
	#
	# other tasks
	#
	#else
	#	echoerr "unsupported format or task"
	#	exit 1
	#fi
}

# accepted formats: please comment those unsupported
formats[1]="apx" # "aspartix" format
formats[2]="tgf" # trivial graph format

# task that are supported: please comment those unsupported

#+------------------------------------------------------------------------+
#|         I C C M A   2 0 1 7   L I S T   O F   P R O B L E M S          |
#|                                                                        |
#tasks[1]="DC-CO" 	# Decide credulously according to Complete semantics
#tasks[2]="DS-CO" 	# Decide skeptically according to Complete semantics
#tasks[3]="SE-CO" 	# Enumerate some extension according to Complete semantics
#tasks[4]="EE-CO" 	# Enumerate all the extensions according to Complete semantics
#tasks[5]="DC-PR" 	# Decide credulously according to Preferred semantics
#tasks[6]="DS-PR" 	# Decide skeptically according to Preferred semantics
#tasks[7]="SE-PR" 	# Enumerate some extension according to Preferred semantics
tasks[8]="EE-PR" 	# Enumerate all the extensions according to Preferred semantics
#tasks[9]="DC-ST" 	# Decide credulously according to Stable semantics
#tasks[10]="DS-ST" 	# Decide skeptically according to Stable semantics
#tasks[11]="SE-ST" 	# Enumerate some extension according to Stable semantics
tasks[12]="EE-ST" 	# Enumerate all the extensions according to Stable semantics
#tasks[13]="DC-SST" 	# Decide credulously according to Semi-stable semantics
#tasks[14]="DS-SST" 	# Decide skeptically according to Semi-stable semantics
#tasks[15]="SE-SST" 	# Enumerate some extension according to Semi-stable semantics
#tasks[16]="EE-SST" 	# Enumerate all the extensions according to Semi-stable semantics
#tasks[17]="DC-STG" 	# Decide credulously according to Stage semantics
#tasks[18]="DS-STG" 	# Decide skeptically according to Stage semantics
#tasks[19]="EE-STG" 	# Enumerate all the extensions according to Stage semantics
#tasks[20]="SE-STG" 	# Enumerate some extension according to Stage semantics
#tasks[21]="DC-GR" 	# Decide credulously according to Grounded semantics
#tasks[22]="SE-GR" 	# Enumerate some extension according to Grounded semantics
#tasks[23]="DC-ID" 	# Decide credulously according to Ideal semantics
#tasks[24]="SE-ID" 	# Enumerate some extension according to Ideal semantics
#tasks[25]="D3"          # Dung's Triathlon
#|                                                                        |
#|  E N D   O F   I C C M A   2 0 1 7   L I S T   O F   P R O B L E M S   |
#+------------------------------------------------------------------------+


# E N D   O F   C O N F I G U R A T I O N    S E C T I O N
#################################################################

function list_output
{
	declare -a arr=("${!1}")
	check_something_printed=false
	echo -n '['
	for i in ${arr[@]}; 
	do
		if [ "$check_something_printed" = true ];
		then
			echo -n ", "
		fi
		echo -n $i
		check_something_printed=true
	done
        echo ']'
}

function main
{
	if [ "$#" = "0" ]
	then
		information
		exit 0
	fi

	cd  $(dirname $0)
	local local_problem=""
	local local_fileinput=""
	local local_format=""
	local local_additional=""

	while [ "$1" != "" ]; do
	    case $1 in
	      "--formats")
		list_output formats[@]
		exit 0
		;;
	      "--problems")
		list_output tasks[@]
		exit 0
		;;
	      "-p")
		shift
		local_problem=$1
		;;
	      "-f")
		shift
		local_fileinput=$1
		;;
	      "-fo")
		shift
		local_format=$1
		;;
	      "-a")
		shift
		local_additional=$1
		;;
	    esac
	    shift
	done

	res=$(solver $local_fileinput $local_format $local_problem $local_additional)

	#parse_output $local_problem "$res"
	echo $res | cut -d "'" -f2 | sed 's/\\n//g'
}

main $@
exit 0
