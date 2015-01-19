(fn [rq rs]
 (let [
  formatHash
   (fn [hash]
    (apply str
     (map #(format "%02x" (bit-and % 0xff))
      hash)))
  db (.getAttribute rq "db")
  ;h (.getParameter rq "hash")
  st (.prepare db "SELECT id FROM a2")
  listHashes
   (fn [ct ret]
    (if 
     (or (> ct 2)
      (not (.step st)))
     ret
     (recur
      (+ ct 1)
      (str "\"" (formatHash (.columnBlob st 0)) "\",\n" ret))))
  h (listHashes 0 "")
]
 (str "[
\"063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e\"," (.substring h 0 (- (.length h) 2))
 ;(str "{\"a\":[" (.substring h 0 (- (.length h) 2))
 "]")))