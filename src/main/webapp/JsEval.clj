(fn [rq rs]
 (let [
   sc (apply str (map (fn [c] (if (.equals "SemperCookie" (.getName c)) (.getValue c))) (.getCookies rq)))
;BoRg:1urw
;DiGo:1337
;TinesHp:?
   inSize 43
   style "font-size:11px; font-family:monospace;margin:0;padding:0"
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))]
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:title "WelCome « NooSphere"]
     [:meta {:name "viewport" :content "width=240"}]
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
   [:body
    [:h1 {:style "font-size:12pt"} [:a {:href "http://sl4.eu/1"} "RaWa"] ":" (.substring sc 0 4) "@" [:a#st {:href "http://time.sl4.eu/"} "st00000000"]
    ": /"]
    [:div {:style "text-align:left"}
     [:input#l0 {:style style :size (+ inSize 1) :oninput "edit(0)"}] [:br]
     [:input#l1 {:style style :size (+ inSize 1) :oninput "edit(1)"}] [:br]
     [:input#l2 {:style style :size (+ inSize 1) :oninput "edit(2)"}] [:br]
     [:input#l3 {:style style :size (+ inSize 1) :oninput "edit(3)"}] [:br]
     [:input#l4 {:style style :size (+ inSize 1) :oninput "edit(4)"}] [:br]
     [:input#l5 {:style style :size (- inSize 2) :oninput "edit(5)"}] 
     [:span#ct "ff"] [:br]
;e=2.17828;
;pi=3.14159;
     (.substring sc 0 4) ;1urw
     [:canvas#c {:width 200 :height 80}]
     [:br]
     [:script "
var l0=document.getElementById('l0');
var l1=document.getElementById('l1');
var l2=document.getElementById('l2');
var l3=document.getElementById('l3');
var l4=document.getElementById('l4');
var l5=document.getElementById('l5');
var ctx=document.getElementById('c').getContext('2d');

var p=3;
var l=20;

function tick() {
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.fillStyle='#0f0';
 var now=new Date();
 var t0=Math.floor(now.getTime()/1000);
 var t16=t0.toString(16);
 document.getElementById('st').innerHTML='st'+t16;
}

var bytes='WelCome';

store();

setInterval(tick,1000);


function sub(b,l) {
 if (b.length>l*43) {
  return b.substring(l*43,Math.min((l+1)*43,b.length));
 }
 return '';
}

function store() {
 l0.value=sub(bytes,0);
 l1.value=sub(bytes,1);
 l2.value=sub(bytes,2);
 l3.value=sub(bytes,3);
 l4.value=sub(bytes,4);
 l5.value=sub(bytes,5);
}

function edit(l) {
 var sS=document.getElementById('l'+l).selectionStart;
 bytes=l0.value+l1.value+l2.value+l3.value+l4.value+l5.value;
 store();
 document.getElementById('l'+l).selectionStart=sS;
 document.getElementById('l'+l).selectionEnd=sS;
 document.getElementById('ct').innerHTML=bytes.length.toString(16);
}
"]]]]))))