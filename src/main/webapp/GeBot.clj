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
    [:input {:value "-" :type "button" :onclick "rota0(-10)"}]
    [:input {:value "+" :type "button" :onclick "rota0(10)"}]
    " "
    [:input {:value "-" :type "button" :onclick "rota1(-10)"}]
    [:input {:value "+" :type "button" :onclick "rota1(10)"}]
    [:script "
var c=document.getElementById('c');
var ctx=c.getContext('2d');
var rot0=-70;
var rot1=-45;

var start=new Date().getTime();

function rota0(b) {
 rot0+=b;
 tick();
}
function rota1(b) {
 rot1+=b;
 tick();
}

var w=640*2;
var h=180*2;
c.width=w;
c.height=h;
function tick() {
 ctx.setTransform(1,0,0,1,0,0);
 var p=(new Date().getTime()-start)/1000;
 ctx.fillStyle='#111';
 ctx.fillRect(0,0,w,h);
 ctx.fillStyle='orange';
 ctx.strokeStyle='orange';
 ctx.beginPath();
 ctx.translate(200,200);
 ctx.rotate(rot0*Math.PI/180);
 ctx.moveTo(0,-12);
 ctx.lineTo(100,-6);
 ctx.lineTo(100,6);
 ctx.lineTo(0,12);//+50*Math.sin(rot1*Math.PI/180),100+50*Math.cos(rot1*Math.PI/180));
 ctx.stroke();
 ctx.textBaseline='middle';
 ctx.font='bold 12px Courier';
 ctx.fillText('PiBo',10,0);
 ctx.beginPath();
 ctx.translate(100,0);
 ctx.rotate(rot1*Math.PI/180);
 ctx.moveTo(0,-6);
 ctx.lineTo(80,-4);
 ctx.lineTo(80,4);
 ctx.lineTo(0,6);
 ctx.stroke();
}
//setInterval(tick,100);
tick();
"]]]))))