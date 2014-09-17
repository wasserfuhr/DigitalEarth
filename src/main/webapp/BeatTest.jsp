<!DOCTYPE html>
<html>
 <head>
  <script src="https://cdn.rawgit.com/google/closure-library/master/closure/goog/base.js"></script>
  <script>
 goog.require('goog.async.Delay');
 goog.require('goog.net.XhrIo');
 goog.require('goog.structs.Map');
 goog.require('goog.Uri.QueryData');

 function remoteGet() {
  goog.net.XhrIo.send("/beat.jsp", function(e) {
      var xhr = e.target;
      var obj = xhr.getResponseJson();
      log('Received Json data object with title property of "' +  
          obj['title'] + '"'); 
      alert(obj['content']);
  });
 }
 remoteGet();
</script>
