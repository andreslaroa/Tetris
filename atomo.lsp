(defun atomo (var)
	(cond ((atom var) T)
		((eq (first var) '?) T)
		(T NIL)
	)
)
