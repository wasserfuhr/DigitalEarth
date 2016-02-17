(fn[rq rs](do (.setContentType rs"image/jpg")
 (slurp(str"/home/rawa/SpaceDrive/1220"(.getParameter rq"h")".jpg"))))