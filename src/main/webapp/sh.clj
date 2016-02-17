(fn[rq rs]
 (let[s(.getParameter rq"s")]
  (first (filter (fn[l](= s(first (.split l" "))))

 (clojure.string/split-lines (slurp"/home/rawa/git/AllHashes/ShortHash.txt"))))))
;(slurp
;(str "/home/rawa/SpaceDrive/1220"
;"eefd82ec2863d0733ce9c823c8bd18bfdfd59bd6073efa9eec5abd96c330c127"
;".html")