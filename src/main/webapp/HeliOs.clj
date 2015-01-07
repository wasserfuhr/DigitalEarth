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
     [:title "HeliOs « NooSphere"]
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

function drawPlanet(planet,color) {
 var b=100;
 for(i=0;i<255;i++) {
  var d1=planet.EclipticCartesianCoordinates(p-i);
  var d2=planet.EclipticCartesianCoordinates(p-i-1);
  ctx.beginPath();
  var j=255-i;
  ctx.strokeStyle='rgb('+j+','+j+','+j+')';
  ctx.moveTo(w/2+d1.x*b,h/2-d1.y*b);
  ctx.lineTo(w/2+d2.x*b,h/2-d2.y*b);
  ctx.stroke();
 }
 var d=planet.EclipticCartesianCoordinates(p);
 ctx.beginPath();
 ctx.fillStyle=color;
 ctx.arc(w/2+d.x*b,h/2-d.y*b,4,0,2*Math.PI);
 ctx.fill();
 ctx.textAlign='center';
 ctx.fillText(planet.Name,w/2+d.x*b,h/2-d.y*b-6);
}
var p;

function tick() {
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,w,h);
 ctx.setTransform(1,0,0,1,0,0);
 p=(new Date().getTime()-start)/100;
 ctx.beginPath();
 ctx.fillStyle='yellow';
 ctx.arc(w/2,h/2,8,0,2*Math.PI);
 ctx.fill();
 drawPlanet(Astronomy.Mercury,'yellow');
 drawPlanet(Astronomy.Venus,'green');
 drawPlanet(Astronomy.Earth,'blue');
 drawPlanet(Astronomy.Mars,'red');
}

setInterval(tick,125/4);
tick();
"]]]))))