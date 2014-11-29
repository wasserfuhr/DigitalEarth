<html>
 <head>
  <title>SingularTime</title>
  <script>
var zoomLevel=0;

function tick() {
 ctx=document.getElementById('time').getContext('2d');
 ctx.font="12px Arial";
 ctx.fillStyle='#fff';
 ctx.fillRect(0,0,1024,256);
 var now=new Date();
 var t0=Math.round(now.getTime()/1000);
 var t=t0-512;
 for (var i=0;i<32;i++) {
  var l0=Math.pow(2,i);
  if (i>=zoomLevel) {
   var l=Math.pow(2,i-zoomLevel);
   for (var j=-512;j<5012+l;j+=l) {
    ctx.fillStyle=(t0+j)&l?'#ddd':'#fff';
    ctx.fillRect(j-(((t0/l)+j)%l),512-(i+1)*16,l,16);
   }
  } else {
   ctx.fillStyle='#eee';
   ctx.fillRect(0,512-(i+1)*16,1024,16);
  }
  ctx.fillStyle='#d8d8d8';
  ctx.fillRect(0,512-(i+1)*16,1024,1);
  ctx.fillStyle='#000';
  ctx.fillText(t&l0?"1":"0",514,510-i*16);
 }

 var units=[
  {m:60}];
 
 var pixelPerUnit=60/Math.pow(2,zoomLevel);
 if (pixelPerUnit>15) {
  for (var j=-1024;j<1024;j+=pixelPerUnit) {
   ctx.fillStyle='#bbb';
   ctx.fillRect(512+j-t0%60/l0,0,1,512);
   var m=new Date(now.getTime()+j*1000).getMinutes();
   ctx.fillText(m,508+j-t0%60/l0+pixelPerUnit/2,200);
  }
 }

 var pixelPerUnit=60*60/Math.pow(2,zoomLevel);
 if (pixelPerUnit>10) {
  for (var j=-1024;j<1024;j+=pixelPerUnit) {
   ctx.fillRect(512+j-t0%3600,0,1,512);
   var m=new Date(now.getTime()+j*60*1000).getHours();
   ctx.fillText(m,512+j-t0%3600+pixelPerUnit/2,100);
  }
 }

 ctx.fillStyle='#eee';
 var pixelPerUnit=365*24*60*60/Math.pow(2,zoomLevel);
 if (pixelPerUnit>100) {
  for (var j=-1024;j<1024;j+=pixelPerUnit) {
   ctx.fillRect(512+j,0,1,512);
  }
 }

 ctx.fillStyle='#f00';
 ctx.fillRect(512,0,1,512);

 for (var i=0;i<32;i++) {
  var l0=Math.pow(2,i);
  ctx.fillStyle='#000';
  ctx.fillText(t&l0?"1":"0",514,510-i*16);
 }
}
setInterval(tick,1000);
  </script>
 </head>
 <body style="font-family:Arial">
  <h1 style="text-align:center">SingularTime</h1>
<div style="text-align:center">
  <table>
   <tr>
    <td>
     <button onclick="zoomLevel++;tick()" style="margin-left:502px">+</button>
     <br/>
     <canvas style="border:1px solid #aaa;" id="time" width="1024" height="512"></canvas>
     <br/>
     <button onclick="zoomLevel--;tick()" style="margin-left:502px">-</button>
    </td>
    <td>
     <code id="t"></code>
    </td>
   </tr>
  </table>
</div> </body>
</html>
