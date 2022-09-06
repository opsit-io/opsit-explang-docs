;;; prints sorted frequency table for a sequence
(defun freqcount(seq)
  ;; create map of counters
  (let ((m (hashmap)))
    ;; for each  word in text that matches pattern
    (foreach (word  seq)
	     ;;; lowercase word
             (assoc! m word
		       (+ 1 (get m word))))
    ;; sort list of Map Entries by their values
    (sort (lambda (a b)
	    (- (get b "value")
	       (get a "value")))
	  ;;; get Map.Entries into list
	  (append () m))))

(let ((txt "If in this heart a hope be dear,
            ⁠That sound shall charm it forth again:
            If in these eyes there lurk a tear,
            ⁠'Twill flow, and cease to burn my brain")
      (numbers (map (lambda (x) (random 100))
		    (make-array 10 :element-type "int"))))
  (print (str "Word frequency table for text\n"  txt "\n"
	      (freqcount
	       (map #'lowercase
		    (append () (re-seq
				(re-pattern "\\w+") txt))))
	      "\n\n"))
	 
  (print (str "Character frequency table for text\n"  txt "\n"
	      (freqcount txt )
	      "\n\n"))
  (print (str "Frequency table for array of numbers\n"  numbers "\n"
	      (freqcount numbers )
	      "\n\n")))


