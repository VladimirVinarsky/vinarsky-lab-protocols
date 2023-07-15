# rename

The rename command (needs to be installed on 20.04)

## Motivation and use cases:

1. replace some common characters "-", " ","\_",
2. remove a matching pattern - only one or greedy
3. add something to the start, to the end
4. remove something from the start, from the end
5. know how to do the dry run
6. know

## Resources

[link to article](https://www.computerhope.com/unix/rename.html)

## Basic usage

`rename [ -v ] [ -n ] [ -f ] perlexpr [ files ]`

\-v is verbose, prints the names of the files successfully renamed -n no act, shows the files that would be renamed -f force overwrite existing files

## Perl syntax

The rename follows perl syntax `s/pattern1/pattern2/[gi]`\\

metacharacters:

1. ^,$ to match the start and and
2. ., +, ?, any character, preceding characters once or more, zero or one
3. \| or operator
4. (...) grouping
5. \[...] set of characters
6. \[^...] set of characters to be excluded
7. \t is a tab, \n is a newline, \r is a carriage return
8. \d is a digit \D is a non-digit
9. \w is a word character (alphanumeric or underscore), \W any single non-word character
10. \s matches single whitespace (space, tab, newline), \S single non-whitespace
11. \b zero width matching word boundary \B zero width matching all but not word boundary
12. \\
13. {n\[,\[n]]} are the quantifiers
    * (pattern){n} - matches exactly the number
    * (pattern){n,} - matchs n and more
    * (pattern){n,m} -matches from n to m occurences There is a lot, let me settle with this.

## Examples

### replace characters

files: a-b-c c-d-e

to replace the first matching character:\
`rename -n -v 's/-/_/' *`

output:\\

> rename(a-b-c, a\_b-c) rename(c-d-e, c\_d-e)

\-n -v flag tells you what gets renamed

to replace all the matching characters in all files ("\*"):\
`rename -n -v 's/-/_/g' *`

### replace the extension

`rename -n -v 's/\.jpg/\.jpeg/g'`

### remove two different extensions

`rename -n -v 's/(\.jpg|\.jpeg)//g'`

### add extension

`rename -n -v 's/$/\.jpg/g'`

### translate from one character set to another

`rename 'y/[a-z]/[A-Z]/'`

in case you try to rename to something which already exists, does not do it unless you use the -f flag.

### using the regex lookups

replace the last dash preceding the last character, which is a digit.

`rename -n -v 's/-(?=\d$)/_/'`

replace every dash preceded by a digit.

`rename -n -v 's/(?<=\\d)-/_/'`

### remove spaces replace with underscores

using the string substitution and enabeling substitution of one or more spaces with an underscore:\\

`rename -n -v 's/\s+/_/g' <files>`

Be aware, that using translate does not work!\
I guess it is because `\s` is not a character.\\

`rename 'y/\s/_/' <files> # doesnt work`

### remove spaces and dashes with underscore

rename -n -v 's/\s+|-/\_/g'

### replace weird characters to underscores as alias

rename dot, comma,semicolon,space, plus, question mark and dash to underscore to get "word" formatted name. Dot preceding extension (composed of digits and letters) is kept

`alias to_underscores_test="echo 'this is testmode, use to_underscore_run command to rename'; rename -v -n 's/(\,|\;|\s|\+|\?|-|(\.(?!(\w|\d)+$)))+/_/g'"`

`alias to_underscores_run="rename -v 's/(\,|\;|\s|\+|\?|-|(\.(?!(\w|\d)+$)))+/_/g'"`
