<!DOCTYPE html><html><head><meta content="text/html; charset=utf-8" http-equiv="Content-type" /><title>SingularTime</title>
<link href="http://time.sl4.eu/" rel="canonical" />
<script>
var rows={};

var currRow;
var rowCt;

function init() {
 currRow=Math.floor(Math.random()*256);
 rowCt=15;
}

for (var i=0;i<16;i++) {
 rows[i]=0;
}

init();

function tick() {
 ctx=document.getElementById('time').getContext('2d');
 ctx.fillStyle='#fff';
 ctx.fillRect(0,0,160,320);
 var now=new Date();
 for (var i=15;i>=0;i--) {
  for (var j=0;j<8;j++) {
   ctx.fillStyle=((1 << (8-j))&rows[i])?'#f00':'#fff';
   ctx.fillRect(j*20,300-i*20,20,20);
  }
 }
 for (var j=0;j<8;j++) {
  ctx.fillStyle=((1 << (8-j))&currRow)?'#f00':'#fff';
  ctx.fillRect(j*20,300-rowCt*20,20,20);
 }
 rowCt--;
 for (var j=0;j<8;j++) {
  if(rowCt==0||rows[rowCt-1]!=0) {
   rows[rowCt]=currRow;
   init();
  }
 }
}
setInterval(tick,1000);</script></head><body style="font-family:Arial"><h1 style="text-align:center;color:#aaa;margin-bottom:0px">BinTris<sup><a alt="Edit SingularTime" href="/edit?filter=/t" title="Edit SingularTime">
<img height="10" src="https://ssl.gstatic.com/codesite/ph/images/pencil-y14.png" width="10" /></a></sup></h1>
<p style="text-align:center">
<canvas height="320" id="time" style="border:1px solid #aaa;" width="160"></canvas>
 <button onclick="currRow++;draw()">+</button>
 <button onclick="currRow--;draw()">-</button>

</p></body></html>
