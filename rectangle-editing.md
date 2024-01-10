Answer Use Org-mode Code Blocks to Convert from a String to List of Checkboxes in Multiple Languages
====================================================================================================

Wrap your list inside a named dynamic block
-------------------------------------------

```markdown
    Lec 1 |         1:20:36
    Lec 2 |         1:10:32
    Lec 3 |         1:08:33
    Lec 4 |         1:20:33
          ... More ...
    Lec 24 |        1:24:47
    Lec 25 |        1:25:21
```
Write or find an org-mode code block in your favorite programming language.
---------------------------------------------------------------------------

1.  Example 1 - Using an `elisp` Code Block
```elisp
        (dolist (x (split-string data "\n"))
              (princ (format "[ ] %s\n" x)))
```    

    -   [ ] Lec 1 |         1:20:36
    -   [ ] Lec 2 |         1:10:32
    -   [ ] Lec 3 |         1:08:33
    -   [ ] Lec 4 |         1:20:33
    -   [ ] &#x2026; More &#x2026;
    -   [ ] Lec 24 |        1:24:47
    -   [ ] Lec 25 |        1:25:21


2.  Example 2 - Using a `perl` Code Block
```perl
        map { printf qq([ ] %s\n), $_ } split(/\n/, $data);
```
```markdown
    -   [ ] Lec 1 |         1:20:36
    -   [ ] Lec 2 |         1:10:32
    -   [ ] Lec 3 |         1:08:33
    -   [ ] Lec 4 |         1:20:33
    -   [ ] &#x2026; More &#x2026;
    -   [ ] Lec 24 |        1:24:47
    -   [ ] Lec 25 |        1:25:21
```
3.  Example 3 - Using a `bash` Code Block
```bash
        while IFS='
' read -ra ADDR; do
              for i in "${ADDR[@]}"; do
                  echo "[X] $i"
              done
         done <<< "$data"
```
```markdown
    -   [X] Lec 1 |         1:20:36
    -   [X] Lec 2 |         1:10:32
    -   [X] Lec 3 |         1:08:33
    -   [X] Lec 4 |         1:20:33
    -   [X] &#x2026; More &#x2026;
    -   [X] Lec 24 |        1:24:47
    -   [X] Lec 25 |        1:25:21
```
4.  Example 4 - Using a `python` Code Block
```python
        l = ["[ ] {x}".format(x=row) for row in data.splitlines()]
        for i in l: print i
```
```markdown
    -   [ ] Lec 1 |         1:20:36
    -   [ ] Lec 2 |         1:10:32
    -   [ ] Lec 3 |         1:08:33
    -   [ ] Lec 4 |         1:20:33
    -   [ ] &#x2026; More &#x2026;
    -   [ ] Lec 24 |        1:24:47
    -   [ ] Lec 25 |        1:25:21
```
5.  Example 5 - Using a `ruby` Code Block
```ruby
        for l in  data.split("\n")
          puts "[ ] #{l}"
        end
```
```markdown
    -   [ ] Lec 1 |         1:20:36
    -   [ ] Lec 2 |         1:10:32
    -   [ ] Lec 3 |         1:08:33
    -   [ ] Lec 4 |         1:20:33
    -   [ ] &#x2026; More &#x2026;
    -   [ ] Lec 24 |        1:24:47
    -   [ ] Lec 25 |        1:25:21
```
