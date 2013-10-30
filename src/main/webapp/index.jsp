<%@page import="
java.io.InputStream,
java.io.InputStreamReader,
java.io.PushbackReader,
java.io.StringReader,
java.util.Date,
clojure.lang.Compiler,
clojure.lang.IFn,
clojure.lang.LispReader,
clojure.lang.RT,
com.google.appengine.api.datastore.DatastoreService,
com.google.appengine.api.datastore.DatastoreServiceFactory,
com.google.appengine.api.datastore.Entity,
com.google.appengine.api.datastore.EntityNotFoundException,
com.google.appengine.api.datastore.Key,
com.google.appengine.api.datastore.KeyFactory,
com.google.appengine.api.datastore.Text,
com.google.appengine.api.memcache.MemcacheService,
com.google.appengine.api.memcache.MemcacheServiceFactory
"%><%
 /* Basically delegates to the CloJure RootHandler.
   Load it from MemCache or DataStore or create if it does not exist.
 */
 DatastoreService service=DatastoreServiceFactory.getDatastoreService();
 MemcacheService memCache=MemcacheServiceFactory.getMemcacheService();
 //The BootStrap function is stored as reference at key "BootStrap/RootHandler":
 Key bootStrapKey=KeyFactory.createKey("BootStrap","RootHandler");
 //This might be further tuned:
 if ( null==application.getAttribute("libsLoaded")) {
   RT.loadResourceScript("hiccup/core.clj");
   RT.loadResourceScript("clojure/contrib/json.clj");
   application.setAttribute("libsLoaded","true");
 }

 IFn rootHandlerFn=null;
 //We have a two level cache: 1. application, 2. memCache
 try {
  rootHandlerFn=(IFn) application.getAttribute("RootHandlerFn");
 } catch ( Exception e1) {
  try {
   rootHandlerFn=(IFn) memCache.get("RootHandlerFn");
  } catch ( Exception e2) {
    //we will load it below.
  }
 }
 String code=null;
 if (rootHandlerFn==null || "yes".equals( request.getParameter("reloadRootHandler"))) {
  Entity e=null;
  Key rhKey=null;
  try {
   e= service.get(bootStrapKey);
   rhKey=(Key) e.getProperty("rootHandler");
   e= service.get(rhKey);
   code=((Text) e.getProperty("content")).getValue();
  } catch (EntityNotFoundException e3) { // was the datastore empty?
   //RT.loadResourceScript("mind/loader.clj");
   InputStream lis=RT.baseLoader().getResourceAsStream("mind/loader.clj");
   PushbackReader lpr = new PushbackReader(new InputStreamReader(lis));
   IFn loaderFn=(IFn) Compiler.eval( LispReader.read( lpr, true, null, false));
   loaderFn.invoke();
   code="(fn [request response] \"HelloWorld\")";
  }
  PushbackReader pr = new PushbackReader(new StringReader(code));
  Object rootHandlerExpr=LispReader.read( pr, true, null, false);
  rootHandlerFn=(IFn) Compiler.eval( rootHandlerExpr);
  application.setAttribute("RootHandlerFn", rootHandlerFn);
  memCache.put("RootHandlerFn", rootHandlerFn);
 }
%><%=rootHandlerFn.invoke(request,response)%>