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
    [:input {:value "+" :type "button" :onclick "rot(0,10)"}]
    [:input {:value "-" :type "button" :onclick "rot(1,-10)"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');
var rot1=180;

var start=new Date().getTime();

function rot(a,b) {
 rot1+=b;
 tick();
}

var w=640*2;
var h=180*2;
c.width=w;
c.height=h;
function tick() {
 var p=(new Date().getTime()-start)/1000;
 ctx.fillStyle='#111';
 ctx.fillRect(0,0,w,h);
 ctx.strokeStyle='orange';//#0f0';
 ctx.beginPath();
 ctx.moveTo(100,100);
 ctx.lineTo(100+50*Math.sin(rot1*Math.PI/180),100+50*Math.cos(rot1*Math.PI/180));
 ctx.stroke();
 ctx.rotate(-(90+rot1)*Math.PI/180);
 ctx.strokeText('PiBo',100,100);
 ctx.rotate((90+rot1)*Math.PI/180);
 ctx.setTransform(0,0,0,0,0,0);
}
//setInterval(tick,100);
tick();
"]]]))))