(fn [rq rs]
 (let [
   hash
    (fn [msg] ; https://gist.github.com/kisom/1698245
     (let [hash (java.security.MessageDigest/getInstance "SHA-256")]
      (. hash update (.getBytes msg))
      (.digest hash)))
   s (.getParameter rq "script")
   t (.getParameter rq "tag")
   ;"SemperCookie"
   cookie (apply str (map (fn [c] (if (.equals "JSESSIONID" (.getName c)) (.getValue c))) (.getCookies rq)))
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))]
  (if s
   (let [
     now (.getTime (java.util.Date.))]
    (str "ToDo: " s))
   (hiccup.core/html "<!DOCTYPE html>"
    [:html
     [:head
      [:title "BlogChains « SemperBase"]
      [:meta {:http-equiv "Content-type" :content "text/html; charset=utf-8"}]
      [:script {:src "https://cdn.rawgit.com/google/closure-library/master/closure/goog/base.js"}]
      [:script "
goog.require('goog.functions');
goog.require('goog.net.XhrIo');"]
      [:script {:type "text/javascript"} "
(function() {
    if (typeof window.janrain !== 'object') window.janrain = {};
    if (typeof window.janrain.settings !== 'object') window.janrain.settings = {};
    janrain.settings.tokenUrl = '" (.getScheme rq) "://" (.getServerName rq) "/signedin?go=/';

    function isReady() { janrain.ready = true;};
    if (document.addEventListener) {
      document.addEventListener('DOMContentLoaded', isReady, false);
    } else {
      window.attachEvent('onload', isReady);
    }

    var e = document.createElement('script');
    e.type = 'text/javascript';
    e.id = 'janrainAuthWidget';

    if (document.location.protocol === 'https:') {
      e.src = 'https://rpxnow.com/js/lib/pieschenbank/engage.js';
    } else {
      e.src = 'http://widget-cdn.rpxnow.com/js/lib/pieschenbank/engage.js';
    }

    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(e, s);})();"]
      [:script "
function remoteGet() {
 goog.net.XhrIo.send('/SemperBaseRaf.jsp', function(e) {
  var xhr = e.target;
  var obj = xhr.getResponseJson();
  document.getElementById('beat').innerHTML=
   '<a href=\"http://planet.sl4.eu/SemperBase.jsp?raw&hash='+obj+'\">#'+obj+'</a>';
 });
}

var unfetched;
function sync() {
 syncing=true;
 document.getElementById('sync').value='Stop sync...';
 goog.net.XhrIo.send('/RootHandler.jsp?p=HashIndex', function(e) {
  var xhr = e.target;
  unfetched = xhr.getResponseJson();
  document.getElementById('note').innerHTML='fetched '+obj.unfetched;
 });

}"]
      [:style {:type "text/css"} "
body {
 //background: #000;
 //color: #0f0;
 font-family: monospace;
}
a {
 //color: #0f0;
}"]
      [:script {:src "https://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha256.js"}]
      [:script {:src "https://rawgit.com/dfahlander/Dexie.js/master/dist/latest/Dexie.min.js"}]]
     [:body
      [:h1 "BlogChains"]
      [:h2 "Experimental: The BlockChain meets distributed MicroBlogging."]
      [:p "We now often have far more storage available on our LapTop or SmartPhone than needed to store the *entire*
content we and our friends create on FaceBook GooglePlus or TwittEr. »BlogChains« uses a local DataBase
inside your WebBrowser as part of a globally distributed storage layer for immutable data, secured by a so call »HashChain«."]
      [:div#janrainEngageEmbed]
      [:input#sync {:type "submit" :value "sync" :onclick "sync()" }] ": "
      [:span#count "?"] " items."
      [:div#note]
      [:form {:method "post"}
       [:table
        [:tr
         [:td {:style "vertical-align:top; padding-right:20px" :rowspan 2}
          "RecentPosts:"
          [:ul
           [:li "FriPa"]
           [:li "UnParty"]
           [:li "WikiChains"]]]
         [:td {:style "vertical-align:top"}
          "Title:"]
         [:td {:style "vertical-align:top"}
          [:input {:name "tag" :value "Your first posting" :readonly "readonly"}] [:input {:type "submit" :value "post"}]]]
        [:tr
         [:td {:style "vertical-align:top"} "Content:"]
         [:td {:style "vertical-align:top"}
          [:textarea {:name "script"}]]]]]
      [:br]
      [:small "ChainHead: " [:span#beat (formatHash (hash "HashBeat"))]]
      [:script "
var sessionHash ='" (formatHash (hash "HashBeat")) "';
var sessionPrefix='" (.substring cookie 0 8) "';
var remoteHost='" (.getRemoteHost rq) "';

document.getElementById('beat').innerHTML=CryptoJS.SHA256('HashBeat');

var db = new Dexie('SemperBase');
// Define a schema
db.version(1)
.stores({data:'hash,value'
//.stores({data:'hash,p0,p1,p2,p3,tag,script,size'
});

db.open()
 .catch(function(error){
   alert('Uh oh : ' + error);});

db.data.count(function(ct){
 document.getElementById('count').innerHTML=ct;});

var syncing=false;

function tick() {
 if (Math.floor(new Date().getTime()/1000)%16==0) {
 //  remoteGet();
 }
 if (syncing && unfetched.length>0) {
  fetch=unfetched.pop();
  goog.net.XhrIo.send('/RootHandler.jsp?p=HashHex&hash='+fetch, function(e) {
   var xhr = e.target;
   var obj = xhr.getResponseJson();
   var words = CryptoJS.enc.Hex.parse(obj);
   var hex   = CryptoJS.enc.Hex.stringify(words);
   if(CryptoJS.SHA256(hex)!=fetch) {
    console.log('mismatch: '+fetch);
   }

   db.data
    .add({
     hash:fetch,
     size:words.length/2,
     script:obj});
  });
 }
}
remoteGet();
setInterval(tick,1000);
"]
]]))))