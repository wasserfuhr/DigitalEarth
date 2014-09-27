(fn [rq rs db]
 (let [
   hash
    (fn [msg] ; https://gist.github.com/kisom/1698245
     (let [hash (java.security.MessageDigest/getInstance "SHA-256")]
      (. hash update (.getBytes msg))
      (.digest hash)))
   s (.getParameter rq "script")
   t (.getParameter rq "tag")
   formatHash
    (fn [hash]
     (apply str
      (map #(format "%02x" (bit-and % 0xff))
       hash)))
   st0 (.prepare db "SELECT id FROM a2 order by CreatedAt desc")
   latestHash (do (.step st0) (.columnBlob st0 0))
   cookie (apply str (map (fn [c] (if (.equals "SemperCookie" (.getName c)) (.getValue c))) (.getCookies rq)))

   ;http://stackoverflow.com/questions/10062967/clojures-equivalent-to-pythons-encodehex-and-decodehex
   unhexify
    (fn [s]
     (into-array Byte/TYPE
      (map
       (fn [[x y]]
        (unchecked-byte (Integer/parseInt (str x y) 16)))
       (partition 2 s))))

   ;;;;;;;;;;;
   ;ToDo: check UnCookie 

   ;;;;;;;;;;;
   user
    (if (.equals "6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b"
     (formatHash (hash cookie)))
     (str "RaWa (IpAddress: " (.getRemoteAddr rq) ")")
     (.getRemoteAddr rq))

   st (.prepare db "SELECT id,parent,createdAt,tag FROM a2 order by createdAt asc")
   iter
    (fn [a]
     (if (.step st)
      (recur (cons
        [:tr
         [:td [:a {:href (str "/SemperBase.jsp?raw&hash=" (formatHash (.columnBlob st 0)))}
            (.substring (formatHash (.columnBlob st 0)) 0 8) "..."]]
         [:td (if (.columnBlob st 1) (str (.substring (formatHash (.columnBlob st 1)) 0 8) "..."))]
         [:td
          (.format
           (java.text.SimpleDateFormat. "yyyy-MM-dd HH:mm:ss")
            (java.util.Date. (.columnLong st 2)))]
         [:td (.columnString st 3)]
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
      now " " 
      "1 " ;RaWa
      "1 " ;RaWa
      t " "
      (.length s) " " s))
    st (.prepare db (str "insert into a2 (id,parent,createdAt,createdBy,session,tag,scriptSize,script) "
     "values (?,?,?,?,?,?,?,?)"))]
    (.bind st 1 hash)
    (.bind st 2 latestHash)
    (.bind st 3 now)
    (.bind st 4 1)
    (.bind st 5 1)
    (.bind st 6 t)
    (.bind st 7 (.length s))
    (.bind st 8 s)
    (.step st)
    (.dispose st)
    (.sendRedirect rs "http://base.sl4.eu/"))
 (if (.getParameter rq "raw")
  (if (.equals "063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e"
        (.getParameter rq "hash"))
   "HashBeat"
   (let [
     h (.getParameter rq "hash")
     st (.prepare db "SELECT parent,createdAt,createdBy,session,tag,scriptSize,script FROM a2 where id=?")]
    (.bind st 1 (unhexify h))
    (.step st)
    (str
     (formatHash (.columnBlob st 0)) " "
     (.columnLong st 1) " "
     (.columnLong st 2) " "
     (.columnLong st 3) " "
     (.columnString st 4) " "
     (.columnLong st 5) " "
     (.columnString st 6))))
 (do
  (.setContentType rs "text/html; charset=UTF-8")
  (let [c (javax.servlet.http.Cookie. "SemperCookie" "1")]
   (.setMaxAge c (* 60 60 24 30))
   (.addCookie rs c))
(.setAttribute
  (.getServletContext (.getSession rq))
   "session1" "hello")
  (hiccup.core/html "<!DOCTYPE html>"
   [:html
    [:head
     [:meta {:http-equiv "Content-type"
             :content "text/html; charset=utf-8"}]
     [:title "SemperBase"]]
    [:body
     [:h1 "SemperBase"]
     [:small "(HashBeat: " [:span {:style "font-family:monospace"} (formatHash latestHash)")"]]
     [:h2 "EternalComputing"]
     [:p "WelCome " user]
     [:h2 "ScriptEditor:"]
     [:form {:method "post"}
      [:table
       [:tr
        [:td {:style "vertical-align:top"} "script:" [:br] [:textarea {:name "script"}]]
        [:td {:style "vertical-align:top"} "tag:" [:br] [:input {:name "tag"}] [:br]
            [:input {:type "checkbox" :name "isRoot"}]  [:small "isRoot?"] [:br] ]
        [:td {:style "vertical-align:top"} [:br] [:input {:type "submit"}]]]]]
     [:h2 "HashChain:"]
     [:table {:style "font-family:monospace"}
      [:tr
       [:th "id"]
       [:th "parent"]
       [:th]]
      rows]]]))))))