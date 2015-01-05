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
    [:p "your current: " (.substring (str sc "       ") 0 6) "..."]
    [:p "cook a new one:"]
    [:a#st {:href "http://time.sl4.eu/"}]
    [:form {:method "POST"}
     [:table
      [:tr
       [:th "UserAgent:"]
       [:td (.getHeader rq "User-Agent")]]
      [:tr
       [:th "WebDevice:"]
       [:td [:input {:name "WebDevice"}]]]
      [:tr
       [:th "OsUser:"]
       [:td [:input {:name "OsUser"}]]]
      [:tr
       [:th "WidthHeight:"]
       [:td#xy]]
      [:tr
       [:th "WebBrowser:"]
       [:td
        [:select
         (map (fn [b] [:option {:name b} b])
          ["AnDroidBrowser" "FireFox" "MsIe" "NewBrowser"])]]]
      [:tr
       [:th "FirstIpAddress:"]
       [:td (.getRemoteHost rq)]]
      [:tr
       [:th "GloPeCo:"]
       [:td [:input {:name "GloPeCo"}]]]
      [:tr
       [:th "YourSecret:"]
       [:td [:input {:type "password" :name "secret"}]]]]]
     [:script "
//http://stackoverflow.com/questions/3437786/get-the-size-of-the-screen-current-web-page-and-browser-window
var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    x = w.innerWidth || e.clientWidth || g.clientWidth,
    y = w.innerHeight|| e.clientHeight|| g.clientHeight;
d.getElementById('xy').innerHTML=x+'x'+y;"]

]]))))