<html>
 <head>
  <script src="FileSize.jsp"></script>
  <script src="TerraDrive.js"></script>
 </head>
 <body>
  <h1>TerraDrive</h1>
  <table id="table">
   <tr>
    <th>hash</th>
   </tr>
  </table>
  <script>
 function dottedBytes(num) { 
 //http://blog.tompawlak.org/number-currency-formatting-javascript
 return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")
 }

 var s=0;
 var table=document.getElementById("table");
 for(var t in terraDrive) {
 var row = table.insertRow(table.rows.length);
  s+=terraDrive[t].FileSize;
  var cell1 = row.insertCell(0);
  var element1 = document.createElement("a");
  element1.innerHTML=t;
  element1.href="TerraDrive/"+t+"."+terraDrive[t].MediaType;
  cell1.appendChild(element1);
  var cell2 = row.insertCell(1);
  cell2.innerHTML=terraDrive[t].MediaType;
  var cell3 = row.insertCell(2);
  if(terraDrive[t].FileSize) {
   cell3.innerHTML=dottedBytes(terraDrive[t].FileSize);
  } else {
   cell3.innerHTML ="???";
  }
  cell3.style.textAlign="right";
 }
 document.getElementById("size").innerHTML=dottedBytes(s);
  </script>
 </body>
</html>
