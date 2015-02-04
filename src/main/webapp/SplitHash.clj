(fn [rq rs]
 (let [
   h "b75876be5d725e220908d7bb6ffd267014b55c88"
   f (java.io.File. (str "/home/rawa/TerraDrive/" h ".zip"))]
  (.length f)))