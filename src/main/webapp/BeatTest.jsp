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
  var request = new goog.net.XhrIo();
  var data = goog.Uri.QueryData.createFromMap(new goog.structs.Map({"a":"b"}));

  goog.events.listen(request, 'complete', function() {
   if (request.isSuccess()) {
    var json=request.getResponseJson();
    //log(json);
    if ('error'==json.status) {
     warn("Server failed: "+ request.getStatusText());
     //ToDo
    } else {
     alert("-");
    }
   } else {
    warn("Server failed: "+ request.getStatusText());
   }
  });
  request.send('/beat.jsp', 'POST', data.toString());
  return false;
 }
 remoteGet();
</script>
