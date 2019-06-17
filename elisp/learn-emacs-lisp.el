;; First make sure you read this text by Peter Norvig:
;; http://norvig.com/21-days.html

;; symbolic expressions ("sexps")
(+ 2 2) ;; C-x C-e evaluate in the mini-buffer
4       ;; C-j evaluate and print below


(+ 2 (+ 1 1))
4


(+ 3 (+ 1 2))
6

;; 'setq' stores a value into a variable
(setq my-name "Laurent")

;; 'insert' will insert "Hello World!" where the cursor is:
(insert "Hello World!")Hello World!

;; multiple arguments are allowed
(insert "Hello " "World!")Hello World!

;; with variables
(insert "Hello, I am " my-name)Hello, I am Laurent

;; you can combine sexps into functions
(defun hello () (insert "Hello, I am " my-name))

;; call the function
(hello)Hello, I am Laurent

;; with argument
(defun hello (name) (insert "Hello " name))

(hello "you")Hello you

;; switch to a new buffer named "*test*" in another window
(switch-to-buffer-other-window "*test*")

;; several sexps combination with 'progn'
(progn
  (switch-to-buffer-other-window "*test*")
  (hello "you"))

;; erase buffer
(progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello "there"))

;; go back to the other window
(progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello "you")
  (other-window 1))

;; bind a value to a local variable with 'let'
(let ((local-name "you"))
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello local-name)
  (other-window 1))


;; format strings
(format "Hello %s!\n%s\n%s" "World" "\tWelcome to Emacs!" "Emacs Lisp is fun!")

;; using format into our function
(defun hello (name)
  (insert (format "Hello %s!\n" name)))

(hello "World")Hello World!

;; let's use 'let' inside a function
(defun greeting (name)
  (let ((your-name "Stéphane"))
    (insert (format "Hello %s!\nI am %s."
		    name        ; the argument of the function
		    your-name   ; the let-bound variable "Stéphane"
		    ))))

;; evaluate it
(greeting my-name)Hello Laurent!
I am Stéphane.

;; some functions are interactive
(read-from-minibuffer "Enter your name: ")

;; let's save your name in a variable
(setq your-name (read-from-minibuffer "Enter your name: "))

;; let's use the variable with the hello function
(hello your-name)Hello Laurent!

;; let's improve our 'greeting' function
(defun greeting (from-name)
  (let ((your-name (read-from-minibuffer "Enter your name: ")))
    (insert (format "Hello!\nI am %s and you are %s."
		    from-name ; argument of the function
		    your-name ; the let-bound var, entered at prompt
		    ))))

(greeting "Laurent")Hello!
I am Laurent and you are Stéphane.

;; let's complete it by dysplaying the results in the other window
(defun greeting (from-name)
  (let ((your-name (read-from-minibuffer "Enter your name: " )))
    (switch-to-buffer-other-window "*test*")
    (erase-buffer)
    (insert (format "Hello!\nI am %s and you are %s." your-name from-name))
    (other-window 1)))

;; test
(greeting "Laurent")

;; if you want to create a literal list of data, use ' to stop it from
;; being evaluated
(setq list-of-names '("Laurent" "Stéphane" "Francis"))

;; get the first element with 'car'
(car list-of-names)

;; get a list of all but without the first element with  'cdr'
(cdr list-of-names)

;; add an element at the beginning
(push "Alice" list-of-names)

;; NOTE: 'car' and 'cdr' don't modify the list, but 'push' does

;; use 'hello' for each element
(mapcar 'hello list-of-names)Hello Alice!
Hello Laurent!
Hello Stéphane!
Hello Francis!

;; refine 'greeting' to say hello to everyone
(defun greeting ()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (mapcar 'hello list-of-names)
  (other-window 1))

(greeting)


(defun replace-hello-by-bonjour ()
  (switch-to-buffer-other-window "*test*")
  (goto-char (point-min))
  (while (search-forward "Hello")
    (replace-match "Bonjour"))
  (other-window 1))

(replace-hello-by-bonjour)

(defun hello-to-bonjour ()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  ;; say hello to names in 'list-of-names'
  (mapcar 'hello list-of-names)
  (goto-char (point-min))
  ;; replace "Hello" by "Bonjour"
  (while (search-forward "Hello" nil t)
    (replace-match "Bonjour"))
  (other-window 1))

(hello-to-bonjour)

;; let's boldify the names:
(defun boldify-names ()
  (switch-to-buffer-other-window "*test*")
  (goto-char (point-min))
  (while (re-search-forward "Bonjour \\(.+\\)!" nil t)
    (add-text-properties (match-beginning 1)
			 (match-end 1)
			 (list 'face 'bold)))
  (other-window 1))


(boldify-names)


;; If you want to know more about a variable or a function:
;;
;; C-h v a-variable RET
;; C-h f a-function RET
;;
;; To read the Emacs Lisp manual with Emacs:
;;
;; C-h i m elisp RET
;;
;; To read an online introduction to Emacs Lisp:
;; https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html




