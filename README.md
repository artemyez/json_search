Requirements:
● search match precision (full words matching)
● search for `Lisp Common` should match a programming language
named "Common Lisp"
● support for exact matches, e.g. `Interpreted "Thomas Eugene"`,
which should match "BASIC", but not "Haskell"
● match in different fields, e.g. `Scripting Microsoft` should return all
scripting languages designed by "Microsoft"
● writing code with reusability and extensibility in mind.
● support for negative searches, e.g. john --array, which should match
"BASIC", "Haskell", "Lisp" and "S--Lang", but not "Chapel", "Fortran"
or "S".
