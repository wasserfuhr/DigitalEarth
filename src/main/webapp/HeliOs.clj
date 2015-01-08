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
    [:input#labels {:type "checkbox"}] "show labels"
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

function drawPlanet(planet,period,color) {
 var b=100;
 for(i=0;i<255;i++) {
  var d1=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-i*period*120000000)));
  var d2=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-(i-1)*period*120000000)));
  ctx.beginPath();
  var j=255-i;
  ctx.strokeStyle='rgb('+j+','+j+','+j+')';
//  ctx.strokeStyle='#fff';
  ctx.moveTo(w/2+d1.x*b,h/2-d1.y*b);
  ctx.lineTo(w/2+d2.x*b,h/2-d2.y*b);
  ctx.stroke();
 }
 var d=planet.EclipticCartesianCoordinates(Astronomy.DayValue(p));
 ctx.beginPath();
 ctx.fillStyle=color;
 ctx.arc(w/2+d.x*b,h/2-d.y*b,4,0,2*Math.PI);
 ctx.fill();
 if (document.getElementById('labels').checked) {
  ctx.textAlign='center';
  ctx.font='10px Courier New';
  ctx.fillText(planet.Name,w/2+d.x*b,h/2-d.y*b-6);
 }
}

var p=new Date();
var speed=(1<<24)*4;
var fps=8;

function tick() {
 ctx.fillStyle='#111';
 ctx.fillRect(0,0,w,h);
 ctx.setTransform(1,0,0,1,0,0);
 p=new Date(p.getTime()+speed);
 ctx.beginPath();
 ctx.fillStyle='yellow';
 ctx.arc(w/2,h/2,8,0,2*Math.PI);
 ctx.fill();
 ctx.lineWidth=0.5;
 //http://en.wikipedia.org/wiki/Orbital_period#Relation_between_the_sidereal_and_synodic_periods
 drawPlanet(Astronomy.Mercury,0.240846,'yellow');
 drawPlanet(Astronomy.Venus,0.615,'green');
 drawPlanet(Astronomy.Earth,1,'blue');
 drawPlanet(Astronomy.Mars,1.881,'red');
 var t16=Math.floor(p.getTime()/1000).toString(16).substring(0,4)+'....';
 ctx.font='16px Courier New';
 ctx.textAlign='left';
 ctx.fillStyle='#0f0';
 ctx.fillText('st'+t16,20,20);
}

setInterval(tick,1000/fps);
tick();
"]]]))))