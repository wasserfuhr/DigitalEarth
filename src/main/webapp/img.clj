(fn[rq rs](do (.setContentType rs"image/jpg")
;java.util.ByteArrayOutputStream (.getBytes

 (clojure.java.io/copy (clojure.java.io/file (str"/home/rawa/SpaceDrive/1220"(.getParameter rq"h")".jpg"))
  (.getOutputStream rs)
)))



;response.setContentLength(baos.size());
;OutputStream os = response

; baos.writeTo(os);
 