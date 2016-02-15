(fn[rq rs]
 (str"var as=["(apply str
  (map(fn[l](str "'"l"',"))
   (drop 2 (reverse (.split(slurp"https://dresdenlabs.appspot.com/raw/17776001")"\r\n")))))"];"))