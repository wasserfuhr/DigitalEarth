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
     [:title "SuperWiki « SemperBase"]
     [:meta {:name "viewport" :content "width=240"}]
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
   [:body
    "/" [:br]
    [:div {:style "text-align:center"}
     [:input {:style "font-size:10pt; font-family:monospace"}] [:br]
     [:input {:style "font-size:10pt; font-family:monospace"}] [:br]
     [:textarea {:style "font-size:10pt; font-family:monospace" :rows 8 :cols 35}
"//23456789abcdef 123456789abcdef

e=2.17828;
pi=3.14159;
d?"]
     [:canvas#c {:width 200 :height 80}]
     [:br]
     [:a#st {:href "http://time.sl4.eu/"}]
    [:script "
var ctx=document.getElementById('c').getContext('2d');

var p=3;
var l=20;

function tick() {
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.fillStyle='#0f0';
 var now=new Date();
 var t0=Math.floor(now.getTime()/1000);
 var t16=t0.toString(16);
 document.getElementById('st').innerHTML='st'+t16;
}

setInterval(tick,1000);
"]]]]))))