# Instructions for making datasets tidy

* both books files: multiple authors should be stored in author_1, author_2, and author 3.
    + for reading in: tsv-file -- line 44; txt-file -- line 42
    + for making the sets tidy -- line 403
    + high-grade question: how could you stack them on top of each other -- retaining one column called `author` -- instead of next to each other?
* ches_2017: simply read it in
    + line 40
* ches_2017_modified: each variable should get a column
    + for reading it in: line 52
    + for tidying: 385
* publishers: U.S. state should be in an extra column; both sheets should be read in. Hint: tibbles can be bound together using `bind_rows()`
    + for reading in: 272
    + for tidying: line 403
    + for binding together: `bind_rows()`
* spotify: read it in
    + for reading in: line 40
