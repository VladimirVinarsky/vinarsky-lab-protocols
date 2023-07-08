# linux hacks

## grep

Find whether a file has a carriage return or not

{% code overflow="wrap" %}
```
if grep -qU $'\r' <file>; then echo "contains carriage return"; else echo "does not contain carriage return"; fi

```
{% endcode %}

`-q` silent mode just take the exit code

`-U` treat as a binary file (records carriage return)

`$'\r'` the last character and then the carriage return

