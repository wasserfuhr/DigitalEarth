<%
 Cookie[] cookies = request.getCookies();
 String sc="";
 if( cookies != null) {
  for (int i = 0; i < cookies.length; i++){
   if ("JSESSIONID".equals( cookies[i].getName())) {
    sc=cookies[i].getValue();
    System.out.println(">"+sc+"<");

   }
  }
 }
 //1m7sujie9k02zlhklbw9iv3bl //DiebesGott Browser
 //135sqn1a7lbyet4lztju7x62y //TinesHp RaWa GoogleChrome
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
  <title>Hi RaWa! (<%=sc%>)</title>
  <meta name="viewport" content="width=240"/>

<script src="https://cdn.rawgit.com/google/closure-library/master/closure/goog/base.js"></script><script>
goog.require('goog.functions');
goog.require('goog.net.XhrIo');</script><script>
function remoteGet(a) {
 document.getElementById("sh").style.background='#ddd';
 goog.net.XhrIo.send('/NoSh.jsp?log='+encodeURI(a), function(e) {
  var xhr = e.target;
  var obj = xhr.getResponseJson();
  if ("ok"==obj) {
   document.getElementById("sh").style.background='#fff';
  }
//  document.getElementById('beat').innerHTML=
  // '<a href="http://planet.sl4.eu/SemperBase.jsp?raw&hash='+obj+'">#'+obj+'</a>';
 });
}
</script>
 </head>
 <body style="font-family:monospace;margin:0;padding:0">
<textarea id="sh" cols="39" rows="9" autofocus onkeyup="key()" style="background:#eee">
0123456789abcdef0123456789abcdef0123456
1
2
3
4
5
6
7
8</textarea>
  <script>
document.getElementById("sh").focus();
function key() {
 var h=document.getElementById("sh").value;
// h=h.replace(/\n/g,"xx");
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
