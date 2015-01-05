(fn [rq rs]
 (let [
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))]
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:title "SemperCookie « NooSphere"]
     [:meta {:http-equiv "Content-type" :content "text/html; charset=utf-8"}]
     [:style {:type "text/css"} "
body {
 background: #000;
 color: #0f0;
 font-family: monospace;
}
a {
 color: #0f0;
}"]]
   [:body {:style "text-align:center"}
    [:h1 "SemperCookie"]
    [:a#st {:href "http://time.sl4.eu/"}]
    [:form {:method "POST"}
     "FirstIpAddress: " (.getRemoteHost rq)
     [:br]
     "UserAgent: " (.getHeader rq "User-Agent")
     [:br]
     "GloPeCo: " [:input {:name "GloPeCo"}]
     [:br]
     "YourSecret: " [:input {:type "password" :name "secret"}]]
]]))))