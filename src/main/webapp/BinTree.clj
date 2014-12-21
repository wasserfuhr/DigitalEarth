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
     [:title "HildeKommt « SemperBase"]
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
    [:canvas#c {:width 2048 :height 20}]
    [:br]
    [:a#st {:href "http://time.sl4.eu/"}]
    [:script "
var ctx=document.getElementById('c').getContext('2d');
ctx.fillStyle='#000';
ctx.fillRect(0,0,2048,512);
ctx.fillStyle='#0f0';
for (i=0;i<1024;i++) {
 for (j=0;j<10;j++) {
  if(i&(1<<(9-j))){
   ctx.fillRect(i*1,j*1,1,1);
  }
 }
}
"]]]))))