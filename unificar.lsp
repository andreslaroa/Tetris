(defun unificar (e1 e2)
  (when (or (atomo e1) (atomo e2))  ; Si alguno de los dos es átomo
    (cond
      ((equal e1 e2) (return-from unificar nil))  ; Comprobamos si son iguales
      ((or (and (null e1) (not (null e2))) 
           (and (not (null e1)) (null e2))) 
       (return-from unificar 'F))  ; Si alguno de los dos es nulo
      ((and (esvariable e1) (atomo e1)) 
       (return-from unificar (aparece e1 e2))) ; Si e1 es una variable 
      ((and (esvariable e2) (atomo e2)) 
       (return-from unificar (crealista e2 e1)))  ; Si e2 es una variable
      (t (return-from unificar 'F))  ; Si e1 y e2 son constantes fallo
    )  ; Fin del cond
  )  ; Fin del when

  ;; Si ambos son listas, pasa directamente aquí
  (setf f1 (first e1))
  (setf f2 (first e2))
  (setf t1 (rest e1))
  (setf t2 (rest e2))

  ;; Para depuración: imprime las partes de las listas
  ;(print 'f1)
  ;(print f1)
  ;(print 'f2)
  ;(print f2)
  ;(print 't1)
  ;(print t1)
  ;(print 't2)
  ;(print t2)

  ;; Utiliza prog para manejar el estado de z1 y z2 sin pisar valores
  (prog ((z1 nil) (z2 nil))  ;; Declara z1 y z2 como variables locales
    ;; Llama recursivamente a unificar con los primeros elementos
    (setf z1 (unificar f1 f2))  ;; Almacena el resultado de la unificación
    ;; Si z1 es 'F, termina y retorna 'F
    (if (equal z1 'F)
        (return-from unificar z1))

    ;; Realiza sustituciones en las colas de las listas
    (setf g1 (sustitucion z1 t1))
    (setf g2 (sustitucion z1 t2))

    ;; Imprime el resultado de las sustituciones para depuración
    ;(print 'g1)
    ;(print g1)
    ;(print 'g2)
    ;(print g2)

    ;; Llama a unificar nuevamente con los resultados de las sustituciones
    (setf z2 (unificar g1 g2))  ;; Almacena el resultado de la segunda unificación
    ;; Imprime z1 y z2 para depuración
    ;(print 'z1)
    ;(print z1)
    ;(print 'z2)
    ;(print z2)

    ;; Si z2 es 'F, retorna 'F
    (if (equal z2 'F)
        (return-from unificar z2))

    ;; Retorna la composición de z1 y z2
    (return-from unificar (composicion z1 z2))))