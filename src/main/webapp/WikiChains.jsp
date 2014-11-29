<%@ page pageEncoding="UTF-8"%><%@page import="
java.security.MessageDigest"%>
<html>
 <head>
  <title>SemperBase</title>
  <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha256.js"></script>
  <script src="https://rawgit.com/dfahlander/Dexie.js/master/dist/latest/Dexie.min.js"></script>
 </head>
<body>
<%
Cookie[] cookies = request.getCookies();
String sc="";
if( cookies != null) {
 for (int i = 0; i < cookies.length; i++){
  if ("JSESSIONID".equals( cookies[i].getName())) {
   sc=cookies[i].getValue();
  }
 }
}
MessageDigest hash=MessageDigest.getInstance("SHA-256");
hash.update(sc.getBytes());
String h="#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest());
%>
 <h1>WikiChains</h1>
 stores an experimental chain of <code>WikiPage</code/>s.
 <div id="note">HelloWikiChain</div>
 <span id="count">?</span> items.
 <input>
 <textarea></textarea>
 <br/>
 beat: <span id="beat">?</span>.
<script>
var sessionHash ='<%=h%>';
var sessionPrefix='<%=sc.substring(8)%>';
var remoteHost='<%=request.getRemoteHost()%>';

document.getElementById("beat").innerHTML=CryptoJS.SHA256("HashBeat");

var db = new Dexie('MyDatabase1');
// Define a schema
db.version(1)
.stores({data:'hash,parent,size'
});

db.open()
 .catch(function(error){
   alert('Uh oh : ' + error);});

db.data
 .add({
 hash:'X063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e',
 parent:'063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e',
 size:12
});

db.data.count(function(ct){
 document.getElementById("count").innerHTML=ct;});

//http://mdn.github.io/to-do-notifications/scripts/todo.js :
window.onload = function() {
 // In the following line, you should include the prefixes of implementations you want to test.
 window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
 // DON'T use "var indexedDB = ..." if you're not in a function.
 // Moreover, you may need references to some window.IDB* objects:
 window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
 window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;
 // (Mozilla has never prefixed these objects, so we don't need window.mozIDB*)
 // Let us open our database
 var DBOpenRequest = window.indexedDB.open("SemperBase", 1);

 DBOpenRequest.onupgradeneeded = function(event) {
  var db = event.target.result;

  db.onerror = function(event) {
   note.innerHTML += '<li>Error loading database.</li>';
  }
  // Create an objectStore for this database
  var objectStore = db.createObjectStore("WikiChain", { keyPath: "taskTitle"});
  // define what data items the objectStore will contain
  //objectStore.createIndex("parent", "parent", { unique: false });
  note.innerHTML += '<li>Object store created.</li>';
 };
};</script>
chain:
</body>
</html>
