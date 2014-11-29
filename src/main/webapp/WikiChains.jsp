<html>
 <head>
  <title>SemperBase</title>
  <script src="https://rawgit.com/dfahlander/Dexie.js/master/dist/latest/Dexie.min.js"></script>
 </head>
<body>
 <h1>WikiChain</h1>
 stores an experimental chain of <code>WikiPage</code/>s.
 <div id="note">HelloWikiChain</div>
<script>

var db = new Dexie('MyDatabase');
alert("o");
// Define a schema
db.version(2)
.stores({: 'name, age'
});

db.open()
.catch(function(error){
alert('Uh oh : ' + error);
});

db.friends
.add({
name: 'Camilla',
age: 25
});


var note=document.getElementById("note");

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
