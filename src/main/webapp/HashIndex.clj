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
     (or (> ct 100)
      (not (.step st)))
     ret
     (recur
      (+ ct 1)
      (str "\"" (formatHash (.columnBlob st 0)) "\",\n" ret))))
  h (listHashes 0 "")]
 (str "[" (.substring h 0 (- (.length h) 2)) "]")))