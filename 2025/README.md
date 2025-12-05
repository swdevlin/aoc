# Advent of Code: 2025

Ruby has been on the "to learn" list for a while. When [@tankorsmash](https://github.com/tankorsmash) asked me about this
year's AoC, it seemed like AoC would be a good opportunity to learn the
fundamentals of Ruby.

Since the goal of this year is learning Ruby, AI is not going to be except to answer 
questions like "How do I find the maximum value in an array".

## Day 1

Ruby is OO, so I decided that the code would use classes rather than simple
functions. This is likely not the best way to tackle the puzzles, but it will help
with learning Ruby fundamentals.

[@tankorsmash](https://github.com/tankorsmash) suggested writing a script to fetch the data file. Makes good sense. Let's
learn some Ruby libraries. Easy peasy.

Unit tests are written against the sample test data in the question.

The initial plan was to use wsl on Windows for running the code. But, the overhead
was a bit much, and as the code for the challenges is straightforward, Ruby on Windows
will be used

## Day 2

Today was a good Ruby day. Learned about scan and `&:symbol`.

## Day 3

I did not like this day. I did not like it one bit.

It took me almost four hours to figure out 3b. The issue was the solution for 3a. Turns
out, the solution for both problems is the same. But, my solution of 3a would not work
for 3b. A lot of time was spent trying to get it to work. Then a recursion approach was
tried. Then a different recursion approach was tried. Then a non-recursion approach was tried.
Eventually, I grabbed a line from the puzzle data file and did it manually.
Doh! Such a simple solution. 3b coded in about 5 minutes. 3a was not rewritten. Posterity and such.

Oh, since the code for each day runs independently, using Challenge as the class name seems 
like a decent thing to do.

RubyMine is starting to get annoying. I was expecting an experience like WebStorm or Pycharm
but RubyMine does not feel that polished:
* Debugging steps in library code (umm no)
* Selecting an item in the project does not drop the cursor into the editor
* Runtime error links often don't like to the offending line

Today I learned about `..` and `...`

## Day 4

Today was pretty straightforward.

## Day 5

Smalltalk encourages small objects. Since one of Ruby's parents is Smalltalk, I decided
to take that approach. AoC puzzles can be solved via arrays and hashes.
But that's not gonna help learning.

The solution to 5a would work for 5b if one could wait long enough. Efficient, it is not.
A different approach was needed for 5b. Once I realized that I could keep the list in order,
the solution was trivial.
