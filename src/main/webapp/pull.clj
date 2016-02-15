(fn[rq rs]
 (let[r(.getParameter rq"r")
   l(if r r"ld42a9")
   b"https://dresdenlabs.appspot.com/"
   h(slurp(str b"head?f="l))
   f(str(.getParameter rq"f")":")]
  (apply str
   (map #(str % "\n")
    (filter #(.startsWith % f)(.split(slurp(str b"raw/"h"?f="f))"\r\n"))))))