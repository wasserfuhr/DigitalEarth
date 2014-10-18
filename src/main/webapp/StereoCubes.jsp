<html>
<body>
<img id="lock" src="https://pbs.twimg.com/profile_images/2083808928/DSCF1649.jpg" width="500" height="377"/>
<canvas height="320" id="time" style="border:1px solid #aaa;" width="160"></canvas>
<script>
function draw() {
 var ctx=document.getElementById('time').getContext('2d');
 var img = new Image();
  ctx.fillStyle='#ff0';
  ctx.fillRect(0,0,160,320);
  ctx.fillStyle='#f00';
  img.onload = function(){
  console.log(document.getElementById('lock'));
  var l=document.getElementById('lock');
  ctx.drawImage(l,0,0,250,190);
 }
 img.src="https://pbs.twimg.com/profile_images/2083808928/DSCF1649.jpg";
}
draw();</script>
</body></html>