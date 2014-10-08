<!DOCTYPE html>
<html>
 <head>
  <script src="https://cdn.rawgit.com/google/closure-library/master/closure/goog/base.js"></script>
  <!--script src="https://google-developers.appspot.com/closure/library/samples/xhr-quick-compiled.js"></script-->
  <script>
 //goog.require('goog.async.Delay');
 goog.require('goog.functions');
 goog.require('goog.net.XhrIo');
 //goog.require('goog.structs.Map');
 //goog.require('goog.Uri.QueryData');
  </script>
  <script>
function remoteGet() {
 goog.net.XhrIo.send("/SemperBase.jsp?beat", function(e) {
  var xhr = e.target;
  var obj = xhr.getResponseJson();
  // log('Received Json data object: ' + obj); 
  // alert(obj);
  document.getElementById("beat").innerHTML=
   '<a href=\"/SemperBase.jsp?raw&hash='+obj+'\">'+obj+'</a>';
 });
}
  </script>
 </head>
 <body>
  <script>
setInterval(remoteGet,1000);
//remoteGet();
  </script>
 HashBeat: <span id="beat"></span>
</html>
