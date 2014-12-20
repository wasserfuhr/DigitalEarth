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

var start=new Date().getTime();

var w=640*2;
var h=480*2;
c.width=w;
c.height=h;
function tick() {
 var p=(new Date().getTime()-start)/1000;
 ctx.fillStyle='#111';
 ctx.fillRect(0,0,w,h);
 ctx.fillStyle='#0f0';
 for(i=1;i<5;i++) {
  ctx.fillRect(i*w/4,0,0.25,h);
 }
 for(i=1;i<3;i++) {
  ctx.fillRect(0,i*h/3,w,0.25);
 }
 if (p<4) {
  fade=255;
 } else {
  fade=(16-p)*255/6;
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
 if (p>4) {
  ctx.fillRect(w/4,h/6,Math.min(w/2,(p-4)/2*w/2),1);
  ctx.fillRect(w/4,h/6, 1,Math.min(w/2,(p-4)*w/2));
  ctx.fillRect(3*w/4-(p-4)*w/2,5*h/6,Math.min(w/2,(p-4)*w/2),1);
  ctx.fillRect(3*w/4-(p-4)*w/2,2*h/3,1,(p-4)*w/2);
 }
 if (p>8) {
  ctx.font='bold 256px Serif';
  ctx.fillStyle='#444';
  ctx.fillText('N',w/2,h/2);
 }
 if (p>1) {
  ctx.font='bold '+p*2+'px Serif';
  ctx.fillStyle='#f00';
  ctx.fillText('»NooSphere«',w/2,h/2);
 }
}
setInterval(tick,100);
"]]]))))