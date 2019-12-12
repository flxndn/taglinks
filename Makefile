README.md: README.sec
	sectxt.py --markdown $^ > $@

README.sec: taglinks.sh
	taglinks.sh help > $@
