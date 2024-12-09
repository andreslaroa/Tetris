(print "--------------------- Funcion composicion ---------------------")
	(setf func 'composicion)

	(print "----- Prueba 1 -----")
	(setf var1 '((g (? x) (? y)) / (? z)))
	(setf var2 '((A / (? x)) (B / (? y)) (C / (? w)) (D / (? z))))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '(((g (? y) A) / (? x)) (B / (? y)) ((f (? w))/ (? z))))
	(setf var2 '(((f (? b)) / (? y)) ((? u) / (? w)) (C / (? t))))
	(llamada2 func var1 var2)

	(print "--------------------- Funcion unificar ---------------------")
	(setf func 'unificar)

	(print "----- Prueba 1 -----")
	(setf var1 '(P (? x) (? y)))
	(setf var2 '(P (? y) (? x)))
	(llamada2 func var1 var2) 

	(print "----- Prueba 2 -----") 
	(setf var1 '(P (? x) (g (? z))))
	(setf var2 '(P (g (? y)) (? x)))
	(llamada2 func var1 var2)

	(print "----- Prueba 3 -----") 
	(setf var1 '(P (? x) (? x)))
	(setf var2 '(P A B))
	(llamada2 func var1 var2)



(defun sustitucion (z p)
  (if (equal z nil)
      (return-from sustitucion p))

  (setf sust '())  ;; Inicializamos la lista vacía `sust`

  (dolist (var1 p) ;; Iteramos sobre cada elemento de `p`
    (setf aux nil) ;; Reiniciamos `aux` para cada nuevo elemento de `p`
    
    ;; Iteramos sobre las sublistas de `z` para buscar coincidencias
    (dolist (var2 z)
      ;; Si encontramos una coincidencia entre el valor de `var1` y el segundo elemento de `var2`
      (when (equal var1 (second var2))
        (setf aux T)
        ;; Añadimos el primer elemento de la sublista `var2` a `sust`
        (setf sust (append sust (list (first var2))))))

    ;; Si `var1` es una lista y no es una variable, hacemos una llamada recursiva
    (when (and (not aux) (not (esvariable var1)) (listp var1))
      ;; Llamada recursiva a sustitucion para procesar la lista interna
      (setf sust (append sust (list (sustitucion z var1))))
      (setf aux T))  ;; Marcamos como procesado

    ;; Si no encontramos coincidencia y no se ha procesado mediante la recursividad, añadimos el valor original
    (when (null aux)
      (setf sust (append sust (list var1))))
    
    )

  ;; Devolvemos la lista resultante `sust`
  (return-from sustitucion sust))






(defun crealista (e2 e1)
  ;; Creamos una lista con dos sublistas, una con e1 y otra con e2
  (list (list e1 e2)))