<html>
<body>
<script>
alert("!");window.navigator.vibrate(500);
alert("!1");
window.onload = function() {
  note.innerHTML += '<li>App initialised.</li>';
  // In the following line, you should include the prefixes of implementations you want to test.
  window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
  // DON'T use "var indexedDB = ..." if you're not in a function.
  // Moreover, you may need references to some window.IDB* objects:
  window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
  window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;
  // (Mozilla has never prefixed these objects, so we don't need window.mozIDB*)


  // Let us open our database
  var DBOpenRequest = window.indexedDB.open("toDoList", 4);
   

</script>
</body>
</html>