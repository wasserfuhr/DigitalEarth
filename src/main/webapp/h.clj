(fn[rq rs](do(let[h(.getParameter rq"h")](.setContentType rs"image/jpg")
 (clojure.java.io/copy(java.io.File.(str"/home/rawa/SpaceDrive/1220"h(if (.startsWith h"a3")".mp3"".3gp")))
  (.getOutputStream rs)))))