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
     [:title "RealFilm « NooSphere"]
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
    [:canvas#c {:width 640 :height 480}]
    [:br]
    [:input {:value "-" :type "button" :onclick "rota(2,-15)"}]
    [:input {:value "+" :type "button" :onclick "rota(2,15)"}]
    [:script {:src "http://cosinekitty.com/astronomy.js"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');

var start=new Date().getTime();

var w=640*2;
var h=180*2;
c.width=w;
c.height=h;
var maxMarsAu=1.7;
function tick() {
 ctx.fillRect(0,0,w,h);
 ctx.setTransform(1,0,0,1,0,0);
 var p=(new Date().getTime()-start)/1000;
 d=Astronomy.Mars.EclipticCartesianCoordinates(p);
 ctx.arc(w/2+d.x,h/2+d.y,4,0,2*Math.PI);
 for(i=0;i<255;i++) {
  ctx.beginPath();
  ctx.strokeStyle='rgb('+i+','+i+','+i+')';
  ctx.arc(w/2,h/2,50,i/50,i/50+0.1);
  ctx.stroke();
 }
 ctx.fillStyle='#111';
 ctx.fillStyle='orange';
}
setInterval(tick,1000);
tick();
"]]]))))