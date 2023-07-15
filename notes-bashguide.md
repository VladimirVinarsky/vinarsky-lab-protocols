# notes bashguide

## Building CLI

### Motivation

Make an interface for a script with following:

* has help
* has a back button
* has a save button
* tells the user what to do

### Resources

[link to medium blog](https://medium.com/@brotandgames/build-a-custom-cli-with-bash-e3ce60cfb9a4)\\

### Example

## Autocompletion in BASH

### Resource

[link to a blog goes deep](https://spin.atomicobject.com/2016/02/14/bash-programmable-completion/)\
[link to a stack overflow thread](https://superuser.com/questions/289539/custom-bash-tab-completion)\
[tutorial referred in the stack overflow](https://fahdshariff.blogspot.com/2011/04/writing-your-own-bash-completion.html)\\

### Example

This example comes from the abovemnetioned stack overflow thread.

Following code was added to `~/.bash_functions` file.

```
_cooltool()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "fooOption barOption" -- $cur) )
}
complete -F _cooltool cooltool
```

This code uses the `compgen` and `complete` builtins (which manual pages I have not seen, but it looks amazing to make any CLI application useful.

### Future

* figure how to supply names of the commands to the function through a file
* use it in an application

## Select command

### Motivation

be able to make menus

### Resources

[link to the gnu bash manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Conditional-Constructs)\
[link to the bashguide from wiki wooledge](broken-reference)

### Syntax

`select name [in words …]; do commands; done`

### Examples

## Case command

### Motivation

* get rid of if else nested statements
* enable single choice/ multiple choice for interaction with a user

### Resources

[man bash page from gnu](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Conditional-Constructs)\
[wiki wooledge bash guide](https://mywiki.wooledge.org/BashGuide/TestsAndConditionals#Choices\_.28case\_and\_select.29)

### Syntax

* the normal case statement is useful in case I want to have a single choice of multiple possibilities

#### Single match

In case you want to find the first match of the case, execute the code and exit use `;;` at the end of the pattern

#### Multiple matches

In case you do not want to exit after the first match, but keep searchiing and executing use the `;;?` at the end of the pattern

#### Fallthrough

In case you want to follow the match with automatic execution of the next line, use the `;&` at the end.\
This is good for some more complex cases which are over my head, but good to know.

### Examples

All the examples mentioned here are in the `~./bash_functions` file.

#### "Single choice"

```
# This functions uses the most standard `case ;;` to print single statement for animals groupe in non-overlapping categories by using ;;

animal_test_1(){
echo "write name of one animals from following: dog human horse parrot fish to realize who is mammal and who is not";
read ANIMAL
case "$ANIMAL" in 
  dog|human|horse ) echo "is a mammal" ;;
  parrot|fish     ) echo "is not a mammal" ;;
  *               ) echo "do not know this animal" ;;
esac
}
```

#### "Multiple choice"

```
# This functions uses `case ;;&` to not stop after the first match 
# This is useful to print multiple statements for overlapping categories

animal_test_2(){
echo "write name of one animals from following: dog human horse parrot fish to realize who is mammal and how many legs it has";
read ANIMAL
case "$ANIMAL" in 
  dog|human|horse ) echo "is a mammal" ;;&  
  parrot|fish     ) echo "is not a mammal" ;;&
  fish            ) echo "has no legs" ;;&
  human|parrot    ) echo "has two legs" ;;&
  dog|horse       ) echo "has four legs" ;;&
#  *               ) echo "do not know this animal" ;;
esac
}
```

#### "Multiple choice with hierarchy and crosstalk"

```
# This functions uses `case ;&` to fall through the next case and execute it withou the need to evaluate
# This is good for subsetting somehow

animal_test_3(){
echo "write name of one animals from following: dog human horse \"teddy bear\" parrot fish to realize who is mammal, how many legs it has, and which is cuddly";
read ANIMAL
case "$ANIMAL" in 
  dog|human) echo "is a mammal" ;;&  
  dog ) echo "has four legs" ;&
  dog|"teddy bear" ) echo "is cuddly" ;;&
  parrot|fish     ) echo "is not a mammal" ;;&
  fish            ) echo "has no legs" ;;&
  human|parrot    ) echo "has two legs" ;;&
#  *               ) echo "do not know this animal" ;;
esac
}
```

## Chapter 4 Parameters

assignment syntax:\
`varname=vardata`\
_there must NOT be any space between the varname-identifier and vardata-value_\\

Special character `$` followed by identifier is required for the expansion of the parameter into its value.\\

In order to supply the value of the variable in one piece into any relevant command, the `$identifier` needs to be quoted like this: `"$identifier"`.\\

### 4.1 Special Parameters and Variables

The difference between parameters and variables:\
**variables are parameters denoted by names**\
**special parameters are `$` followed by number or special characters such as `*, @, #, ?, $, !, -` ie parameters which are not variables**\\

| Usage | Description                                                                                                                 |
| ----- | --------------------------------------------------------------------------------------------------------------------------- |
| `0`   | name or the path of the script, not always reliable                                                                         |
| `1`   | Positional parameters passed to the current script or function                                                              |
| `*`   | expands to all the words of all the positional parameters                                                                   |
| `@`   | expands to all the words of all the positional parameters, double quoted it expands to a lis of the all as individual words |
| `#`   | expands to a number of all positional parameters                                                                            |
| `?`   | expands to the exit code of the most recently completed foreground command                                                  |
| `$`   | Expands to the PID of the current shell                                                                                     |
| `!`   | Expands tho the pid of the command most recently executed in the bacground                                                  |
| `_`   | Expands to the last argument fo the last command that was executed                                                          |

#### Some inbuilt Variables

**BASH\_VERSION**\
**PWD** current working directory\\

### 4.2 Variable types

* Array: `declare -a <variable>` or `<variable>()` array of strings
* Associative array: `declare -A <variable>` associative array
* Integer: `declare -r <variable>`
* Read Only: `declare -r <variable>` the variable cannot be modified or unset
* Export: `declare -x <variable>` the variable is exported by default

### 4.3 Parameter Expansion

This is super useful, but I feel I am a little bit too tired to study this.

#### Cutting the parameter based on lenght

`${parameter:offset:lenght}`

**when array**

In case you supply array than the numbers offset and lenght are the indices numbers\
`fruits=(apple apricot banana coconut or51nge)`\
`echo ${fruits[@]:1:2}`\
`apricot banana`\\

**when single string value**

In case there is single string supplied, the offset and lenght are the indexes along the strind.\
`echo ${fruits[1]:1:2}`\
`pr`\\

#### Counting the lenght of parameter or array

`${#parameter}`\\

`echo ${#fruits[1]}` to get the lenght of the second string\
`echo ${#fruits[@]}` to get the lenght of the array\\

#### Patterns

some expansion works on the patterns:

* \[ab] to detect a or b
* ? for one or more
*
  * for zero or more
* \[0-9] for digits

#### Deleting matching pattern in the beggining

**normal**

`${parameter#pattern}`\\

Deletes the shortest matching pattern.\
`echo ${fruits[@]#ap}`\
Again if applied to the array, acts on all the items.\\

**greedy**

`${parameter##pattern}`

Deletes the longest matching pattern.\
`echo ${fruits[@]##ap}`\\

#### Deleting matching pattern in the end

**normal**

`${parameter%pattern}`

`echo ${fruits[@]%na}`\
Again if applied to the array, acts on all the items.\\

**greedy**

`${parameter%%pattern}`

Deletes the longest matching pattern.\
`echo ${fruits[@]%%na}`\\

#### Substituting/deleting unanchored pattern

**Acting only on the first match**

`${parameter/pattern/string}`\
when the '/string' part is missing it means deletion of the pattern

**Acting on all matches**

`${parameter//pattern/string}`\
when the '/string' part is missing it means deletion of the pattern

#### Substitution/deletion of matching patterns anchored at beginning or end

`${parameter/#pattern/string}` useful for adding a common prefix `${parameter/#/string}`\
`${parameter/%pattern/string}` useful for adding a common suffix `${parameter/%/string}`\\

\newpage

## Chapter 5 Patterns

### Intro

There a three different systems for a pattern matching in the shell.\\

## Chapter 5 Patterns

### Intro

There a three different systems for a pattern matching in the shell.\\

1. Globs expansion
2. Extended globs expansions
3. Since the version 3.0 bash supports regular expressions

### 5.1 Glob Patterns

Used for finding files in the shell\\

* `*` asterix matches any string including the null string
* `?` questionmark matches any SINGLE character
* `[...]` matching any of the enclosed characters

Globs are implicitly anchored at both ends. For example `a*` does not match `cat` The `*` and `?` characters cannot be used to substitute for `/` in the file system.\
However it can be used to match `/` in patterns.\
`var="test/of/split"`\
`echo ${var/st?}` gives `teof/split`

### 5.2 Extended Globs

The extended Globs are more powerful, more similar to regular patterns.\
It is disabled by default, needs to be activated by `shopt` command `shopt -s extglob`\\

For occurence of given patterns (list):\\

* ? (list): matches zero or one occurences
*
  * (list): matches zero or more occurences
*
  * (list): mathces one or more occurences
* @ (list): matches one of the given patterns
* ! (list): matches anything but the given patterns

List inside the parentheses is a list of globs or extended globs separated by vertical pipe `|`.\
`$ ls`\
`names.txt tokyo.jpg california.bmp`\
`$ echo !(*jpg|*bmp)`\
`names.txt`\\

### 5.3 Regular Expressions

The main difference between the regular expressions and the extended globs is that the regular expression can be only used to compare strings.\
The bash version >3.0 supports the `=~` operator and the `[[` keyword.\
Since 3.2 bash the regular expression should not be quoted.\
It is a good idea to put the regular expression into a variable and then use the `=~` operator.

### 5.4 Brace `{...}` Expansion

Works similarly to globs.\
Happens before the glob expansion.\\

1. `echo th{e,a}n` gives `then than`\\
2. `echo th{1..3}en` gives `th1en th2en th3en`
3. `echo {1..2}{a..c}` gives `1a 1b 1c 2a 2b 2c`
4. `echo {/home/*,/root}/.*profile` gives `/home/vladimir/.profile /root/.*profile` some more intricacies:

* brace expansion enables both going forward and backward
* brace expansion ignosres the local variables like LANG and LC\_COLLATE and always goes with the ASCII codes

ASCII codes:\
COntain only the upper and lower characters, brackets, underscore, apostrophe and the roof symbol.\
`A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ ] ^ _` a b c d e f g h i j k l m n o p q r s t u v w x y z\`\\

Therefore you can do something like this:

`var=2my[var`\
`${var/[A-z]/XYZ_}` gives you `$ 2XYZ_y[var`\
using the all matching `\${var//[A-z]/XYZ_}` gives you `$ 2XYZ_XYZ_XYZ_XYZ_XYZ_XYZ_`

newpage\\

## Chapter 7 Arrays

### Intro

1. It is not useful to use single string to keep multiple values by using separator ( like `item1, item2, item3` or `item1 item2 item3`).
2. Arrays are good to keep the different values well separated
3. The different items can be expanded using their indices numbers (starting with \[0]), or used all \[@] etc.
4. The numbers of items can be counted ${#var\[@]}

### Example

#### This does not work in general case:

`files=$(ls *.jpg); cp $files /backups`\
The problem is that the `$files` is read by the `cp` command which expects parameters separated by spaces.\
In case there are some empty spaces in the name of the files, the cp takes only the first part of the filename to copy which can be dangerous.\
It is better to put the `$files` into `"$files"` to avoid the splitting.\
However it is not enough for some of the other specific characters such as newline etc.\\

#### This works:

`mkdir test`\
`cd test && mkdir backup`\
`touch a.md b.md c.md`\
`files=(*.md); cp "${files[@]}" backup/`\\

### 7.1 Creating arrays and sparse arrays

using the `(..)` syntax\
names=("vlada" "jane" "agapornis beautiful bird")\
_It is not necessary to quote the items of the array, however it uses a space as a separator so in case you have something with a space you definitely need to qoute it!_\\

### Definig indices directly

The indices of the array can be directly specified:\
names2=(\[0]="vlada" \[2]="jane" \[1]="agapornis beautiful bird")\
The indeces do not have to be uninterrupted line of integers, there can be holes in the indeces, this is called sparse arrays.\
`names[25]="little baby"`\\

#### To get the output of the array:\\

1. `echo $names` is wrong, gives you just the first item
2. `echo ${names[@]}`is correct gives you all the items of the array

#### The same applies in case you want to assign this variable values to another array:\\

1. `var=("${names[@]}")` is the proper way

**WRONG**\\

1. `var=$names` populates the `var` variable with the first item of the `names` array
2. `var=$names[@]` populates the `var` variable with the first item of the `names` array with `[@]` appended.
3. `var=${names[@]}` populates the \[0] index with all the items from names separated by space
4. `var=(${names[@]})` creates array, but as long as there is a space somewhere, splits the item and adds more items to it.

#### How do I append another value to the array?\\

**By using the `var+=()` notation.\\**

`names+="little baby boy"`\
This has some unexpected behaviour, adds the "little baby boy" into second place, without keeping the separator between the first original item and the inserted string. Now I understand it, it just gets the first item and concatenates the new string to the first one, however I do not know how to add to the end of the array, need to read further obviously.

**My way**

The `[..]` brackets of indices automatically works with math inside.\
In order to add the new item at the end requires the addition of 1 to the total numbers of indices.\\

`names[${#names[@]}+1]="new names item"`

Looks rather complicated to be the only right solution, but who knows.

### 7.2.1 Expanding arrays pg. 58

To understand the structure of the array use the `declare -p <variable>` command.\
`declare -p names` see that here I do not need to prepend it with the dollar sign as in `echo`.\
`$ declare -a names=([0]="vlada" [1]="jane" [2]="agapornis the beautiful bird")`\\

In case you want to have the print more nice and organized use the `printf` syntax.\
`$ printf '%s\n' "${names[@]}"` where `%s` means the array item is a string followed by a newline. But it can be followed by pipe or whatever string character you choose.\
_The thing to note here is that `printf` loops through the array on its own by default, in case we are using some other command we need to make the for loop ourselves._\\

Using the array in a for loop:\
`for file in ${myfiles[@]}; do cp "$file" backup/; done`\\

* Would be great if in here you could also use a range of the indices `[0-2]` or something similar. However putting `echo ${names[0-2]}` does not work so I leave this open for today.\*

Make a file containing the names of the files with correct delimiter (the null byte \0)\
Do not really understand how to use it but I guess I can keep it in for now.\
`myfiles=(*.md)`\
`printf '%s\0' "${myfiles[@]}" > myfiles.txt`\\

#### Difference between the \[@] and \[\*] array expansion:

`[*]` gives you all the items of the array, mungles them together as a single string which is practical if you want to just simply list them and use some delimiter.\
`(IFS=,; echo "Today these guests are most welcome: ${names[*]}")` \\

1. all is enclosed in parentheses () to make sure that the IFS is changed just in the subshell
2. the IFS takes just the one charcter as the delimiter, in case you want to separate by something more, you need to do it different way using printf or a for loop.

Getting the number of items in the array `echo ${#names[@]}`

### 7.2.2 Expanding Indices

Very often it is not useful to expand the items, but to expand the indices.\
For example when you have an array of first names and second names.\\

`first=(vlada jane agapornis)`\
`second=(vinarsky garlikova "beautiful bird")`\
`echo "${first[1]} ${second[1]}"`\\

#### Indices expansion integrated in a for loop (1)

`for name in "${!first[@]}"; do echo "${first[name]} ${second[name]}" ; done` \\

#### Indices expansion in a for loop (2)

In case the array is not sparse, we can do some intersting math inside the for loop in case we want to take for example every second item of the collection or something in the same vein.

`a=(a b c q w x y z)`\
`for ((i=0; i<${#a[@]}; i+=2)); do`\
`echo "${a[i]} and ${a[i+1]}"`\
`done`\\

### 7.3 Associative arrays

There can be also key-values pairs in the arrays.\
The array needs to be defined using `declare -A <name of the associated array>` As far as I understand it it is impossible to use the indices in the square brackets to get the values.\
You can iterate over them using the `${!<associative array>[@]}` approach but the numbers of the indices cannot be used reliably to keep the same order.\
Of course for the associative arrays other variables can be used to expand the value of the pair.\\

Example:\
`declare -A assocArray`\
`assocArray=(["vladimir"]="muz" ["jane"]="zena")`\
`echo "when directly called by key 'vladimir': "${assocArray["vladimir"]}""`\
`echo "when '\$USER' variable is used as a key: "${assocArray["$USER"]}""`\
`echo "game over"`\\
