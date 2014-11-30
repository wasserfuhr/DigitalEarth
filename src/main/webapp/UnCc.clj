(fn [rq rs]
 (let [
   reg #"[A-Z]+[a-z]+[A-Z]+[a-zA-Z0-9]*"
   f (java.io.File. "/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/unpartei/mainSpace/")]
  (apply str 
   (map
    (fn [l]
     (let [
       fl (re-find reg l)
       tag (first fl)]
      (str (if (and (not-empty fl) (== (.length fl) (.length l))) "+" "--") l " ")))
    (.list f)))))
