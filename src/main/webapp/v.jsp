<html>
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link href="http://sl4.eu/css" rel="stylesheet" type="text/css" />
 </head>
<body>
 <style>
body {
 margin:0;
 padding:0;
}
h1 {
 margin:1px;
 font-size:120%
}
 </style>
 <h1><a href="/" style="font-amily:monospace; font-variant:normal">&alpha;</a></h1>
 <span id="i"></span>
 <canvas id="c" height="120" width="240"></canvas>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>

<script>
function resize (e) {
 var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
 var h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
 document.getElementById('i').innerHTML=w+'x'+h;
 var c=document.getElementById('c');
 c.width=w;
 var ctx=c.getContext('2d');
 ctx.fillStyle='#0f0';
 for(i=0; i<w; i+=2) {
  ctx.fillRect(i,0,1,64); 
 }  
 ctx.fillStyle='#f00';
 for(i=0; i<w; i+=4) {
  ctx.fillRect(i+1,16,1,32); 
 }
 ctx.fillStyle='#00f';
 for(i=0; i<w; i+=4) {
  ctx.fillRect(i+3,24,1,32); 
 } 
}

window.onresize = resize;
resize(null);
</script>

<br/>a
<br/>b
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<hr>
<br/>
<br/>
<br/>
<br/>
<br/>
<hr>
<br/>
<br/>
<br/>
<br/>
<br/>
<hr/>
</body>
</html>
