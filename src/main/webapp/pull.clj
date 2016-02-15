(fn[rq rs]
;(str"var as=["
 (apply str
  ;(map(fn[l](str "'"l"',"))
   (filter #(.startsWith % "p:")(.split(slurp"https://dresdenlabs.appspot.com/raw/22086002")"\r\n"))))