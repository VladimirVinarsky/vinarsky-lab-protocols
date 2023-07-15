# git shortcuts

## Save the last commit hash to the variable

```
last=$(git log --oneline | head -n 1 | cut -d " " -f1)
```

## Save the last 10 commit hashes to an array

```
last10=($(git log --oneline | head -n 10 | cut -d " " -f1))
```

## Show the dates of commits

```
git show -s --format=%ci <commit-hash>
```

{% tabs %}
{% tab title="last 10 commits" %}

{% endtab %}

{% tab title="Second Tab" %}
```
git show -s --format=%ci ${last10[@]}
```
{% endtab %}
{% endtabs %}
