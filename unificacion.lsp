(defun empezar (e1 e2)
    (prog (e1 e2 sust)
        (setf sust '())
        (return (unificar (e1 e2 sust)))
    )
)

(defun unificar (e1 e2 sust)
    (prog (e1 e2 f1 f2 t1 t2)
        (when (or (atomo e1)(atomo e2)) ;Si alguno de los dos es átomo
            (cond
            ((equal e1 e2) sust) ;Comprobamos si son iguales
            ((or(and (null e1)(not(null e2)))(and (not(null e1))(null e2))) 'F) ;Si alguno de los dos es nulos
            ((and(esvariable e1)(atomo e1)) miembro e1 e2) ;Si e1 es una variable 
            ((and(esvariable e2)(atomo e2)) anadir e2 e1) ;Si e2 es una variable
            ((and (eq (length e1) 1) (eq (length e2) 1))) ;Si e1 y e2 son constantes fallo
            ) ;Si salimos de este bloque sin ninguna respuesta es porque son listas))
        )
        ;Si los dos son listas pasa directamente aquí
        (setf f1 (first e1))
        (setf f2 (first e2))
        (setf t1 (rest e1))
        (setf t2 (rest e2))
        (setf z1 (unificar f1 f2 sust))
        (return ((eq z1 'F) 'F))
        (setf g1 (sustitucion z1 t1))
        (setf g2 (sustitucion z1 t2))
        (setf z2 (unificar g1 g2))
        (return ((eq z2 'F) 'F))
        (return (composicion z1 z2))
    )
)
