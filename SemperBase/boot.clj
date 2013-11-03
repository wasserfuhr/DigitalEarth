(fn [request response] 
 (let [
   b "/home/rawa/DigitalEarth/SemperBase/base"
   //String b="/home/rawa/DigitalEarth/SemperBase/base";
   f (java.io.File. b)
   //File f=new java.io.File(b);
   db (com.almworks.sqlite4java.SQLiteConnection. f)
   st (.prepare db "select id, from l order by id desc limit 32")
   lines
    (fn [st]
     (if (.step st)
      (str "<td>"st.columnInt(1)
       (lines st))]
  (str "<form><input type='submit'/><textarea name=''></textarea></form>
<table>
  (lines st)
</table>")
