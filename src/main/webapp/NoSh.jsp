
<%
 String l=request.getParameter("log");
 if(null!=l) {
  String ls[]=l.split("\n");
  System.out.println(">>"+ls.length);
  for (int i=0; i<ls.length; i++) {
   System.out.println(">"+ls[i]+"<");
  }
 %>"ok"<%
 } else {%>
<html>
 <head>
  <meta name="viewport" content="width=240"/>

<script src="https://cdn.rawgit.com/google/closure-library/master/closure/goog/base.js"></script><script>
goog.require('goog.functions');
goog.require('goog.net.XhrIo');</script><script>
function remoteGet(a) {
 goog.net.XhrIo.send('/NoSh.jsp?log='+a, function(e) {
  var xhr = e.target;
  var obj = xhr.getResponseJson();
//  document.getElementById('beat').innerHTML=
  // '<a href="http://planet.sl4.eu/SemperBase.jsp?raw&hash='+obj+'">#'+obj+'</a>';
 });
}
</script>
 </head>
 <body style="font-family:monospace;margin:0;padding:0">
<textarea id="sh" cols="39" rows="9" autofocus onkeyup="key()">
0123456789abcdef0123456789abcdef0123456
0123456789abcdef0123456789abcd
0123456789abcdef0123456789abcd
0123456789abcdef0123456789abcd
</textarea>
  <script>
document.getElementById("sh").focus();
function key() {
 var h=document.getElementById("sh").value;
 h=h.replace(/\n/g,"xx");
 remoteGet(h);
//  document.getElementById("sh").value);

//document.getElementById("sh").value=event.keyCode+" "+document.getElementById("sh").value;
if (event.keyCode == 13) 
    {
  //      alert('hi');


    }}
  </script>
 </body>
</html>
<%}%>
