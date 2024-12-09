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

(defun crealista (e2 e1)
  (list (list e1 e2))
)
