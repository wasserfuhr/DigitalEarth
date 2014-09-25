(fn [rq rs db]
 (let [
   hash (fn [msg]
   ; https://gist.github.com/kisom/1698245
    (let [hash (java.security.MessageDigest/getInstance "SHA-256")]
     (. hash update (.getBytes msg))
     (.digest hash)))
   s (.getParameter rq "script")
   st (.prepare db "SELECT id FROM HashChain order by CreatedAt desc")
    hashS (hash (str 1 " " 2 " " 3))
   iter
    (fn [a]
     (if (.step st) 
      (recur (cons [:tr [:td "!" (.columnString st 0)]] a))
      a))
   rows (iter "")
   ]
 (.dispose st)
 (if s
  (let [
    hash (hash (str (.getTime (java.util.Date.)) " " 2 " " 3))
    dig
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash))]
    (.exec db (str "insert into HashChain (id,script) values ('" dig "','" s "')")))
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:body
     [:h1 "HelloCubes!"]
     [:form
      [:textarea {:name "script"}]
      [:input {:type "submit"}]]
     [:br] [:table rows] hashS]]))))