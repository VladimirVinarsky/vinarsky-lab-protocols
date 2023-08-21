# Check for file as argument

This code is useful to check if the script has some input to run on. In case there is no file as an argument on the command-line it tells you how to use the script.&#x20;

```bash
if ! [ -f "$1" ]
then
  echo "Supply a file as argument" 
  echo "Usage: ${0} file"
  exit 0
fi

```

