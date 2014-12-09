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
    [:canvas#c {:width 320 :height 80}]
    [:br]
    [:a#st {:href "http://time.sl4.eu/"}]
    [:script "
var pins=[
 '1111110',//0
 '0110000',
 '1101101',
 '1111001',
 '0110011',//4
 '1011011',
 '1011111',
 '1110000',
 '1111111',//8
 '1111011',
 '1110111',
 '0011111',
 '1001110',//b
 '0111101',
 '1001111',
 '1000111'];

var ctx=document.getElementById('c').getContext('2d');

var p=3;
var l=20;

function hori(x,y) {
 x+=2*p;
 y+=2*p;
 ctx.beginPath();
 ctx.moveTo(x-p,y);
 ctx.lineTo(x,y-p);
 ctx.lineTo(x+l,y-p);
 ctx.lineTo(x+l+p,y);
 ctx.lineTo(x+l,y+p);
 ctx.lineTo(x,y+p);
 ctx.closePath();
 ctx.fill();
}

function vert(x,y) {
 x+=2*p;
 y+=2*p;
 ctx.beginPath();
 ctx.moveTo(x,y-p);
 ctx.lineTo(x+p,y);
 ctx.lineTo(x+p,y+l);
 ctx.lineTo(x,y+l+p);
 ctx.lineTo(x-p,y+l);
 ctx.lineTo(x-p,y);
 ctx.closePath();
 ctx.fill();
}

function digit(v,x) {
 //https://en.wikipedia.org/wiki/Seven-segment_display#Displaying_letters
 var h=pins[v];
 var c=0;
 if ('1'==h.substring(c++,c)) hori(x,0);
 if ('1'==h.substring(c++,c)) vert(x+l,0);
 if ('1'==h.substring(c++,c)) vert(x+l,l+2*p);
 if ('1'==h.substring(c++,c)) hori(x,2*l+2*p);
 if ('1'==h.substring(c++,c)) vert(x,l+2*p);
 if ('1'==h.substring(c++,c)) vert(x,0);
 if ('1'==h.substring(c++,c)) hori(x,l+p);
}

function tick() {
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.fillStyle='#0f0';
 var now=new Date();
 var t0=Math.floor(now.getTime()/1000);
 var t16=t0.toString(16);
 document.getElementById('st').innerHTML='st'+t16;
 var t00=(5*(1<<28)+4*(1<<24)+8*(1<<20)+11*(1<<16)+6*(1<<12))-t0; //st548b6
 for (var i=0; i<8; i++) {
  var v=(t00>>(4*(7-i)))&15;
  digit(v,i*l*2);
 }
 //console.log(t00);
}

setInterval(tick,1000);
"]]]))))