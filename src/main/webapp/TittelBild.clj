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
     [:title "»NooSphere«"]
     [:meta {:http-equiv "Content-type" :content "text/html; charset=utf-8"}]
     [:meta {:name "viewport" :content "width=device-width"}]
     [:meta {: http-equiv="refresh" :content "4; URL=http://sl4.eu/buy"}]]
    [:body
     [:div {:style "text-align:center"}]
     [:h2 {:style "position:absolute;z-index:2;color:#aaa;top:10px;font-family:helvetica;left:20px;font-size:12pt"} "RainerWasserfuhr EtAlii"]
     [:h1 {:style "position:absolute;z-index:2;color:red;top:220px;font-family:helvetica;left:60px;font-size:32pt"} "»NooSphere«"]
     [:h3 {:style "position:absolute;z-index:2;text-align:right;color:#fff;top:320px;font-family:helvetica;left:98px;font-weight:normal;font-size:12pt"}
  "Wie @tineroyal ihren" [:br]
  "TraumMann fand und wir fast alle" [:br]
  "UnSterblich werden"]
  [:h2 {:style "position:absolute;z-index:2;color:#000;top:470px;font-family:helvetica;left:20px;font-size:12pt">EditionPieschen</h2>
  [:canvas {height="512" id="c" style="position:absolute;z-index:1;top:20px;" width="386"></canvas>
<script>

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
    [:input#labels {:type "checkbox"}] "show names"
    [:script {:src "http://cosinekitty.com/astronomy.js"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');

var start=new Date().getTime();

var w=640;
var h=640;
c.width=w;
c.height=h;
var maxMarsAu=1.7;
var b=4;
var t; //seconds since start
var p=new Date();
var speed=(1<<29)*4;
var fps=8;

function inter(from,to) {
 return t>=from && t<=to;
}

//interpolate values
function ip(ps) {
 //ps: array of [time,value]
 if(t<ps[0][0]) {
  return ps[0][1];
 }
 var i=0;
 var ret=0;
 while(i<ps.length-1) {
  if (t<=ps[i+1][0]) {
   //https://en.wikipedia.org/wiki/Linear_interpolation
   var v= ps[i][1]+(ps[i+1][1]-ps[i][1])*(t-ps[i][0])/(ps[i+1][0]-ps[i][0]);
   if(!v)
    i=i;
ret=v;
break;
//ToDo: why doesn'this work:
   // return v;//ps[i][1]+(ps[i+1][1]-ps[i][1])*(t-ps[i][0])/(ps[i+1][0]-ps[i][0]);
  } else {
    ret=ps[i][1];
  }
  i++;
 }
 return ret;
}

function drawPlanet(planet,period,color) {
 for(i=0;i<255;i++) {
  var d1=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-i*period*120000000)));
  var d2=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-(i+1)*period*120000000)));
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
 ctx.arc(w/2+d.x*b,h/2-d.y*b,Math.max(2,4/b),0,2*Math.PI);
 ctx.fill();
 if (document.getElementById('labels').checked) {
  ctx.textAlign='center';
  ctx.textBaseline='bottom';
  ctx.font='10px Courier New';
  ctx.fillText(planet.Name,w/2+d.x*b,h/2-d.y*b-3);
 }
}

function tick() {
 var now=new Date().getTime();
 t=(now-start)/1000;
 //pixel per AU
 b=ip([[0,8],[4,8],[10,9],[0x80,160],[0xff,1600]]);
 speed=speed*0.995;
 ctx.setTransform(1,0,0,1,0,0);
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,w,h);
 p=new Date(p.getTime()+speed);
 var t16=Math.floor(p.getTime()/1000).toString(16).substring(0,4)+'....';
 ctx.font='12px Courier New';
 ctx.textAlign='left';
 ctx.textBaseline='top';
 ctx.fillStyle='#0f0';
 ctx.fillText('st'+t16,4,2);
 ctx.textBaseline='bottom';
 ctx.fillText('t'+((1<<16)+Math.floor(t)).toString(16).substring(1),4,h-2);
 if ( inter(4,8) || inter(16,20) || inter(28,32)) {
  ctx.textAlign='center';
  ctx.fillText('Searching for intelligent life...',w/2,3/4*h);
 }

 // start geocentric shift
 ctx.setTransform(1,0,0,1,0,0);
 if(t>0x2) {
  var d=Astronomy.Earth.EclipticCartesianCoordinates(Astronomy.DayValue(p));
  var tt=ip([[0x20,0],[0x60,1],[0x2000,1]]);
  ctx.translate(-d.x*b*tt,d.y*b*tt);
 }

 //1 AU grid:
 var dist=Math.log2(w/b);
 var detail=Math.floor(dist);  
 var widths=[8,1,2,1,4,1,2,1];
 ctx.fillStyle='#0f0';
 for(i=-16;i<16;i++) {
  ctx.fillRect(w/2+(1<<detail)/8*b*i,-w,widths[(16+i)%8]/8,3*w);
  ctx.fillRect(-w,w/2+(1<<detail)/8*b*i,3*w,widths[(16+i)%8]/8);
 }

 //TheSun:
 ctx.beginPath();
 ctx.fillStyle='yellow';
 ctx.arc(w/2,h/2,Math.max(3,b*0.01),0,2*Math.PI);
 ctx.fill();

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
 //ToDo: add proper eccentricity
 //drawPlanet(Astronomy.Pluto,247.68,'white');
}

setInterval(tick,1000/fps);
tick();
"]
  [:br]
  [:a {:href "/RasterImg.jsp"} "sl++"]]]))))
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
    [:input#labels {:type "checkbox"}] "show names"
    [:script {:src "http://cosinekitty.com/astronomy.js"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');

var start=new Date().getTime();

var w=640;
var h=640;
c.width=w;
c.height=h;
var maxMarsAu=1.7;
var b=4;
var t; //seconds since start
var p=new Date();
var speed=(1<<29)*4;
var fps=8;

function inter(from,to) {
 return t>=from && t<=to;
}

//interpolate values
function ip(ps) {
 //ps: array of [time,value]
 if(t<ps[0][0]) {
  return ps[0][1];
 }
 var i=0;
 var ret=0;
 while(i<ps.length-1) {
  if (t<=ps[i+1][0]) {
   //https://en.wikipedia.org/wiki/Linear_interpolation
   var v= ps[i][1]+(ps[i+1][1]-ps[i][1])*(t-ps[i][0])/(ps[i+1][0]-ps[i][0]);
   if(!v)
    i=i;
ret=v;
break;
//ToDo: why doesn'this work:
   // return v;//ps[i][1]+(ps[i+1][1]-ps[i][1])*(t-ps[i][0])/(ps[i+1][0]-ps[i][0]);
  } else {
    ret=ps[i][1];
  }
  i++;
 }
 return ret;
}

function drawPlanet(planet,period,color) {
 for(i=0;i<255;i++) {
  var d1=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-i*period*120000000)));
  var d2=planet.EclipticCartesianCoordinates(Astronomy.DayValue(new Date(p.getTime()-(i+1)*period*120000000)));
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
 ctx.arc(w/2+d.x*b,h/2-d.y*b,Math.max(2,4/b),0,2*Math.PI);
 ctx.fill();
 if (document.getElementById('labels').checked) {
  ctx.textAlign='center';
  ctx.textBaseline='bottom';
  ctx.font='10px Courier New';
  ctx.fillText(planet.Name,w/2+d.x*b,h/2-d.y*b-3);
 }
}

function tick() {
 var now=new Date().getTime();
 t=(now-start)/1000;
 //pixel per AU
 b=ip([[0,8],[4,8],[10,9],[0x80,160],[0xff,1600]]);
 speed=speed*0.995;
 ctx.setTransform(1,0,0,1,0,0);
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,w,h);
 p=new Date(p.getTime()+speed);
 var t16=Math.floor(p.getTime()/1000).toString(16).substring(0,4)+'....';
 ctx.font='12px Courier New';
 ctx.textAlign='left';
 ctx.textBaseline='top';
 ctx.fillStyle='#0f0';
 ctx.fillText('st'+t16,4,2);
 ctx.textBaseline='bottom';
 ctx.fillText('t'+((1<<16)+Math.floor(t)).toString(16).substring(1),4,h-2);
 if ( inter(4,8) || inter(16,20) || inter(28,32)) {
  ctx.textAlign='center';
  ctx.fillText('Searching for intelligent life...',w/2,3/4*h);
 }

 // start geocentric shift
 ctx.setTransform(1,0,0,1,0,0);
 if(t>0x2) {
  var d=Astronomy.Earth.EclipticCartesianCoordinates(Astronomy.DayValue(p));
  var tt=ip([[0x20,0],[0x60,1],[0x2000,1]]);
  ctx.translate(-d.x*b*tt,d.y*b*tt);
 }

 //1 AU grid:
 var dist=Math.log2(w/b);
 var detail=Math.floor(dist);  
 var widths=[8,1,2,1,4,1,2,1];
 ctx.fillStyle='#0f0';
 for(i=-16;i<16;i++) {
  ctx.fillRect(w/2+(1<<detail)/8*b*i,-w,widths[(16+i)%8]/8,3*w);
  ctx.fillRect(-w,w/2+(1<<detail)/8*b*i,3*w,widths[(16+i)%8]/8);
 }

 //TheSun:
 ctx.beginPath();
 ctx.fillStyle='yellow';
 ctx.arc(w/2,h/2,Math.max(3,b*0.01),0,2*Math.PI);
 ctx.fill();

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
 //ToDo: add proper eccentricity
 //drawPlanet(Astronomy.Pluto,247.68,'white');
}

setInterval(tick,1000/fps);
tick();
"]
  [:br]
  [:a {:href "/RasterImg.jsp"} "sl++"]]]))))