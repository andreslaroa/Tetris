;;---------------FUNCIÓN UNIFICAR--------------

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


    ;; Llama a unificar nuevamente con los resultados de las sustituciones
    (setf z2 (unificar g1 g2))  ;; Almacena el resultado de la segunda unificación

    ;; Si z2 es 'F, retorna 'F
    (if (equal z2 'F)
        (return-from unificar z2))

    ;; Retorna la composición de z1 y z2
    (return-from unificar (composicion z1 z2))))



;;---------------FUNCIÓN APARECE--------------

(defun aparece (e1 e2)   
  (cond
    ((listp e2)
      (dolist (var e2)
      (cond
        ;; Si encontramos una coincidencia directa con el patrón
        ((equal e1 var) (return-from aparece 'F))  ;; Devolver 'F si encontramos e1

        ;; Si el elemento es una lista, llamamos recursivamente
        ((listp var)
         (when (equal (aparece e1 var) 'F) ;; Llamada recursiva a `aparece`
           (return-from aparece 'F)))))  ;; Devolver 'F si se encuentra en la sublista
    )
    ((not(listp e2)) 
      (setf e2 (list e2))
    )
  )
  ;; Si no encontramos coincidencias, devolvemos (append e2 (list e1))
  (crealista e1 e2))


;;---------------FUNCIÓN CREALISTA--------------

(defun crealista (e2 e1)
  (list (list e1 e2))
)
  



;;---------------FUNCIÓN ATOMO--------------

(defun atomo (var) 
  (cond ((atom var) T) 
    ((eq (first var) '?) T) 
    (T NIL)
  )
)



;;---------------FUNCIÓN ESVARIABLE--------------

(defun esvariable (var)
    (if (and(listp var)(eq (first var) '?))
      (return-from esvariable T)
      (return-from esvariable NIL)
    )
)




;;---------------FUNCIÓN COMPOSICION--------------

(defun composicion (lista1 lista2)
  (prog (resultado encontrado sublista1 sublista2)
    ;; Si una de las listas es nil, devolvemos la otra
    (cond
      ((null lista1) (return lista2))
      ((null lista2) (return lista1)))  

    (setf resultado '())  ;; Inicializamos la lista vacía `resultado`

    ;; Recorremos lista1
    (dolist (sublista1 lista1)
      (setf encontrado nil)  ;; Reiniciamos `encontrado` en cada iteración
      ;; Recorremos lista2 buscando coincidencias en el segundo elemento
      (dolist (sublista2 lista2)
        (when (equal (last sublista1) (last sublista2))
          (setf encontrado t)))  ;; Marcamos como encontrado si hay coincidencia

      ;; Si se encuentra coincidencia, añadimos la sublista de lista1
      (setf resultado (append resultado (list sublista1))))

    ;; Ahora recorremos lista2
    (dolist (sublista2 lista2)
      (setf encontrado nil)  ;; Reiniciamos `encontrado` para cada sublista de `lista2`
      ;; Comparamos con cada sublista de `lista1`
      (dolist (sublista1 lista1)
        (when (equal (last sublista1) (last sublista2))
          (setf encontrado t)))  ;; Si encontramos coincidencia, no añadimos

      ;; Si no encontramos coincidencia, añadimos la sublista de `lista2`
      (when (not encontrado)
        (setf resultado (append resultado (list sublista2)))))

    ;; Devolvemos el resultado final
    (return resultado)))





;;---------------FUNCIÓN SUSTITUCION--------------

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



