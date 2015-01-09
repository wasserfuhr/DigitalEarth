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

var w=400;
var h=400;
c.width=w;
c.height=h;
var maxMarsAu=1.7;
var b=4;

function drawPlanet(planet,period,color) {
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
  ctx.textBaseline='top';
  ctx.font='10px Courier New';
  ctx.fillText(planet.Name,w/2+d.x*b,h/2-d.y*b-2);
 }
}
var t; //seconds since start
var p=new Date();
var speed=(1<<30)*1;
var fps=8;

function inter(from,to) {
 return t>=from && t<=to;
}

function tick() {
 var now=new Date().getTime();
 if (now>start+(1<<12)) {
  b+=0.05;
 }
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,w,h);
 ctx.setTransform(1,0,0,1,0,0);
 p=new Date(p.getTime()+speed);
 //1 Au grid:
 ctx.fillStyle='#0f0';
 for(i=0;i<w/b;i++) {
  ctx.fillRect(w/2+i*b,0,0.25,h);
  ctx.fillRect(w/2-i*b,0,0.25,h);
 }
 for(i=0;i<h/b;i++) {
  ctx.fillRect(0,h/2+i*b,w,0.25);
  ctx.fillRect(0,h/2-i*b,w,0.25);
 }
 //TheSun:
 ctx.beginPath();
 ctx.fillStyle='yellow';
 ctx.arc(w/2,h/2,8,0,2*Math.PI);
 ctx.fill();

 ctx.lineWidth=0.25;
 ctx.lineWidth=0.5;
 //http://en.wikipedia.org/wiki/Orbital_period#Relation_between_the_sidereal_and_synodic_periods
 drawPlanet(Astronomy.Mercury,0.240846,'yellow');
 drawPlanet(Astronomy.Venus,0.615,'green');
 drawPlanet(Astronomy.Earth,1,'blue');
 drawPlanet(Astronomy.Mars,1.881,'red');
 drawPlanet(Astronomy.Jupiter,11.8618,'white');
 drawPlanet(Astronomy.Saturn,29.4571,'white');
 drawPlanet(Astronomy.Uranus,84.016846,'white');
 drawPlanet(Astronomy.Neptune,164.8,'white');
 //ToDo:  eccentricity
 //drawPlanet(Astronomy.Pluto,247.68,'white');
 var t16=Math.floor(p.getTime()/1000).toString(16).substring(0,4)+'....';
 ctx.font='12px Courier New';
 ctx.textAlign='left';
 ctx.textBaseline='top';
 ctx.fillStyle='#0f0';
 ctx.fillText('st'+t16,4,4);
 t=(now-start)/1000;
 if ( inter(4,8)) {
  ctx.fillText('Searching for intelligent life...',4,120);
 }
 ctx.fillText('t'+((1<<16)+Math.floor(t)).toString(16).substring(1),4,390);
}

setInterval(tick,1000/fps);
tick();
"]]]))))