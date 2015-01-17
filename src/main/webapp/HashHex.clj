(fn [rq rs]
 (let [
   unhexify
    (fn [s]
     (into-array Byte/TYPE
      (map
       (fn [[x y]]
        (unchecked-byte (Integer/parseInt (str x y) 16)))
       (partition 2 s))))
  formatHash
   (fn [hash]
    (apply str
     (map #(format "%02x" (bit-and % 0xff))
      hash)))
  db (.getAttribute rq "db")
  h (.getParameter rq "hash")
  st (.prepare db "SELECT parent,createdAt,createdBy,session,tag,scriptSize,script FROM a2 where id=?")]
 (do
  (.bind st 1 (unhexify h))
  (.step st)
  (str "\"" (formatHash
   (.getBytes
    (str
     (.columnLong st 1) " "
     (.columnLong st 2) " "
     (.columnLong st 3) " "
     (.columnString st 4) " "
     (.columnLong st 5) " "
     (.columnString st 6))))"\""))))