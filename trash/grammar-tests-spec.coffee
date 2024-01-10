describe "Grammar Tests grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("grammar-tests")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.gmrtsts")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.gmrtsts"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["source.gmrtsts"]

  it "tokenizes single line comments", ->
    {tokens} = grammar.tokenizeLine(" # this is a comment")
    expect(tokens[0]).toEqual value: " # ", scopes: ["source.gmrtsts", "comment.line.gmrtsts","punctuation.definition.comment.gmrtsts"]
    expect(tokens[1]).toEqual value: "this is a comment", scopes: ["source.gmrtsts", "comment.line.gmrtsts"]

  it "tokenizes multi line comments", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_COMMENT
    This is a
    multi line comment.
    #+END_COMMENT
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_COMMENT", scopes: ["source.gmrtsts", "comment.block.gmrtsts", "punctuation.definition.comment.gmrtsts"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.gmrtsts", "comment.block.gmrtsts"]
    expect(thirdLineTokens[0]).toEqual value: "multi line comment.", scopes: ["source.gmrtsts", "comment.block.gmrtsts"]
    expect(forthLineTokens[0]).toEqual value: "#+END_COMMENT", scopes: ["source.gmrtsts", "comment.block.gmrtsts", "punctuation.definition.comment.gmrtsts"]

  it "tokenizes single line literal examples", ->
    {tokens} = grammar.tokenizeLine(" : This is a literal example on single line.")
    expect(tokens[0]).toEqual value: " : ", scopes: ["source.gmrtsts", "string.unquoted.gmrtsts", "punctuation.definition.string.gmrtsts"]
    expect(tokens[1]).toEqual value: "This is a literal example on single line.", scopes: ["source.gmrtsts", "string.unquoted.gmrtsts"]

  it "tokenizes multi line literal examples", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_EXAMPLE
    This is a
    multiple line literal example.
    #+END_EXAMPLE
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_EXAMPLE", scopes: ["source.gmrtsts", "punctuation.definition.string.gmrtsts"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.gmrtsts", "string.unquoted.gmrtsts"]
    expect(thirdLineTokens[0]).toEqual value: "multiple line literal example.", scopes: ["source.gmrtsts", "string.unquoted.gmrtsts"]
    expect(forthLineTokens[0]).toEqual value: "#+END_EXAMPLE", scopes: ["source.gmrtsts", "punctuation.definition.string.gmrtsts"]

  it "tokenizes multi line quote blocks", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    #+BEGIN_QUOTE
    This is a
    multiple line quote.
    #+END_QUOTE
    """
    expect(firstLineTokens[0]).toEqual value: "#+BEGIN_QUOTE", scopes: ["source.gmrtsts", "punctuation.definition.quote.gmrtsts"]
    expect(secondLineTokens[0]).toEqual value: "This is a", scopes: ["source.gmrtsts", "markup.quote.gmrtsts"]
    expect(thirdLineTokens[0]).toEqual value: "multiple line quote.", scopes: ["source.gmrtsts", "markup.quote.gmrtsts"]
    expect(forthLineTokens[0]).toEqual value: "#+END_QUOTE", scopes: ["source.gmrtsts", "punctuation.definition.quote.gmrtsts"]


  it "tokenizes shell code blocks", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens, fifthLineTokens, sixthLineTokens] = grammar.tokenizeLines """
    #+NAME: shell-code
    #+BEGIN_SRC shell :eval never :noweb yes
    VARIABLE_NAME=`hostname`
    echo ${VARIABLE_NAME}
    #+END_SRC
    # Comment below shell-code
    """
    # Disabled # expect(firstLineTokens[0]).toEqual value: "#+NAME: shell-code", scopes: ["source.gmrtsts"]
    expect(secondLineTokens[0]).toEqual value: "#+BEGIN_SRC ", scopes: ["source.gmrtsts", "punctuation.definition.string.gmrtsts"]
    expect(secondLineTokens[1]).toEqual value: "shell", scopes: ["source.gmrtsts", "code-block.type.gmrtsts"]
    expect(secondLineTokens[2]).toEqual value: " :eval never :noweb yes", scopes: ["source.gmrtsts", "code-block.code-block-headers.gmrtsts"]
    # Disabled # expect(secondLineTokens[3]).toEqual value: "This is a", scopes: ["source.gmrtsts", "bc4"]
    # Disabled # expect(secondLineTokens[4]).toEqual value: "This is a", scopes: ["source.gmrtsts", "bc5"]
    expect(thirdLineTokens[0]).toEqual value: "VARIABLE_NAME=", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts"]
    expect(thirdLineTokens[1]).toEqual value: "`", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "string.interpolated.backtick.shell-gmrtsts", "punctuation.definition.string.begin.shell-gmrtsts"]
    expect(thirdLineTokens[2]).toEqual value: "hostname", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "string.interpolated.backtick.shell-gmrtsts"]
    expect(thirdLineTokens[3]).toEqual value: "`", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "string.interpolated.backtick.shell-gmrtsts", "punctuation.definition.string.end.shell-gmrtsts"]
    expect(forthLineTokens[0]).toEqual value: "echo", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "support.function.builtin.shell-gmrtsts"]
    expect(forthLineTokens[1]).toEqual value: " ", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts"]
    expect(forthLineTokens[2]).toEqual value: "${", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "variable.other.bracket.shell-gmrtsts", "punctuation.definition.variable.shell-gmrtsts"]
    expect(forthLineTokens[3]).toEqual value: "VARIABLE_NAME", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "variable.other.bracket.shell-gmrtsts"]
    expect(forthLineTokens[4]).toEqual value: "}", scopes: ["source.gmrtsts", "source.embedded.shell-gmrtsts", "variable.other.bracket.shell-gmrtsts", "punctuation.definition.variable.shell-gmrtsts"]
    expect(fifthLineTokens[0]).toEqual value: "#+END_SRC", scopes: ["source.gmrtsts", "punctuation.definition.string.gmrtsts"]
    expect(sixthLineTokens[0]).toEqual value: "# ", scopes: ["source.gmrtsts", "comment.line.gmrtsts", "punctuation.definition.comment.gmrtsts"]
    expect(sixthLineTokens[1]).toEqual value: "Comment below shell-code", scopes: ["source.gmrtsts", "comment.line.gmrtsts"]



  it "tokenizes heading 9", ->
    [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens] = grammar.tokenizeLines """
    ********* Heading 9
    Body of Heading - Line 1
    * Another Heading
    """
    expect(firstLineTokens[0]).toEqual value: "********", scopes: ["source.gmrtsts", "markup.heading.heading-9.gmrtsts", "leading-star.gmrtsts"]
    expect(firstLineTokens[1]).toEqual value: "*", scopes: ["source.gmrtsts", "markup.heading.heading-9.gmrtsts", "markup.heading.marker.gmrtsts"]
    expect(firstLineTokens[2]).toEqual value: " ", scopes: ["source.gmrtsts", "markup.heading.heading-9.gmrtsts", "markup.heading.space.gmrtsts"]
    expect(firstLineTokens[3]).toEqual value: "Heading 9", scopes: ["source.gmrtsts", "markup.heading.heading-9.gmrtsts"]
    expect(secondLineTokens[0]).toEqual value: "Body of Heading - Line 1", scopes: ["source.gmrtsts"]
    expect(thirdLineTokens[0]).toEqual value: "*", scopes: ["source.gmrtsts", "markup.heading.heading-1.gmrtsts", "markup.heading.marker.gmrtsts"]

#
#   it "tokenizes heading 8", ->
#     [firstLineTokens, secondLineTokens, thirdLineTokens, forthLineTokens, fifthLineTokens] = grammar.tokenizeLines """
#     ******** Heading 8
#     Body of Heading - Line 1
#     ********* Heading 9
#     Body of Heading - Line 1
#     * Another Heading
#     """
#     expect(firstLineTokens[0]).toEqual value: "********", scopes: ["source.gmrtsts", "markup.heading.heading-8.gmrtsts", "punctuation.definition.markup.heading.heading-8.begin.gmrtsts"]
#     expect(firstLineTokens[1]).toEqual value: " ", scopes: ["source.gmrtsts", "markup.heading.heading-8.gmrtsts", "punctuation.definition.markup.heading.spaces.gmrtsts"]
#     expect(firstLineTokens[2]).toEqual value: "Heading 8", scopes: ["source.gmrtsts", "markup.heading.heading-8.gmrtsts", "markup.heading.gmrtsts"]
#     expect(secondLineTokens[0]).toEqual value: "Body of Heading - Line 1", scopes: ["source.gmrtsts", "markup.heading.heading-8.gmrtsts", 'meta.section.block']
#     expect(thirdLineTokens[0]).toEqual value: "#+END_QUOTE", scopes: ["source.gmrtsts", "text.plain.embedded.gmrtsts", "punctuation.definition.string.gmrtsts"]
#     expect(forthLineTokens[0]).toEqual value: "* ", scopes: ["source.gmrtsts", "markup.heading.heading-8.gmrtsts", "punctuation.definition.markup.heading.heading-8.end.gmrtsts"]
