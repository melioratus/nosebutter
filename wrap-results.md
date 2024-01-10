<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Examples of <code>:wrap</code> header</a>
<ul>
<li><a href="#sec-1-1">1.1. Use <code>C-c</code> <code>C-v</code> <code>C-j</code> <code>w &lt;tab&gt;</code> to create a <code>:wrap</code> header</a></li>
<li><a href="#sec-1-2">1.2. Does <code>:wrap</code> header allow spaces?</a></li>
<li><a href="#sec-1-3">1.3. Does <code>:wrap</code> header allow dynamic values?</a></li>
</ul>
</li>
</ul>
</div>
</div>

Examples of `:wrap` header<a id="sec-1" name="sec-1"></a>
==========================

Use `C-c` `C-v` `C-j` `w <tab>` to create a `:wrap` header<a id="sec-1-1" name="sec-1-1"></a>
----------------------------------------------------------

-   Before
    
        #+begin_src sh :results scalar replace  
          echo "Hello World"
        #+end_src
        
        #+RESULTS:
        : Hello World

-   After
    
        #+begin_src sh :results scalar replace :wrap my_wrapper 
          echo "Hello World"
        #+end_src
        
        #+RESULTS:
        #+BEGIN_my_wrapper
        Hello World
        #+END_my_wrapper

Does `:wrap` header allow spaces?<a id="sec-1-2" name="sec-1-2"></a>
---------------------------------

-   Answer: **Yes**
    
        #+begin_src sh :wrap WORD1 WORD2
          echo "Does ~:wrap~ header allow spaces?"
        #+end_src
        
        #+RESULTS:
        #+BEGIN_WORD1 WORD2
        Does ~:wrap~ header allow spaces?
        #+END_WORD1

Does `:wrap` header allow dynamic values?<a id="sec-1-3" name="sec-1-3"></a>
-----------------------------------------

-   Answer: **Yes** but must call dynamic values using elisp.
    
        #+NAME: a_named_comment
        #+BEGIN_COMMENT
        VALUE_FROM_NAMED_COMMENT
        #+END_COMMENT
        
        #+CALL: a_named_comment()
        
        #+RESULTS:
        : VALUE_FROM_NAMED_COMMENT
        
        #+begin_src sh :wrap (org-sbe a_named_comment)
          echo "Does ~:wrap~ header allow dynamic values?"
        #+end_src
        
        #+RESULTS:
        #+BEGIN_VALUE_FROM_NAMED_COMMENT
        Does ~:wrap~ header allow dynamic values?
        #+END_VALUE_FROM_NAMED_COMMENT
    
    -   Troubleshooting: What happens if don't use elisp `(org-sbe )` syntax, e.g. a\_named\_comment()
        
        Answer: Same results as passing a string value.
        
            # Try 1 
            
            #+begin_src sh :wrap a_named_comment()
              echo "Does ~:wrap~ header allow dynamic values?"
            #+end_src
            
            #+RESULTS:
            #+BEGIN_a_named_comment()
            Does ~:wrap~ header allow dynamic values?
            #+END_a_named_comment()
            
            # Try 2
            
            #+begin_src sh :wrap call_a_named_comment()
                  echo "Does ~:wrap~ header allow dynamic values?"
            #+end_src
            
            #+RESULTS:
            #+BEGIN_call_a_named_comment()
            Does ~:wrap~ header allow dynamic values?
            #+END_call_a_named_comment()
