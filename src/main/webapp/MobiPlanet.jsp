<html>
 <head>
  <title>DigitalPlanet</title>
  <meta name="viewport" content="width=device-width"/>
 </head>
 <body style="margin:0;padding:0">
 <canvas height="280" id="c" style="border:1px solid #aaa;" width="240"></canvas>
<script>
 var x=5;
 var w=40;
 var y=1;
 var h=30;
 var b=16;
 var c=document.getElementById('c');
 var ctx=c.getContext('2d');
 ctx.fillStyle="#000";
 ctx.fillRect(2,2,300,200);
 ctx.fillStyle="#fff";
 ctx.fillRect(0,20,100,2);
 ctx.fillRect(100,40,100,2);
 ctx.fillRect(200,20,40,2);
 ctx.strokeStyle="white";
 ctx.beginPath();
 ctx.moveTo(20,180);
 ctx.lineTo(100,20);
 ctx.lineTo(170,120);
 ctx.stroke();
</script>
</body>
</html>
