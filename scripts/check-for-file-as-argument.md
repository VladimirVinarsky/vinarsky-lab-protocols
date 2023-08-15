# Check for file as argument

```bash
if ! [ -f "$1" ]
then
  echo "Supply a file as argument" 
  echo "Usage: ${0} file"
  exit 0
fi

```
