;;; Quicksort
(defun swap (a i j)
  "swap two elements in an indexable sequence"
  (let ((tmp (get a i)))
    (aset a i  (get a j))
    (aset a j tmp)))

(defun random-list (size maxr)
  "make list of length size of random number from 0 upto maxr"
  (map (lambda (x) (random maxr))
       (range 0 size)))

(defun partition (a lo hi)
  "partition part of an indexable sequence a"
  (let ((pivot (get a hi))
        (i lo)
        (j lo))
    (while (< j hi)
     (if (< (get a j) pivot)
         (progn 
          (swap a i j)
          (setv i (+ i 1))))
     (setv j (+ j 1)))
    (swap a i hi)
    i))  

(defun quick-sort (a &OPTIONAL (lo 0) (hi (- (length a) 1)))
  "quick sort an indexable sequence or part of it if lo and hi parameters are set"
  (if (< lo hi)
      (let ((p (partition a lo hi)))
       (quick-sort a lo      (- p 1))
       (quick-sort a (+ p 1) hi)))
  a)

(let ((samples (list (random-list 32 100) ; list of random integers
		     ;; array of random integers
		     (append (make-array 0) (random-list 32 100)) 
		     ;; StringBuffer
		     (.N "StringBuffer" '("Hello people! How do you do?")) 
		     ;; list of Characters
		     (append () "Hello people! How do you do?")
		     ;; semantic versions
		     (map #'version '("0.1.2" "0.1.2-pre1" "0.1.2-pre2" "0.1.3" "0.1.2-pre1+10" "1.2.3")))))   
  (foreach (sample samples)
	   (println "Using quick sort on:  " (type-of sample))
	   (println "input:  " sample)
	   (quick-sort sample)
	   (println "output: " sample)
	   (println)))


