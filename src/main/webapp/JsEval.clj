(fn [rq rs]
 (let [
   inSize 43
   style "font-size:11px; font-family:monospace;margin:0;padding:0"
   v0 " 123456789abcdef"
   v1 " 123456789a"
   v (str "0123456789abcdef" v0 v1)
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
     [:script "
var bytes='" (str v0 v0 v0)"';
function edit(l) {
 sp0='                       ';
 spx=sp0+sp0+sp0+sp0;
 var l0=document.getElementById('l0');
 var l1=document.getElementById('l1');
 var l2=document.getElementById('l2');
 sS=document.getElementById('l'+l).selectionStart;
 bytes=l0.value+l1.value+l2.value+spx;
 l0.value=bytes.substring(0,43);
 l1.value=bytes.substring(43,86);
 document.getElementById('l'+l).selectionStart=sS;
 document.getElementById('l'+l).selectionEnd=sS;
}"]
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
    [:a {:href "/1"} "RaWa"] "@" [:a#st {:href "http://time.sl4.eu/"} "st00000000"]
    ": /"
    [:br]
    [:div {:style "text-align:left"}
     [:input#l0 {:style style :size inSize :value v :oninput "edit(0)"}] [:br]
     [:input#l1 {:style style :size inSize :value v :oninput "edit(1)"}] [:br]
     [:input#l2 {:style style :size inSize :value v :oninput "edit(2)"}] [:br]
     [:input {:style style :size (- inSize 2) :value v}] 
     [:span#ct "ff"] [:br]
;"//23456789abcdef 123456789abcdef
;
;e=2.17828;
;pi=3.14159;
;d?"]
     [:canvas#c {:width 200 :height 80}]
     [:br]
    [:script "
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

setInterval(tick,1000);
"]]]]))))