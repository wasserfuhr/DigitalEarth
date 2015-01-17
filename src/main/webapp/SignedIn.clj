(fn [rq rs]
 (do
  (.setCharacterEncoding rs "UTF-8")
  (let [
    vars (.getAttribute rq "vars")
    hash
     (fn [msg] ; https://gist.github.com/kisom/1698245
      (let [hash (java.security.MessageDigest/getInstance "SHA-256")]
       (. hash update (.getBytes msg))
       (.digest hash)))
    sessId (.getId (.getSession rq))
    service (:datastoreService vars)
    apiKey "7fa86b8e46a5894fa24b58da34f413723531c0ee"
    token (.getParameter rq "token")
    go (.getParameter rq "go")
    ;http://developers.janrain.com/documentation/api/auth_info/
    urlS (str
     "https://rpxnow.com/api/v2/auth_info?"
     "apiKey=" apiKey
     "&token=" token)
    rpxResponse (slurp urlS)
    ;json (clojure.contrib.json/read-json rpxResponse)
    json (clojure.data.json/read-str rpxResponse :key-fn keyword)
    p (:profile json)]
   (str sessId " - "
   (.getTime (java.util.Date)) " - " 
   {(:identifier p) " - "
   (:providerName p) " - "
   (:photo p) " - "
   (:displayName p) " - "
))))