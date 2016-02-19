(fn[rq rs](let[c(.getAttribute rq"c")](hiccup.core/html"<!DOCTYPE html>"[:html[:head
 [:title"ImageSet571 &laquo; &alpha;"]
 [:link{:rel"stylesheet":type"text/css":href"http://sl4.eu/css"}]
 [:style"body{border:0;font-family:monospace;color:#fff;font-size:50%}div{float:left;margin-bottom:4px}"]]
[:body
 (map(fn[h][:div(subs h 0 4)[:br][:img{:src(str"/RootHandler.jsp?p=img&h="h):width"64px"}]])
  (clojure.string/split-lines ((:h c)((:sh c)"2d"))))]])))