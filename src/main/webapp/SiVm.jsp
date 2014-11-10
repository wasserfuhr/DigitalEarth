<html>
 <h1>MagicSilicon</h1>
 <canvas height="320" id="c" style="border:1px solid #aaa;" width="240"></canvas>
<script>
 var x=0;
 var y=0;
 var ctx=document.getElementById('c').getContext('2d');
 var g = new Array(10);
 for (var i = 0; i < 10; i++) {
  g[i] = new Array(20);
 }

 function draw() {
  ctx.fillStyle='#aaa';
  ctx.fillRect(0,0,240,320);
  for (var i=0;i<10;i++) {
   for (var j=0;j<20;j++) {
    ctx.fillStyle='#aaa';
    if (g[i][j]==1) {
     ctx.fillStyle='#fff';
    }
    ctx.fillRect(20+i*20,20+j*20,20,20);
   }
  }
  ctx.strokeStyle='#f00';
  ctx.strokeRect((x+1)*20,(y+1)*20,20,20);
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
  if (event.keyCode==32) { //SPACE
   if(!g[x][y])g[x][y]=0;
   g[x][y]=(g[x][y]+1)%4;
  console.log(g[x][y]);
  }
  draw();
 }
document.onkeydown=keyHandler;
draw();
</script>
</html>
