(+ 1 2 (+ 3 4))
fill-column
 	

(message "Он увидел %d %s"
         (- fill-column 34)
         (concat "рыжих " "прыгающих "
                 (substring
                  "Шустрые, лисицы весело прыгали." 9 14)))

	

(buffer-name)

(buffer-file-name)
(current-buffer)
(buffer-size) 	

(point)

(defun on2 ( n )
"Удвоить число"
(interactive "nNumber:")
      (message "res: %d" (* 2 n))
)
(on2)


(defun foo2 (n)             ; foo2 takes one argument,
    (interactive "^p")      ;   which is the numeric prefix.
                            ; under shift-select-mode,
                            ;   will activate or extend region.
    (forward-word (* 2 n)))

(foo2 1)

	

(defun умножить-на-семь (number)       ; Интерактивная версия.
  "Умножить NUMBER на семь."
  (interactive "p")
  (message "Итог %d" (* 7 number)))

(умножить-на-семь 3)

(defun foo3 (n)             ; foo3 takes one argument,
    (interactive "nCount:") ;   which is read with the Minibuffer.
    (forward-word (* 2 n)))
     
(foo3)
(interactive
 (let ((string (read-string "Foo: " nil 'my-history)))
   (list (region-beginning) (region-end) string)))

(interactive
 (list (region-beginning) (region-end)
       (read-string "Foo: " nil 'my-history)))
