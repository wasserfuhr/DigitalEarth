(fn[rq rs](let [
   formatHash ""]
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:title"AlphaMesh"]
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
    [:canvas#c {:width 256 :height 320}]
    [:script "
var ctx=document.getElementById('c').getContext('2d');
var xs=[];
var ys=[];

function dist(i,j){
 return Math.pow(xs[i]-xs[j],2)+
 Math.pow(ys[i]-ys[j],2)
}

function draw(){
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.strokeStyle='#080';
 ctx.fillStyle='#fff';
 Math.random();
 for(var i=0;i<60;i++){
  xs[i] =Math.random()*200;
  ys[i] =Math.random()*300;
  ctx.fillRect(xs[i],ys[i],2,2);}
 for(var i=0;i<60;i++){
  var best=0;
  for(var j=0;j<60;j++){
   if(i!=j) {
    if(dist(i,j)<dist(i,best)){
     best=j;
    }
   }
   ctx.beginPath();
   ctx.moveTo(xs[i],ys[i]);
   ctx.lineTo(xs[best],ys[best]);
   ctx.stroke();
  }
 }
}
//setInterval(draw,2000);
draw();
"]]]))))