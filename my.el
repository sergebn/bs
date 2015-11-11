(defun append-to-buffer (buffer start end)
  "Добавить к заданному буферу текст в регионе.
Текст вставляется в буфер перед точкой.

При вызове принимает три аргумента:
буфер или его имя, и два числа задающие регион в
текущем буфере."
  (interactive "BAppend to buffer: \nr")
  (let ((oldbuf (current-buffer)))
    (save-excursion
      (set-buffer (get-buffer-create buffer))
      (insert-buffer-substring oldbuf start end))))

(current-buffer (set-buffer (get-buffer-create "my2.el")) (insert "dddd"))

(defun newpy () ; определить функцию newpy
  "Create new python document" ; комментарий
  (interactive) ; работать интерактивно
  ; вставить строки
  (insert "#!/usr/bin/env python
 # -*- coding: utf-8 -*-")
  )
#!/usr/bin/env python
 # -*- coding: utf-8 -*-

(with-temp-buffer
  (insert "string")
  ;; manipulate the string here
  (buffer-string) ; get result
  )
((set-buffer "my.el")
  (insert "string")
  ;; manipulate the string here
  (buffer-string) ; get result
)
