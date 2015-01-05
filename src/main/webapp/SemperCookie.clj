(fn [rq rs]
 (let [
   sc (apply str (map (fn [c] (if (.equals "SemperCookie" (.getName c)) (.getValue c))) (.getCookies rq)))
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
}
th {
 text-align: left;
}
"]]
   [:body {:style "text-align:center"}
    [:h1 "SemperCookie"]
    [:p "your current: " sc]
    [:p "cook a new one:"]
    [:a#st {:href "http://time.sl4.eu/"}]
    [:form {:method "POST"}
     [:table
      [:tr
       [:th "UserAgent:"]
       [:td (.getHeader rq "User-Agent")]]
      [:tr
       [:td "FirstIpAddress:"]
       [:td (.getRemoteHost rq)]]
      [:tr
       [:td "GloPeCo:"]
       [:td [:input {:name "GloPeCo"}]]]
      [:tr
       [:td "YourSecret:"]
       [:td [:input {:type "password" :name "secret"}]]]]]
]]))))