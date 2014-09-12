
<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha1.js"></script>
<script>
 var ct=0;
  minHash="ff";

  function tick() {
   ct++;
   var r=Math.random();
   var hash = CryptoJS.SHA1(""+r);
   if(hash<minHash) {
    document.getElementById("min").innerHTML=hash;
    document.getElementById("minV").innerHTML=r;
    document.getElementById("ct").innerHTML=ct;
    minHash=hash;
   }
  }
  var go=false;
  setInterval(tick,1000);

  function toggle() {
   var now=new Date().getTime()+1000*parseInt( document.getElementById("s").value);
   while(new Date().getTime()<now) { tick();}
   document.getElementById("ct").innerHTML=ct;
  }

  function stop() {
   go=false;

  }
</script>

<input type=button onclick="toggle()" value="go"/> for
<input id="s" value="8"/> seconds.

<code>
<br/><br/>
<span id="min"></span>
<span id="minV"></span> ct: <span id="ct"></span>

<br/><br/>

best so far:
<br/>000008d271da83d9d29cf355c7eed3316d83ecd8 0.8921635911892627
<br/>000031c954b8c033d3af620b1b1bf095b6befe22 0.4061377009576561
<br/>000035620cbf87f1acb18d152d8334c2d0202ae3 0.8595432048016468
<br/>000035f88775d0d45c4aee218efe5597e9c71810 0.32760881699217437
<br/>000037659278fd8956a6039e75af9599e2512b19 0.10274710238189022
<br/>000043554d2c8fc36aab074d547a355a53e052b7 0.807710088687099
<br/>00005c8e30db2d33391b80c567b8f2a9a39b5e7b 0.48053614835412084
<br/>00008918e1537f31ad6879b47bde81d6c0895b93 0.14578255102152105
<br/>00008477d6001545ca1de99c9ffd0f7938912a92 0.6099768266796706
<br/>0000e8f31884aebf6827eda5de521413510804be 0.4445448913347251
<br/><br/>

rainer@google.com <%=new java.util.Date().getTime()%> 7035c288fffbe43a8d4e2f4813a2dcba09eba1d6
51faf375a4a39017313d1f86d082fc060e5c6b09 7f7a376de7e9f7c474da58825eed235f61f8d343
</code>