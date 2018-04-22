# differences
implementing this project in scheme presents some challenges since the language is slightly different than the one used in the research papers.
for the most part, this follows the syntax in the research papers as closely as possible, however some syntax has changed since 1976:

* `t -> #t`
* `eq -> eq?`
* `numberp -> number?`
* `null -> null?`
* `atom -> atom?` (see note below)

also driver-loop takes a list of the primitive procedures as its first argument,
however a list of primitive procedures is not defined. Therefor it must be implemented at some point.

some other things to note:

1.) atom/atom? does not exist
Scheme doesn't have atom? because atom? isn't a standard Scheme procedure, Scheme doesn't have a data type of atoms.

instead could use: symbol?
or
possible work around:
`(define atom? (lambda (x) (not (pair? x))))`

2.) etc...

all the calls to `error` give warning: "The procedure #[compiled-procedure 13 ("error" #x6a) #x1a #x1b7bada] has been called with 0 arguments; it requires at least 1 argument.""

not sure what are:
* primop
* primop-apply
