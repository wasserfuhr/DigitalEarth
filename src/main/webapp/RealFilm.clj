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
    [:canvas#c {:width 320 :height 240}]
    [:br]
    [:a#st {:href "http://film.sl4.eu/"}]
    [:script "
var ctx=document.getElementById('c').getContext('2d');

function tick() {
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.fillStyle='#0f0';
 var now=new Date();
 var t0=Math.floor((2038-1970)*365*24*60*60-now.getTime()/1000);
 var t16=t0.toString(16);
 ctx.textAlign='center';
 ctx.textBaseline='middle';
 ctx.font='bold 64px Courier';
 ctx.fillText(t16,160,120);
 // ctx.fillRect(512,0,1,512);

}

setInterval(tick,1000);
"]]]))))