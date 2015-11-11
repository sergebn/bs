(+ 1 2 (+ 3 4))
fill-column
 	

(message "Он увидел %d %s"
         (- fill-column 34)
         (concat "рыжих " "прыгающих "
                 (substring
                  "Шустрые, лисицы весело прыгали." 9 14)))

(set-buffer (get-buffer-create "my.el"))

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
(set-buffer (get-buffer-create "my1.el"))
(insert "i ♥ u")

(defun newtex()
  "Get data from the file ex.tex"
  (interactive)
    ; вставить данные из файла com_templ.xml
    (insert-file-contents "com_templ.xml")
    ; разделить строки
    (split-string (buffer-string) "\n" t))
;; idiom for string replacement in current buffer;

(let ((case-fold-search t)) ; or nil

  (goto-char (point-min))
  (while (search-forward "myStr1" nil t) (replace-match "myReplaceStr1"))

  (goto-char (point-min))
  (while (search-forward "myStr2" nil t) (replace-match "myReplaceStr2"))

  ;; repeat for other string pairs
)

;; if you need regexp, use search-forward-regexp

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
