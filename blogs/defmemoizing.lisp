
(defmacro defmemoizing (fn args &body body)
  (let ((storage (gensym))
        (answer (gensym))
        (present (gensym)))
    `(let ((,storage (make-hash-table)))
       (defun memoized-table ()
         (loop for key being the hash-keys of ,storage
               using (hash-value value)
               do (format t "~S => ~S~%" key value)))
       
       (defun ,fn ,args
         (multiple-value-bind (,answer ,present) (gethash ',args ,storage)
           (if ,present ,answer
             (multiple-value-bind ,answer (progn
                                            ,@body)
               (setf (gethash ',args ,storage) ,answer))))))))
