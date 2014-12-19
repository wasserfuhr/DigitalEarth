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

var start=new Date().getTime();

var w=320;
var h=240;
function tick() {
 var p=(new Date().getTime()-start)/1000;
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 if (p<4) {
  fade=255;
 } else {
  fade=(10-p)*255/6;
 }
 ctx.fillStyle='rgb(0,'+Math.floor(fade)+',0)';
 //ctx.fillStyle='rgb(0,155,0)';
 var now=new Date();
 var t0=Math.floor((2038-1970)*365*24*60*60-now.getTime()/1000);
 var t16=t0.toString(16);
 ctx.textAlign='center';
 ctx.textBaseline='middle';
 ctx.font='bold 64px Courier';
 ctx.fillText(t16,160,120);
 ctx.fillStyle='#fff';
 if (p>4) {
  ctx.fillRect(w/4,h/3,(p-4)*w/2,1);
  ctx.fillRect(w/4,h/3, 1,(p-4)*w/2);
  ctx.fillRect(3*w/4-(p-4)*w/2,2*h/3,(p-4)*100,1);
  ctx.fillRect(3*w/4-(p-4)*w/2,2*h/3,1,(p-4)*100);
 }
 if (p>9) {
  ctx.font='bold 256px Serif';
  ctx.fillText('N',w/2,h/2);
 }
 if (p>12) {
  ctx.font='bold 32px Serif';
  ctx.fillText('NooSphere',w/2,h/2);
 }
}
setInterval(tick,100);
"]]]))))