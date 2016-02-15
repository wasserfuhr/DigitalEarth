(fn[rq rs]
 (do
  (.setCharacterEncoding rs "UTF-8")
  (hiccup.core/html "<!DOCTYPE html>" [:html
[:body
 [:canvas#c]
[:table[:tr[:td[:input{:type "checkbox"}]]]]
]
 ])))