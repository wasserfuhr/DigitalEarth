<html>
 <head>
  <title>ElectricOcean</title>
 </head>
 <body>
  <h1>ElectricOcean</h1>
  <p>use the cursor to navigat, SPACE for metal and "b" for bridges.</p>
  <canvas height="320" id="c" style="border:1px solid #aaa;" width="240"></canvas>
<script>
 var x=5;
 var w=40;
 var y=1;
 var h=30;
 var b=16;
 var c=document.getElementById('c');
 c.width=w*b;
 c.height=h*b;
 var ctx=c.getContext('2d');
 //gates
 var g = new Array(w);
 //charges
 var ch = new Array(w);
 for (var i=0; i<w; i++) {
  g[i] = new Array(h);
  ch[i] = new Array(h);
  for (var j=0; j<h; j++) {
   g[i][j]=0;
   ch[i][j]=0;
  }
 }
 g[0][1]=1;
 ch[0][1]=15;
 g[0][3]=1;
 ch[0][3]=15;
 g[0][5]=1;
 ch[0][5]=0;
 g[1][1]=2;
 g[2][1]=2;
 g[3][1]=2;

 for (var j=1; j<h; j++) {
  g[4][j]=2;
 }

 function sim() {
  var cht = new Array(w);
  for (var i=1; i<w; i++) {
   cht[i] = new Array(h);
   for (var j=1; j<h; j++) {
    var ct=1;
    var chn=ch[i][j];
    if(g[i-1][j]>0) {
     ct++;
     chn+=ch[i-1][j];
    }
    if(g[i][j-1]>0) {
     ct++;
     chn+=ch[i][j-1];
    }
    if (g[i][j]>0) {
     cht[i][j]=Math.round(chn/ct);
    } else {
     cht[i][j]=0;
    }
   }
  }
  for (var i=1; i<w; i++) {
   for (var j=1; j<h; j++) {
    ch[i][j]=cht[i][j];
   }
  }
  draw();
 }

 function draw() {
  ctx.fillStyle='#aaa';
  ctx.fillRect(0,0,w*b,h*h);
  ctx.lineWidth=2;
  for (var i=0;i<w;i++) {
   for (var j=0;j<h;j++) {
    ctx.fillStyle='#aaa';
    var cc=(15-ch[i][j]).toString(16);
    if (1==g[i][j]) {
     ctx.strokeStyle='#000';
     ctx.strokeRect(i*b,j*b,b-1,b-1);
    }
    if (g[i][j]>0) {
     ctx.fillStyle="#"+cc+cc+"f";
    }
    ctx.fillRect(i*b,j*b,b,b);
    if (1==g[i][j]) {
     ctx.strokeStyle='#000';
     ctx.strokeRect(i*b,j*b,b,b);
    }
    if (3==g[i][j]) {
     ctx.beginPath();
     ctx.arc(i*b+b/2,j*b+b/2+2,b*0.8,5*Math.PI/4,7*Math.PI/4);
     ctx.stroke();
     ctx.beginPath();
     ctx.arc(i*b+b/2,j*b+3*b/2,b*0.8,5*Math.PI/4,7*Math.PI/4);
     ctx.stroke();
    }
    ctx.fillStyle='#f00';
    //ctx.fillText(ch[i][j].toString(16),i*20+8,j*20+12);
   }
  }
  ctx.lineWidth=1;
  ctx.strokeStyle='#f00';
  ctx.strokeRect(x*b,y*b,b,b);
 }

 function keyHandler(event) {
  if (event.keyCode==37) { //left
   x--;
  }
  if (event.keyCode==38) { //up
   y--;
  }
  if (event.keyCode==39) { //right
   x++;
  }
  if (event.keyCode==40) { //down
   y++;
  }
  if (event.keyCode==66) { //bridge
    g[x][y]=3;
  }
  if (event.keyCode==71) { //gate
  }
  if (event.keyCode==32) { //SPACE
   if(1==g[x][y]) {
    ch[x][y]=15-ch[x][y];
   } else {
    g[x][y]=2;//(g[x][y]+1%4;
   }
//console.log(x+" "+y);
  }
console.log(event.keyCode);
  draw();
 }
document.onkeydown=keyHandler;
draw();
setInterval(sim,1000);
</script>
</body>
</html>
