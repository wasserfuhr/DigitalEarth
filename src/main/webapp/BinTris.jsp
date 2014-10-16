<%@ page pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
 <head><meta content="text/html; charset=utf-8" http-equiv="Content-type" /><title>BinTris</title>
<script>
var rows={};

var currRow;
var rowCt;
var paused=false;

for (var i=0;i<16;i++) {
 rows[i]=0;
}

function newRow() {
 currRow=Math.floor(Math.random()*256);
//console.log(currRow);
 rowCt=15;
}

newRow();

function draw() {
 ctx=document.getElementById('time').getContext('2d');
 ctx.fillStyle='#fff';
 ctx.fillRect(0,0,160,320);
 ctx.fillStyle='#f00';
 var now=new Date();
 for (var i=15;i>=0;i--) {
  for (var j=7;j>=0;j--) {
   if ((1 << j)&rows[i]) {
    ctx.fillRect((7-j)*20,300-i*20,20,20);
   }
  }
 }
 for (var j=7;j>=0;j--) {
  if ((1 << j)&currRow) {
   ctx.fillRect((7-j)*20,300-rowCt*20,20,20);
  }
 }
}

function cleanRows() {
 for (var i=0;i<16;i++) {
  if (rows[i]==255) {
   for (var j=i;j<15;j++) {
    rows[j]=rows[j+1];
   }
  }
 }
}

function down() {
  for (var j=7;j>=0;j--) {
   if ((1<<j)&currRow) {
    //find blocks:
    var n=j;
    var hasLower=(rowCt==0)||((1<<j)&rows[rowCt-1]);
    while (n>0&&((1<<(n-1))&currRow)) {
     n--;
     hasLower=hasLower||((1<<n)&rows[rowCt-1]);
    }
    if (hasLower) {
     for (var i=j;i>=n;i--) {
      rows[rowCt]=rows[rowCt]|(1<<i);
      currRow-= 1<<i;
     }
    }
    j=n;
   }
  }
  if(currRow==0) {
   cleanRows();
   newRow();
   return false;
  }
  rowCt--;
  return true;
}

function drop() {
 while(down());
}

function tick() {
 draw();
 if (!paused) {
  down();
 }
}
setInterval(tick,1000);</script></head><body style="font-family:Arial"><h1 style="text-align:center;color:#aaa;margin-bottom:0px">BinTris<sup><a alt="Edit SingularTime" href="https://github.com/wasserfuhr/DigitalEarth/blob/master/src/main/webapp/BinTris.jsp" title="Edit SingularTime"><img height="10" src="https://ssl.gstatic.com/codesite/ph/images/pencil-y14.png" width="10" /></a></sup></h1>
<p style="text-align:center">
<table style="margin-left: auto;
margin-right: auto;text-align:center">
 <tr>
  <td>
<canvas height="320" id="time" style="border:1px solid #aaa;" width="160"></canvas>
</td><td>
 <button onclick="paused=!paused">||</button>
<br/>
 <button onclick="currRow++;draw()">++</button>
 <button onclick="currRow--;draw()">--</button>
<br/>
 <button onclick="if(currRow<128){currRow*=2;draw();}">&lt;&lt;</button>
 <button onclick="if(currRow%2==0){currRow=currRow/2;draw();}">&gt;&gt;</button>
<br/>
 <button onclick="drop()">&darr;</button>
</td></tr></table>
</p>
<p style="text-align:center">
<small><a href="http://sl4.eu/">»NooSphere«</p>
</small></body></html>
