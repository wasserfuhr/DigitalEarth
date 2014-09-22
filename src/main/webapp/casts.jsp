<!DOCTYPE html>
<html>
 <head>
  <script src="CastHash.jsp"></script>
  <script src="FileSize.jsp"></script>
  <script src="TerraDrive.js"></script>
  <script src="likes.jsp"></script>
<style>
.vote{
border-collapse: collapse;
border:1px solid black; empty-cells:show
}
 .vote td {
  height: 2px;
  width: 2px;
  border: 1px solid black;
 }
</style>
 </head>
 <body>
  <h1>TerraDrive</h1>
  <h2>Casts</h2>
  <table id="table">
   <tr>
    <th>hash</th>
    <th>cast</th>
    <th>size</th>
    <th>like</th>
   </tr>
  </table>
  <script>
 function dottedBytes(num) {
  //http://blog.tompawlak.org/number-currency-formatting-javascript
  return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")
 }

 var table=document.getElementById("table");
 for(var t in casts) {
 var row = table.insertRow(table.rows.length);
  var cell1 = row.insertCell(0);
  cell1.style.fontFamily="monospace";
  cell1.innerHTML=t;
  var cell2 = row.insertCell(1);
  var element1 = document.createElement("a");
  element1.href="http://screenr.com/"+casts[t];
  element1.innerHTML=casts[t];
  cell2.appendChild(element1);
  var cell3 = row.insertCell(2);
  if(fileSize[t]) {
   cell3.innerHTML=dottedBytes(fileSize[t]);
  } else {
   cell3.innerHTML ="???";
  }
  cell3.style.textAlign="right";
  var cell4 = row.insertCell(3);
  //var element4 = document.createElement("table");
  //element4.innerHTML=".";
  var like="<table class='vote'>";
  for (var i=0;i<4;i++) {
   like=like+"<tr>";
   for (var j=0;j<4;j++) {
    var n=i*4+j;
    like=like+"<td id='i"+t+"_"+n+"' style='background:"+(n<likes[t]?"red":"white")+"'></td>";
   }
   like+="</tr>";
  }
  cell4.innerHTML=like+"</table>";
 }
  </script>
 </body>
</html>
