(fn [rq rs]
 (let [
   sl 16
   bls (bit-shift-left 1 sl)
   p (java.nio.file.Paths/get "/home/rawa/TerraDrive/" (into-array String []))
   h "b75876be5d725e220908d7bb6ffd267014b55c88"
   pl (.iterator (java.nio.file.Files/newDirectoryStream p (str h ".*")))
   first (.next pl)
   f (.toFile first)
   l 15;(.length f)
   l1 (bit-shift-right (+ l 1) 1)
   l2 (- l l1)
]
  (if (.hasNext pl)
   "*Duplicate*!!"
   (str l1 " " l2))))