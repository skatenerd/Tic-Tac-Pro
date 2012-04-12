This is an implementation of TTT in Prolog.

Learning Prolog:

  I learned Prolog from these two resources:
    http://www.learnprolognow.org/
    http://boklm.eu/prolog/

  I prefer the first site because it is clear and moves quickly.  

  The author of the second site takes good photographs, though.

  Try to really understand the idea of a predicate, and solving for a predicate.

  The idea is that Prolog resolves predicates for you.

  You see a lot of predicates with what look like "output arguments".  DO NOT, I
  repeat, DO NOT just think of these as output arguments.  These variables are inputs to
  the predicate.  Prolog is looking for values to assign to these arguments in order to
  satisfy the predicate!

  Fortunately, there is not much syntax.

  Unfortunately, understanding Prolog requires understanding a lot about how Prolog works.
  Don't be afraid to dive in and try to understand "backtracking".  This is the process 
  through which Prolog tries to resolve predicates.
  

Setting up the environment:
  Go to http://www.swi-prolog.org/download/stable
  Download the binary appropriate to your environment
  It will be named something like, "swi-prolog-6.0.2-lion-intel.mpkg.zip"
  Double click it to install.
  Now you can enter the repl by typing "/opt/local/bin/swipl" at the command line.

Important prolog fact:
  All inputs must be followed by a period (".").  The interpreter doesn't know when
  you have finished typing unelss you use a period.

Running the tests:
  CD to project root.
  You can run tests on modules individually by typing:
    consult('spec/my_module_spec.pl').
    run_tests(test_group_name).
  Alternatively, you can run tests on all of the modules at once by typing:
    consult('spec/run_tests.pl').
    run_all.
  Running all of the tests at once will produce some output.  Make sure the word "error" does not appear.

Running the game:
  CD to project root.
  Enter repl ("/opt/local/bin/swipl")
  Type:
    consult('src/ttt').
    ttt:initialize_game.
  Play!
