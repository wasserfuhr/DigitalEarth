(fn[rq rs]
 (let[sh(fn[h](slurp(str"http://127.0.0.1:8080/RootHandler.jsp?p=sh&s="h)))
   h(fn[x](slurp(str"/home/rawa/SpaceDrive/1220"x".html")))]
  (str"At AlphaLabs we "(subs(h(sh"ee"))0x35a 0x406)":")))