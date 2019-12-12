# taglinks.sh
## Description
taglinks.sh is a tool for create tags for files or find files by tags.

It's based in linux links (ln -s)


## Use
```
 taglinks.sh command options
```


## Parameters 
### Commands
#### help
Show this help.


#### setup [directory]
In de directory specified or in present directory if omited 
creates a directory (.taglinks_d) where taglinks.sh stores 
all the information of the tags.

This information is available for taglinks if is used in this 
directory or any or its descendents.


#### tag
Assign a tag or tags to one or many files.

```
 taglinks.sh tag1[,tag2[,tagn]] file [file2]
```

Tags can be added separated by commas.


#### search

#### fix

#### info





