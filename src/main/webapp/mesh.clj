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
    [:canvas#c {:width 300 :height 400}]
    [:script "
var ctx=document.getElementById('c').getContext('2d');
var xs=[];
var ys=[];
var dxs=[];
var dys=[];
for(var i=0;i<60;i++){
 xs[i] =Math.random()*300;
 ys[i] =Math.random()*400;
 dxs[i] =1-Math.random()*2;
 dys[i] =1-Math.random()*2}

function dist(i,j){
if(i==j) return 100000000;
 return Math.pow(xs[i]-xs[j],2)+
 Math.pow(ys[i]-ys[j],2)
}

function draw(){
 ctx.fillStyle='#000';
 ctx.fillRect(0,0,1024,512);
 ctx.strokeStyle='#080';
 ctx.fillStyle='#fff';
 for(var i=0;i<60;i++){
  xs[i]+=dxs[i];
  ys[i]+=dys[i];
  var b1=
   59+ 0*Math.floor(Math.random()*60);
  var b2=
   59+ 0*Math.floor(Math.random()*60);
  for(var j=0;j<60;j++){
   if(i!=j) {
    if(dist(i,j)<dist(i,b1)){
     if(dist(i,b1)<dist(i,b2)){
      b2=b1;
     }
     b1=j;
    }
   }
   ctx.strokeStyle='#080';
   ctx.beginPath();
   ctx.moveTo(xs[i],ys[i]);
   ctx.lineTo(xs[b2],ys[b2]);
   ctx.stroke();
   
   ctx.strokeStyle='#008';
   ctx.beginPath();
   ctx.moveTo(xs[i],ys[i]);
   ctx.lineTo(xs[b1],ys[b1]);
   ctx.stroke();
  }
  }
 for(var i=0;i<60;i++){
  ctx.fillRect(xs[i],ys[i],2,2);}
}
setInterval(draw,100);
"]]]))))