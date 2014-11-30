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
     [:title "TimeToHilde « SemperBase"]
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
   [:body]
    [:canvas#c {:width 320 :height 40}]
    [:script "
var pins={
 "1111110",//0
 "0110000",
 "1101101",
 "1111001",
 "0110011",//4
 "1011011",
 "1011111",
 "1110000",
 "1111111";//8
 "1111011";
};
var ctx=document.getElementById('c').getContext('2d');

function digit(offset) {
function tick() {
 ctx.fillStyle='#0f0';
 ctx.fillRect(0,0,1024,512);
 var now=new Date();
 var t0=Math.floor(now.getTime()/1000);


setInterval(tick,1000);
"]])))