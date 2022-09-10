;;; Multithreaded Quicksort
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

(defun quick-sort (a &OPTIONAL (lo 0) (hi (- (LENGTH a) 1)))
  (if (< lo hi)
      (let ((p (partition a lo hi))
	    (t1 (new-thread
		 (lambda () 	(quick-sort a lo     (- p 1)))))
	    (t2 (new-thread
		 (lambda () 	(quick-sort a (+ p 1) hi)))))
	(. t1 "start()")
	(. t2 "start()")
	(. t1 "join()")
	(. t2 "join()")))
  a)

(let ((data (random-list 32 100)))
  (println "Quick sort in:  " data)
  (quick-sort data)
  (println "Quick sort out: " data))
