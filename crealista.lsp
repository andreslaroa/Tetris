(defun crealista (e1 e2)
  ;; Usamos append para construir la lista con dos sublistas
  (append (append '() (list e2)) (append '() (list e1))))