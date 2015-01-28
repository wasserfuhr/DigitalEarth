(fn [rq rs]
 (let [
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))]
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:title "»NooSphere«"]
     [:meta {:http-equiv "Content-type" :content "text/html; charset=utf-8"}]
     [:meta {:name "viewport" :content "width=device-width"}]
     [:meta {:http-equiv "refresh" :content "4; URL=http://sl4.eu/buy"}]]
    [:body
     [:div {:style "text-align:center"}]
     [:h2 {:style "position:absolute;z-index:2;color:#aaa;top:10px;font-family:helvetica;left:20px;font-size:12pt"} "RainerWasserfuhr EtAlii"]
     [:h1 {:style "position:absolute;z-index:2;color:red;top:220px;font-family:helvetica;left:60px;font-size:32pt"} "»NooSphere«"]
     [:h3 {:style "position:absolute;z-index:2;text-align:right;color:#fff;top:320px;font-family:helvetica;left:98px;font-weight:normal;font-size:12pt"}
  "Wie @tineroyal ihren" [:br]
  "TraumMann fand und wir fast alle" [:br]
  "UnSterblich werden"]
  [:h2 {:style "position:absolute;z-index:2;color:#000;top:470px;font-family:helvetica;left:20px;font-size:12pt"} "EditionPieschen"]
  [:canvas#c {:height 512 :style "position:absolute;z-index:1;top:20px" :width 386}]
  [:script {:src "TittelBild.js"}]
  [:script "
 ctx=document.getElementById('c').getContext('2d');
 var b=8;
 for(var i=0;i<64;i++) {
  for(var j=0;j<48;j++) {
   var cc=tittel[i].charAt(j);;
   ctx.fillStyle='#'+cc+cc+cc;
   ctx.fillRect(j*b,i*b,b,b);
  }
 }"]
[:a {:href "http://sl4.eu/sl4"} [:code "sl++"]]
]])))