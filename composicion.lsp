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
        (when (equal (second sublista1) (second sublista2))
          (setf encontrado t)))  ;; Si encontramos coincidencia, no añadimos

      ;; Si no encontramos coincidencia, añadimos la sublista de `lista2`
      (when (not encontrado)
        (setf resultado (append resultado (list sublista2)))))

    ;; Devolvemos el resultado final
    (return resultado)))