(fn[rq rs](let[s(.getParameter rq"s")](clojure.string/replace(first
 (filter(fn[l](= s(first(.split l" "))))
  (clojure.string/split-lines(slurp"/home/rawa/git/AllHashes/ShortHash.txt"))))" """)))