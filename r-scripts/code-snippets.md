---
description: >-
  Avoid retyping parts of code again and again Have a list of the most commonly
  used snippets sharable between the different machines in a text file pieces of
  code for R
---

# Code snippets

{% hint style="success" %}
This is a sucess

but can also be anything else
{% endhint %}

{% hint style="warning" %}
This is a warning
{% endhint %}

{% hint style="info" %}
This is info
{% endhint %}

{% hint style="danger" %}
This is a danger
{% endhint %}

## Code snippets

### Resources

[link to posit website](https://support.posit.co/hc/en-us/articles/204463668-Code-Snippets)

### Editing

1. The code snippets are in RStudio IDE -> Tools -> Global Options -> Code -> Snippets (at the very bottom)\\
2. The file with snippets lives here:

* windows: `%appdata%/Roaming/RStudio/snippets/r.snippets`
* linux: `~/.config/rstudio/snippets/r.snippets`

### Syntax

The snippet contains:

1. The text which is written in the snippet code
2. Fields you can fill in. You go from one field to another using TAB

### Example

```
snippet hello
	name<- c(name="${1:first_name}",surname="${2:second_name}")
	print(paste(sep=" ","hello",name[1],name[2]))
```

### Anatomy of the snippet:

`name="${1:first_name}", surname=(...`

* **`name="`** is the text which is printed before the field
* **`${1:first_name}`**: is a field to be filled
* **`${}`** defines the field
* **`1`** field identifier, defines the order in which the fields are filled in
* **`:first_name`** text which appears by default and is replaced by what you type
* **`", surname=(...`** text printed after the field
* snippets enable filling multiple fields by the same content when the same field identifier is used multiple times

### Most useful use cases relevant for me

* set the common set of libraries I use
* set the working directory using the rstudioapi
* have the interaction with the user prepared

###
