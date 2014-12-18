(fn [rq rs]
 (let [
  ct 1]
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:title "TheSieve « NooSphere"]
     [:script {:src "https://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha256.js"}]
     [:script {:src "https://rawgit.com/dfahlander/Dexie.js/master/dist/latest/Dexie.min.js"}]]
    [:body
     [:h1 "TheSieve"]
     [:p "A (soon distributed) " [:a {:href "http://c2.com/cgi/wiki?SieveOfEratosthenes"} "SieveOfEratosthenes"]"."]
     [:p "we know the first " [:span#ct] " primes, up to " [:span#max] "."]
     ;[:p [:input {:value 100 :size 8}] "th prime: " [:span#p 541] "."]
     [:a {:href "#" :onclick "less()"} "less..."]
     [:table {:style "font-family: monospace"}
      (map
       (fn [f]
        [:tr (map (fn [j] [:td {:style "color:#bbb" :id (str "i" f j)} f j]) 
         ;(range 10)
         (rest (.split "0123456789abcdef" "")))])
       ;(range 10)
       (rest (.split "0123456789abcdef" "")))]
     [:a {:href "#" :onclick "more()"} "more..."]
     [:script "
//https://oeis.org/A001223
var gaps=[1,2,2,4,2,4,2,4,6,2,6,4,2,4,6,6,2,6,4,2,6,4,6,8,4,2,4,
 2,4,14,4,6,2,10,2,6,6,4,6,6,2,10,2,4,2,12,12,4,2,4,6,2,10,6,6,6,
 2,6,4,2,10,14,4,2,4,14,6,10,2,4,6,8,6,6,4,6,8,4,8,10,2,10,2,6,4,
 6,8,4,2,4,12,8,4,8,4,6,12,2,18];
var sieve=new Set();
var curr=2;
//GoogleChrome copes with numbers up to Math.pow(2,54) (but only 1<<30)
var s='';
document.getElementById('i02').style.color='#f00';

var off=0;
var base=16;

function draw() {
 for (var i=0;i<base*base;i++) {
  d=document.getElementById('i'+(i<base?'0':'')+i.toString(16));
  d.style.color='#ccc';
  d.innerHTML=(i+off).toString(16);
 }

 curr=2;
 for (var i=0;i<gaps.length;i++) {
  curr+=gaps[i];
  j=curr-off;
  d=document.getElementById('i'+(j<base?'0':'')+j.toString(16));
  if(d)d.style.color='#000';
 }
 for(i of sieve){
  j=i-off;
  d=document.getElementById('i'+(j<base?'0':'')+j.toString(16));
  if(d)d.style.color='#000';
 }
}

function less() {
 off-=base*base;
 draw();
}

function more() {
 off+=base*base;
 draw();
}

for (var i=0;i<gaps.length;i++) {
 curr+=gaps[i];
 d=document.getElementById('i'+(curr<10?'0':'')+curr);
 //if(d)d.innerHTML='*'+curr;
 if(d)d.style.color='#000';//innerHTML='*'+curr;
 s+=String.fromCharCode(gaps[i]);//.charCodeAt(0);
}
/*var db = new Dexie('PrimeBase');
// Define a schema
db.version(1)
.stores({data:'nth,gaps,size'
});

db.open()
 .catch(function(error){
   alert('Uh oh : ' + error);});

db.data
 .add({
 //hash:'eb2f362e4812d7901cfe9e78f69820c13c1d49a8065f25d8da574fdaa76b8bbe',
 nth:100,
 gaps:s
});

db.data.count(function(ct){
 //document.getElementById('count').innerHTML=ct;
});
*/
document.getElementById('ct').innerHTML=gaps.length+1;
document.getElementById('max').innerHTML=curr;
//console.log('>'+s+'<');

page=1<<16;
start=new Date().getTime();

for(i=curr;i<curr+page;i+=2) {
 sieve.add(i);
}
iCurr=2;
var last=-1;
for(i=0;i<gaps.length;i++){
 iCurr+=gaps[i];
 last=i;
 for(j=iCurr*2;j<curr+page;j+=iCurr){
  sieve.delete(j);
 }
}
for(i of sieve){
 last=i;
 for(j=i*2;j<curr+page;j+=i){
  sieve.delete(j);
 }
}
var gap=0;
var prev=0;
for(i of sieve){
 if(prev==0) {
  prev=i;
 } else {
  if(gap<i-prev) {
   gap=i-prev;  
console.log('MaxGap: '+gap+' between '+prev+' and '+i);
  }
  prev=i;
 } 
}


console.log('in '+(new Date().getTime()-start)+'msec:');
console.log(sieve);
console.log(gap);
document.getElementById('ct').innerHTML=gaps.length+sieve.size;
document.getElementById('max').innerHTML=last;
setInterval(more,1000);
"]]])))