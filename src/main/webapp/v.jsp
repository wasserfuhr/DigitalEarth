<html>
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<link href="http://sl4.eu/css" rel="stylesheet" type="text/css" />
 </head>
<body><h1>&alpha;</h1>

<canvas id="c" height="320" width="240"/>

<span id="i"></span>
<script>
function resize (e) {
 var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
 var h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
 document.getElementById('i').innerHTML=w+'x'+h;
 document.getElementById('c').width=w;
var ctx=document.getElementById('c').getContext('2d');
 for(i=0; i<w; i+=2) {
  ctx.fillStyle='#0f0';
  ctx.fillRect(i,0,1,64); 
 }  
}

window.onresize = resize;
resize(null);
</script>

<br/>
<br/><br/>
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
<hr>

</body>
</html>