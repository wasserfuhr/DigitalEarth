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
   latestHash (do (.step st0) (.columnBlob st0 0))

   ;http://stackoverflow.com/questions/10062967/clojures-equivalent-to-pythons-encodehex-and-decodehex
   unhexify
    (fn [s]
     (into-array Byte/TYPE
      (map (fn [[x y]]
                    (unchecked-byte (Integer/parseInt (str x y) 16)))
                       (partition 2 s))))

   st (.prepare db "SELECT id,parent,createdAt FROM HashChain order by CreatedAt asc")
   iter
    (fn [a]
     (if (.step st)
      (recur (cons
        [:tr
         [:td [:a {:href (str "/FreeCubes.jsp?raw&hash=" (formatHash (.columnBlob st 0)))}
            (.substring (formatHash (.columnBlob st 0)) 0 8) "..."]]
         [:td (if (.columnBlob st 1) (str (.substring (formatHash (.columnBlob st 1)) 0 8) "..."))]
         [:td
          (.format
           (java.text.SimpleDateFormat. "yyyy-MM-dd HH:mm:ss")
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
      (formatHash latestHash) " "
      "0 "
      now " " 
      "1 " ;RaWa
      (.length s) " " s))
    st (.prepare db (str "insert into HashChain (id,parent,isRoot,createdAt,createdBy,scriptSize,script) "
     "values (?,?,?,?,?,?,?)"))]
    (.bind st 1 hash)
    (.bind st 2 latestHash)
    (.bind st 3 0)
    (.bind st 4 now)
    (.bind st 5 1)
    (.bind st 6 (.length s))
    (.bind st 7 s)
    (.step st)
    (.dispose st)
    (.sendRedirect rs "/FreeCubes.jsp"))
 (if (.getParameter rq "raw")
  (if (.equals "063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e"
        (.getParameter rq "hash"))
   "HashBeat"
   (let [
     h (.getParameter rq "hash")
     st (.prepare db "SELECT parent,isRoot,createdAt,createdBy,scriptSize,script FROM HashChain where id=?")]
    (.bind st 1 (unhexify h))
    (.step st)
    (str
     (formatHash (.columnBlob st 0)) " "
     (if (= 0 (.columnInt st 1)) 0 1) " "
    (.columnLong st 2) " "
    (.columnLong st 3) " "
    (.columnLong st 4) " "
    (.columnString st 5)
    )))
 (do
  (.setContentType rs "text/html; charset=UTF-8")
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:meta {:http-equiv "Content-type"
             :content "text/html; charset=utf-8"}]
     [:title "FreeCubes"]]
    [:body
     [:h1 "HelloCubes!"]
     [:small "HashBeat: " [:span {:style "font-family:monospace"} (formatHash latestHash)]]
     [:form
      [:textarea {:name "script"}]
      [:input {:type "checkbox" :name "isRoot"}]
      [:input {:type "submit"}]]
     [:h2 "HashChain:"]
     [:table {:style "font-family:monospace"}
      [:tr
       [:th "id"]
       [:th "parent"]
       [:th]]
      rows]]]))))))