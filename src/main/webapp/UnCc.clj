(fn [rq rs]
 (let [
   f (java.io.File. "/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/unpartei/mainSpace/")]
  (apply str 
   (map (fn [l] (str l " "))
    (.list f)))))
