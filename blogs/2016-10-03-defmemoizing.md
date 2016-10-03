% Memoization

[Memoization](https://en.wikipedia.org/wiki/Memoization) is a simple optimization trick.
The basic trick is that for an algorithm you store previously computed results in a table.
The input is the key; the result from the algorithm the output.
You only compute the result if you haven't calculated it before.

A simple implementation of it might look something like:

~~~~ lisp
(let ((results (make-hash-table)))
  (defun my-random (n)
    (multiple-value-bind (result found) (gethash n results)
      (if found
        result
        (let ((result (random n)))
          (setf (gethash n results) result)
          result)))))
~~~~

There is a fair bit of boilerplate just to do the memoization, and it obscures what the algorithm is.
But this is *lisp*. 
The biggest argument for lisp is that we can change the language with macros.
So lets define a version of function definition that automatically memoizes its program.

~~~~ lisp
(defmacro defmemoizing (fn args &body body)
  (let ((table (gensym "table"))
        (result (gensym "result"))
        (found (gensym "found"))
        (fn-table (intern (format nil "~:@(~a-table~)" `,fn))))
    `(let ((,table (make-hash-table :test #'equal)))
       (defun ,fn ,args
         (multiple-value-bind (,result ,found) (gethash (list ,@args) ,table)
           (if ,found
               ,result
             (progn
               (let ((,result (progn ,@body)))
                 (setf (gethash (list ,@args) ,table) ,result)
                 ,result)))))

       (defun ,fn-table ()
         ,table))))
~~~~

Not the most efficient thing in the world, but it works.
The macro defines two functions: the function we ask it to define, another that lets us into the closure and get at the table.
It has a few limitations, namely that I don't handle multiple values.

For examples of use:

~~~~ lisp
(defmemoizing my-memoized-random (n) (random n))

(defmemoizing factorial (n)
  (cond
   ((eql n 0) 1)
   ((eql n 1) 1)
   (t (* n (factorial (1- n))))))

(defmemoizing fib (n)
  (cond
   ((< n 2) 1)
   (t (+ (fib (1- n)) (fib (- n 2))))))

(defmemoizing factorial (n)
  (cond ((eql n 0) 1)
~~~~

Looks just like normal function definitions, right?

~~~~ lisp
* (my-memoized-random 10)
6
* (my-memoized-random 10)
6
* (my-memoized-random 10)
6
* (my-memoized-random 10)
6
~~~~

A-ha!  
Side effects are gone.
Since we don't bother to recompute the results, we never get another random number (for that input).

~~~~ lisp
* (fib 10)
89
* (loop for k being the hash-key
        using (hash-value v) of (fib-table) 
        do (format t "~a -> ~a~%" k v))
(1) -> 1
(0) -> 1
(2) -> 2
(3) -> 3
(4) -> 5
(5) -> 8
(6) -> 13
(7) -> 21
(8) -> 34
(9) -> 55
(10) -> 89
NIL
~~~~

For the recursive function we also got all the intermediate results saved.

I love this example.
It shows the power of lisp's macros.
I do not think you could do this sort of trick trivially in many other languages.
