(fn [rq rs db]
 (let [
   hash
    (fn [msg] ; https://gist.github.com/kisom/1698245
     (let [hash (java.security.MessageDigest/getInstance "SHA-256")]
      (. hash update (.getBytes msg))
      (.digest hash)))
   s (.getParameter rq "script")
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))
   st0 (.prepare db "SELECT id FROM HashChain order by CreatedAt desc")
   latestHashS (do (.step st0) (.columnBlob st0 0))
   ;latestHash (.getBytes latestHashS)
   st (.prepare db "SELECT id,parent,createdAt FROM HashChain order by CreatedAt asc")
   iter
    (fn [a]
     (if (.step st)
      (recur (cons [:tr [:td (.substring (formatHash (.columnBlob st 0)) 0 8) "..."]
         [:td (if (.columnBlob st 1) (str (.substring (formatHash (.columnBlob st 1)) 0 8) "..."))]
         [:td
          (.format
           (java.text.SimpleDateFormat. "yyyy-MM-dd hh:mm:ss")
            (java.util.Date. (.columnLong st 2)))]
         ] a))
      a))
   rows (iter "")
   ]
 (.dispose st)
 (if s
  (let [
    now (.getTime (java.util.Date.))
    hash
    (hash
     (str
      (formatHash latestHashS) " "
      now " " 
      "1 " ;RaWa
      (.length s) " " s))
    st (.prepare db (str "insert into HashChain (id,parent,isRoot,createdAt,createdBy,script) "
     "values (?,?,0,?,?,?)"))]
    (.bind st 1 hash)
    (.bind st 2 latestHashS)
    ;(.bindNull st 2)
    (.bind st 3 now)
    (.bind st 4 1)
    (.step st)
    (.dispose st)
    (.sendRedirect rs "/FreeCubes.jsp"))
 (if (.getParameter rq "raw") "h"
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:body
     [:h1 "HelloCubes!"]
     [:small "HashBeat: " [:span {:style "font-family:monospace"} (formatHash latestHashS)]]
     [:form
      [:textarea {:name "script"}]
      [:input {:type "checkbox" :name "isRoot"}]
      [:input {:type "submit"}]]
     [:h2 "HashChain:"]
     [:table {:style "font-family:monospace"}
      [:tr
       [:th "id"]
       [:th "parent"]]
      rows]]])))))