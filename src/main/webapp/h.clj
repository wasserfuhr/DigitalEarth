(fn[rq rs](do(.setContentType rs"image/jpg")
 (clojure.java.io/copy(java.io.File.(str"/home/rawa/SpaceDrive/1220"(.getParameter rq"h")".3gp"))
  (.getOutputStream rs))))