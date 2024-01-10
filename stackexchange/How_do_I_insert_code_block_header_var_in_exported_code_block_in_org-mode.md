
Add Code to Org file
====================


expand-src-block
----------------

    #+NAME: expand-src-block
    #+BEGIN_SRC elisp :var block-name="" :var datum="" :var info="" :var lang="" :var body="" :exports none
      (save-excursion
        (org-babel-goto-named-src-block block-name)
        (setq datum (org-element-at-point))
        t)
      (setq info (org-babel-get-src-block-info nil datum))
      (setq lang (nth 0 info))
      (setq body (org-babel-expand-src-block nil info))
      (format "%s" body)
    #+END_SRC


Usage Examples
==============


General
-------

-   Use `noweb` Syntax to Export Code with Variables

    1.  Assign original code block a name using `#+NAME:`.
        
            #+NAME: print-abc
            #+BEGIN_SRC shell :var data="ABC"
              echo -n $data
            #+END_SRC
    
    2.  Prevent original code block from exporting using `:exports none`.
        
            #+NAME: print-abc
            #+BEGIN_SRC shell :var data="ABC" :exports none
              echo -n $data
            #+END_SRC
    
    3.  Create new `noweb` code block under original block.
        
            #+NAME: print-abc
            #+BEGIN_SRC shell :var data="ABC" :exports none
              echo -n $data
            #+END_SRC
            
            #+BEGIN_SRC shell :noweb yes :exports both 
             <<expand-src-block(block-name="print-abc")>>
            #+END_SRC
        
        Exported output should be similar to the following:
        
            data='ABC'
            echo -n $data
        
            ABC


Question Specific Use Case
--------------------------

Added `expand-src-block` code, `:exports none` headers and `noweb` code blocks to your original example use case.

    #+NAME: expand-src-block
    #+BEGIN_SRC elisp :var block-name="" :var datum="" :var info="" :var lang="" :var body="" :exports none
      (save-excursion
        (org-babel-goto-named-src-block block-name)
        (setq datum (org-element-at-point))
        t)
      (setq info (org-babel-get-src-block-info nil datum))
      (setq lang (nth 0 info))
      (setq body (org-babel-expand-src-block nil info))
      (format "%s" body)
    #+END_SRC
    
    * Export with variables
    :PROPERTIES:
    :header-args: :var status="not_finished"
    :END:
    
    #+NAME: example-table
    | 1 |
    | 2 |
    | 3 |
    | 4 |
    
    Here we import a table.          
    #+NAME: table-length
    #+BEGIN_SRC R :var table=example-table :tangle "./export_var.R" :exports none
    status <- "finished"
    dim(table)
    #+END_SRC
    
    # Export the expanded code
    #+BEGIN_SRC R :noweb yes :exports both 
     <<expand-src-block(block-name="table-length")>>
    #+END_SRC
    
    Here we think we import a table
    #+NAME: table-str-length
    #+BEGIN_SRC R :var table="./filename_example-table.tsv" :tangle "./export_var.R" :exports none
    length(table)
    print(status)
    #+END_SRC
    
    # Export the expanded code
    #+BEGIN_SRC R :noweb yes :exports both 
     <<expand-src-block(block-name="table-str-length")>>
    #+END_SRC
    
    *** Some subcase
    
    If I run with the data in ="./other_data.tsv"=
    #+call: table-str-length[ :var table="./other_data.tsv"]()

Exported results should be similar to the following:

    * Export with variables
    #+NAME: example-table
    | 1 |
    | 2 |
    | 3 |
    | 4 |
    
    Here we import a table.          
    #+BEGIN_SRC R
      table <- local({
           con <- textConnection(
    	 "\"1\"
      \"2\"
      \"3\"
      \"4\""
           )
           res <- utils::read.table(
    	 con,
    	 header    = FALSE,
    	 row.names = NULL,
    	 sep       = "\t",
    	 as.is     = TRUE
           )
           close(con)
           res
         })
      status <- "finished"
      dim(table)
    #+END_SRC
    
    #+RESULTS: 
    | 4 |
    | 1 |
    
    Here we think we import a table
    #+BEGIN_SRC R
      table <- "./filename_example-table.tsv"
      length(table)
      print(status)
    #+END_SRC
    
    #+RESULTS: 
    : not_finished
    
    *** Some subcase
    
    If I run with the data in ="./other_data.tsv"=
    #+RESULTS: 
    : not_finished


Test Info
=========

---

> This code was tested using  
> GNU Emacs 24.5.1 (x86\_64-unknown-cygwin, GTK+ Version 3.14.13)
>  of 2015-06-23 on desktop-new  
> org-mode version: 9.0 

