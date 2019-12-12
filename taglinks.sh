#!/bin/bash

#-------------------------------------------------------------------------------
function _help {
#-------------------------------------------------------------------------------
	cat <<HELP
* taglinks.sh
	* Description
		taglinks.sh is a tool for create tags for files or find files by tags.

		It's based in linux links (ln -s)
	* Use
		> taglinks.sh command options
	* Parameters 
		* Commands
			* help
				Show this help.
			* setup [directory]
				In de directory specified or in present directory if omited 
				creates a directory (.taglinks_d) where taglinks.sh stores 
				all the information of the tags.

				This information is available for taglinks if is used in this 
				directory or any or its descendents.
			* tag
				Assign a tag or tags to one or many files.

				> taglinks.sh tag1[,tag2[,tagn]] file [file2]

				Tags can be added separated by commas.
			* search
			* fix
			* info
HELP

}
#-------------------------------------------------------------------------------
function setup {
#-------------------------------------------------------------------------------
	if [ "x$1" == "x" ]; then
		dirbase=$(realpath .);
	else
		dirbase=$(realpath $1);
	fi
	mkdir $dirbase/.taglinks_d
	echo "Created dir $dirbase/.taglinks_d, it will store taglinks information for directory $dirbase and it's descendents." >&2
}
#-------------------------------------------------------------------------------
function dirtags {
#-------------------------------------------------------------------------------
	origendir=$(realpath $1)
	diractual="$origendir"

	while true; do 
		if [ -d $diractual/.taglinks_d ]; then
			echo $diractual/.taglinks_d
			return;
		else
			if [ $diractual == / ]; then
				echo "Error: .taglinks_d not found in $origendir nor in its ancestors." >&2
				exit 1
			fi
			diractual=$(dirname $diractual)
		fi
	done
}
#-------------------------------------------------------------------------------
function tag {
#-------------------------------------------------------------------------------
	tags="$1"
	shift;
	IFS=',' read -ra TAGS <<< "$tags"
	for t in "${TAGS[@]}"; do 
		for f in $*; do 
			dirtags="$(dirtags $f)";
			[ -d "$dirtags/$t" ] || mkdir "$dirtags/$t"
			[ -e "$dirtags/$t/$(basename $f)" ] || ln -s "$(realpath $f)" "$dirtags/$t" 
		done
	done
}
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
if [ "x$1" == "x" ]; then
	echo "Error: you must specify one action.";
	_help;
	exit 2;
fi
if [ $1 == "help" ]; then
	_help; 
	exit 0;
elif [ $1 == "setup" ]; then
	shift;
	setup $*;
elif [ $1 == "tag" ]; then
	shift;
	tag $*;
fi

