(fn [rq rs]
 (let [
   sl 16
   bls (bit-shift-left 1 sl)
   hash
    (fn [msg] ; https://gist.github.com/kisom/1698245
     (let [h (java.security.MessageDigest/getInstance "SHA-256")]
      (.update h msg)
      (.digest h)))
   p (java.nio.file.Paths/get "/home/rawa/TerraDrive/" (into-array String []))
   formatHash
    (fn [h]
     (apply str
      (map #(format "%02x" (bit-and % 0xff)) h)))
   ;386edd6afdeb28827661d0f5419cbbf96a9db627a6f73ee2308629053112b644
   h "b75876be5d725e220908d7bb6ffd267014b55c88"
   pl (.iterator (java.nio.file.Files/newDirectoryStream p (str h ".*")))
   first (.next pl)
   f (.toFile first)
   l (.length f)
   l1 (bit-shift-right (+ l 1) 1)
   l2 (- l l1)
r (java.io.RandomAccessFile. f "r")
b1 (byte-array l1)
b2 (byte-array l2)
]
  (do
   (.read r b1)
   (.read r b2)
   (if (.hasNext pl)
    "*Duplicate*!!"
    (str l1 " " l2 " " 
     (formatHash (hash b1)) " "
     (formatHash (hash b2))
)))))