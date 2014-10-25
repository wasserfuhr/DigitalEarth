(fn [rq rs rf]
 (let [
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))
   ;MagicWord:
   a (.readByte rf)
   acc (.readByte rf)]
  (if (and (== (byte 10) a) (== (byte 7) acc))
   (let [
     t (.readByte rf)]
    (if (== 1 t)
     (let [n 1]
      1)
     ;CuRe:
     (let [
       boot (.readLong rf)
       head (.readLong rf)
     x (byte-array 32)]
    (.seek rf boot)
    ;(.read rf x)
    (let [
      size (.readInt rf)
      sx (byte-array size)]
     (.read rf sx)
     ((eval (read-string (String. sx))) rq rs rf)))
    ;start reached!: (if (.equals "6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b" (formatHash x))
   "MagicWord mismatch!")))