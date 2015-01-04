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
    [:a#st {:href "http://film.sl4.eu/"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');
var w=640*2;
var h=480*2;
c.width=w;
c.height=h;
var start=new Date().getTime();
var t;//time since start

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

function tick() {
 ctx.setTransform(1,0,0,1,0,0);
 t=(new Date().getTime()-start)/1000;
 ctx.fillStyle='#111';
 ctx.fillRect(0,0,w,h);
 ctx.fillStyle='#0f0';
 for(i=1;i<5;i++) {
  ctx.fillRect(i*w/4,0,0.25,h);
 }
 for(i=1;i<3;i++) {
  ctx.fillRect(0,i*h/3,w,0.25);
 }
 ctx.font='bold 64px serif';
// fade=ip(
  //[[0,0],[4,255]]);
 if (t<4) {
  fade=t*255/6;
 } else {
  fade=255;
 }
 if (t>16) {
  fade=(16-t)*255/6;
 }
 ctx.fillStyle='rgb(0,'+Math.floor(fade)+',0)';
 //ctx.fillStyle='rgb(0,155,0)';
 var now=new Date();
 var t0=Math.floor((2038-1970)*365*24*60*60-now.getTime()/1000);
 var t16=t0.toString(16);
 ctx.textAlign='center';
 ctx.textBaseline='middle';
 ctx.font='bold 64px Courier';
 ctx.fillText(t16,w/2,h/2);
 ctx.fillStyle='#fff';
 if (t>=1 && t<=60) {
  ctx.fillText('- '+Math.floor(t)+' -',w/2,h*5/6);
 }
 if (t>0) {
  var xs=[[1,0],[12,w/2]];
  var ii=ip(xs);
//console.log(t+': '+ii);
  ctx.fillRect(w/4,h/6, ip(xs),1);
  ctx.fillRect(w/4,h/6, 1, ip(xs));
  var ps=[[1,0],[16,w/2]];
 //ctx.fillRect(3*w/4-(t*w/2,5*h/6,Math.min(w/2,ip,1);
 //ctx.fillRect(3*w/4-(t-4)*w/2,2*h/3,1,(t-4)*w/2);
 }
 if (t>8) {
  ctx.font='bold 512px Serif';
  ctx.fillStyle='#444';
  ctx.fillText('N',w/2,h/2);
 }
 if (t<42) {
  ctx.font='bold 256px Serif';
  ctx.fillStyle='#f00';
  ctx.translate(w/2,h/2);
  ctx.scale(Math.min(t/32,0.8),Math.min(t/32,0.8));
  ctx.fillText('»NooSphere«',0,0);
 }
}
setInterval(tick,300);
"]
;GretChen1to60:
;[:iframe {:width 1 :height 1 :src "//www.youtube.com/embed/bDtK8WjxvDI?autoplay=1"}]
]]))))