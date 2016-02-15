<!DOCTYPE html><html><head><title>Supergenau Kalorien, Vitamine und so... « α</title><meta content="text/html;charset=utf-8" http-equiv="Content-Type" /><meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport" /></head><style>
body{font-size:90%;margin:0}
h1{font-size:115%;margin:0;font-family:sans-serif;background:#0f0;colo:#fff}
.input {
  ---webkit-user-modify: read-write;
OA}
</style><body><h1><sup><a href="/">α</a> »</sup>FoodApp: Supergenau Kalorien, Vitamine und so...</h1>
<!--__Gib einfach Deine EssensMenge ein:
<br />-->

<table><tr><td>Deine Portion: <input max="9999" min="1" name="a" size="4" type="number" />
</td><td>
 <input checked="true" name="u" type="radio" value="g">g (Gramm)</input><br /><input name="u" type="radio" value="ml">ml (MilliLiter)</input>
</td></tr></table>
<br />und von hinten nach vorne die letzten Ziffern vom BarCode:

<div style="text-align:right;font-family:monospace">
<input id="c" name="c" style="text-align:right;font-family:monospace" value=" "/><br/>
<p id="p">441342346424
</p></div>

<script>
try {

var c = document.getElementById('c');
var p = document.getElementById('p');

var as=[
'x 4316268221160 AluFoil',
'x 4316268431392 Rela HalbFett Margarine',
'1415 4316268431415 SonnenblumenMargarine',
'1524 4316268401524 GluehWein',
'1613 4006140001613 EnerBook',
'0020 4316268420020 Toast',
'0108 4013537200108 SpeiseMoehren',
'0598 42200598 BackHefe',
'0615 42260615 Champignons',
'1160 4316268221160 AluFoil',
'1392 4316268431392 Rela HalbFett Margarine',
'1415 4316268431415 SonnenblumenMargarine',
'v1524 4316268401524 GluehWein',
'1613 4006140001613 EnerBook',
'1947 4311596421947 WeizenMehl',
'2139 4316268432139 WaldMeister',
'2208 4316268422208 RapsOel',
'2284 4311605442284 WeissWein',
'2385 3426470022385 Pyrex',
'2521 4316268402521 Kakao',
'2646 4388844182646 PizzaSalami',
'2981 2301006002981 Parmesan',
'3002 4008671033002 NordZucker',
'3021 4316268423021 6x SchlossPils 6830',
'3164 4055400003164 PowerHuelsen',
'3417 4400066903417 RotKaeppchen',
'3706 4022364493706 GasBrenner',
'3939 4316268423939 Mayo',
'4441 4316268324441 SchlossEdel',
'4583 4316268374583 ParboiledRice',
'4622 4316268424622 CafeLatina',
'4620 4335896044620 AgaveNectar',
'4678 4316268414678 MilchReis',
'4741 4316268394741 VollkornSpaghetti',
'5033 8410702035033 VinaLazar',
'5263 29075263? KarPatiAffe',
'5282 42275282 BienenHonig',
'5312 4311501425312 SchokoPudding',
'6051 4316268136051 KamillenTee',
'6111 4316268456111 ApfelMus',
'6209 4316268326209 WeissWein',
'6295 4008535256295 HoneyWheat',
'6349 4055400006349 DrehPowerRed',
'6414 4316268016414 WeizenMehl',
'9531 4300175849531 LangKorn-NaturReis'
];

//http://stackoverflow.com/questions/280634/endswith-in-javascript
function endsWith(str, suffix) {
 return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

function ps() {
 var s='';
 for (i =0;i<as.length;i++) {
  a=as[i].split(' ');
  if(endsWith(a[1],c.value.trim())){
   s+=a[2]+' '+a[1]+'<br/>';
  }
 }
 p.innerHTML=s
}
ps();

//http://stackoverflow.com/questions/12009015/setselectionrange-workaround-doesnt-work-for-android-4-0-3
setTimeout(function() {
 c.selectionStart=1;
 c.selectionEnd=1;},0);

c.oninput=function() {
 setTimeout(function() {
  c.value=" "+c.value.replace(" ",""); 
  c.selectionStart=1;
  c.selectionEnd=1;
  //https://plainjs.com/javascript/styles/get-and-set-scroll-position-of-an-element-26/
  c.scrollTop=5;
  document.body.scrollTop =50;
  ps();
},0);
}
c.onkeydown=function() {
 var k = event.keyCode||event.charCode;
//alert(k);
 if(k==8||k==46) {
  setTimeout(function() {
   c.value=' '+c.value.replace(' ','').substring(1);
   c.selectionStart=1;
   c.selectionEnd=1;
   ps();
  },0);
  return false
 }
}

}
catch(e) {
 alert(e);
}


</script>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
.
</body></html>
