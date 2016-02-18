(fn[rq rs](let[c(.getAttribute rq"c")](hiccup.core/html"<!DOCTYPE html>"[:html[:head
 [:title"ImageSet571"]
 [:link{:rel"stylesheet":type"text/css":href"http://sl4.eu/css"}]
 [:style"#v{font-family:monospace;font-size:200%;text-align:center}"]]
[:body
 (map-indexed(fn[i h]
[:img{:src(str"/RootHandler.jsp?p=img&h="h):width"10%"}])
;  (.split
(clojure.string/split-lines ((:h c)((:sh c)"2d")))
;"0082ac9151c78f2075911cabf6806dbdc46406c025c05d1cee8a970992a82ebf 8303821ae54e0cea12a478b812683365dee16b354d75ca0972a720a036b9effb 
;0ab6ab0adbb907671387065b121e7e91c21f64a19633f4db5947ddb37a04cf43 885c22c26daa2cdafa57e0a6782c92d03b96a17586b1005f6641a1302e503e20
;0fc46289b0f420e9cfbee76d5779774fc5eba361d945162511dd0eaa112f6abb 8dfa0b415ea4bbfd73a2b283b8c5d4ebaba8e6ae40c5b9c077d22231e7ad8aba" " ")
)]])))