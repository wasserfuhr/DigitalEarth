(fn[rq rs]
 (hiccup.core/html "<!DOCTYPE html>" [:html
[:body
 [:table
  [:tr[:td#v]]
  [:tr[:td[:input#i3{:type "checkbox"}][:input#i2{:type "checkbox"}]]]
  [:tr[:td[:input#i1{:type "checkbox"}][:input#i0{:type "checkbox"}]]]]
[:script "
function tick(){
 v=0;
 for(i=0;i<4;i++){
  if(document.getElementById('i'+i).checked){
   v+=1<<i;
  }
 }
 document.getElementById('v').innerHTML=v;
}
setInterval(tick,1000);"
]]]))