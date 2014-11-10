<html>
 <h1>SiliconVirtualMachine</h1>
 <canvas height="320" id="c" style="border:1px solid #aaa;" width="240"></canvas>
<script>
 var x=0;
 var y=0;
 var ctx=document.getElementById('c').getContext('2d');

 function draw() {
  ctx.fillStyle='#aaa';
  ctx.fillRect(0,0,240,320);
  for (var i=0;i<10;i++) {
   ctx.fillRect(20,20+i*22,20,20);
  }
  ctx.fillStyle='#f00';
  ctx.fillRect((x+1)*20,(y+1)*20,20,20);
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
  draw();
 }
 document.onkeydown=keyHandler;
 draw();
</script>
