# User Manual
This is a deterministic finite automata that accepts arithmetic expressions with decimal point and returns a list with each found token, in the order in which they were found and indicating their type.
## Prerequisites
The DFA was developed with Racket. <br>
Pre-built versions of Racket for a variety of operating systems and architectures, as well as convenient source distributions are available at
https://download.racket-lang.org

## Getting Started

### Installation
1. Download and install Racket (https://download.racket-lang.org)

2. Try typing `racket` on your command line, and you should see something like this: 
    ``` bash
    ~ : racket

    Welcome to Racket v.8.0.

    >
    ```
    If this is the case, you are ready to run Racket programs. 👍

    But, if you get an error like this: 
    ``` bash
    Unrecognized command: racket
    ```
    It means something went wrong with the installation. 😭 Try installing it again. 

### Clone this repo
All the necessary code is included in this repository. To download it in your machine, run the command:
```bash
git clone https://github.com/Ax010tl/racket.git
```
The code is contained in `actividad_3_2/dfa.rkt`. To run it, open the racket shell by typing `racket` and then run the command
``` lisp
> (enter! "actividad_3_2/dfa.rkt")
```
## Examples
We implemented the function `arithmetic-lexer`, which receives a string and returns a list of the all found tokens and their type.

### Example 1: Binary operation
``` lisp
> (arithmetic-lexer "5+7")
'(("5" int) ("+" operator) ("7" int))
```
### Example 2: Binary operation with variable and spaces
``` lisp
> (arithmetic-lexer "3 + PI")
'(("3" int) ("+" operator) ("PI" variable))
```
### Example 3: Complex operation with real numbers and multiple operators
``` lisp
> (arithmetic-lexer "a = 2^(3.2 * b)")
''(("a" variable)
  ("=" operator)
  ("2" int)
  ("^" operator)
  ("(" parenthesis)
  ("3.2" float)
  ("*" operator)
  ("b" variable)
  (")" parenthesis))
```

