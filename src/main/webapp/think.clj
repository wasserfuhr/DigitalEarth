(fn[rq rs]
 (let[sh(fn[h](slurp(str"http://127.0.0.1:8080/RootHandler.jsp?p=sh&s="h)))]
  (str"At AlphaLabs we "(subs
  (slurp (str"/home/rawa/SpaceDrive/1220"(sh"ee")".html"))0x35a 0x406)":")))