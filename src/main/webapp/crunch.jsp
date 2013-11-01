<%@page import="
java.io.File,
java.util.Vector,
com.almworks.sqlite4java.*"%><%
  SQLiteConnection db = new SQLiteConnection(new File("/home/rawa/tmpsql/cub"));
  db.open(true);

  SQLiteStatement st;

  long cube=new Long(request.getParameter("cube"));
 
  Vector path=new Vector();
  long currCube=cube;
  String[] childNames={"c000","c001","c010","c011","c100","c101","c110","c111"};
  int relLevel=0;
  long[] pos={0,0,0};
  while (1!=currCube) {

   st = db.prepare("select id,c000,c001,c010,c011,c100,c101,c110,c111 from cube where "+
    "c000="+currCube+" or "+
    "c001="+currCube+" or "+
    "c010="+currCube+" or "+
    "c011="+currCube+" or "+
    "c100="+currCube+" or "+
    "c101="+currCube+" or "+
    "c110="+currCube+" or "+
    "c111="+currCube);
   st.step();
   for(int i=0;i<8;i++) {
    if(!st.columnNull(i+1)) {
     if(st.columnLong(i+1)==currCube) {
      for(int j=0;j<3;j++) {
       if("1".equals(childNames[i].substring(j+1,j+2))) {
        pos[j]+=Math.pow(2,relLevel);
       }
      }
       %> <%=childNames[i]%> <%
     }
    }
   }
   currCube=st.columnLong(0);
   path.add(currCube);
   relLevel++;
  }
 double cubeLen=Math.pow(2,24-relLevel);
%> <br/>cubeLen <%=cubeLen%> m<%
 for (int j=0;j<3;j++) {
  pos[j]=pos[j]*(long)Math.pow(2,24-relLevel)-(long)Math.pow(2,23);
 }
 %><br/><%=currCube%> <%=pos[0]%> <%=pos[1]%> <%=pos[2]%> <br/>

<%! public double[] ecefToLla( double x, double y, double z) {
  double a = 6378137;
  double e = 8.1819190842622e-2;
  double esq = Math.pow(e,2);
  double SingularMeridian=13.7414;

  double b = Math.sqrt(Math.pow(a, 2) * (1 - Math.pow(e, 2)));
  double ep = Math.sqrt((Math.pow(a, 2) - Math.pow(b, 2)) / Math.pow(b, 2));
  double p = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
  double th = Math.atan2(a * z, b * p);
  double lon = Math.atan2(y, x);
  double lat = Math.atan2((z + Math.pow(ep, 2) * b * Math.pow(Math.sin(th), 3)),
         (p - Math.pow(e, 2) * a * Math.pow(Math.cos(th), 3)));
  double N = a / (Math.sqrt(1 - Math.pow(e, 2) * Math.pow(Math.sin(lat), 2)));
  double alt = p / Math.cos(lat) - N;

  lon = lon % (2 * Math.PI);

  if ( Math.abs(x) < 1.0 && Math.abs(y) < 1.0) {
   alt = Math.abs(z) - b;
  }

  lat = lat * 180 / Math.PI;
  lon = lon * 180 / Math.PI + SingularMeridian;
  double[] ret= {lat,lon,alt};
  return ret;
}%>

<br/>lla:
 <%=ecefToLla(pos[0],pos[1],pos[2])[0]%> 
 <%=ecefToLla(pos[0],pos[1],pos[2])[1]%>
 <%=ecefToLla(pos[0],pos[1],pos[2])[2]%>  
 
<%
  st = db.prepare("select * from cube where "+
    "c000 is null and "+
    "c001 is null and "+
    "c010 is null and "+
    "c011 is null and "+
    "c100 is null and "+
    "c101 is null and "+
    "c110 is null and "+
    "c111 is null and id="+cube);


 int idCt=8417;
 for(int x=0;x<2;x++) {
  for(int y=0;y<2;y++) {
   for(int z=0;z<2;z++) {
    boolean allCrust=true;
    String childName="c"+x+y+z;
    for(int xi=0;xi<2;xi++) {
     for(int yi=0;yi<2;yi++) {
      for(int zi=0;zi<2;zi++) {
       double alt= ecefToLla(
        pos[0]+cubeLen/2*x+cubeLen/2*xi,
        pos[1]+cubeLen/2*y+cubeLen/2*yi,
        pos[2]+cubeLen/2*x+cubeLen/2*zi)[2]; 
       allCrust=allCrust && alt<0;
//     allCrust=allCrust && ecefToLla(pos[0]+cubeLen/4*xi,pos[1]+cubeLen/4*yi,pos[2]+cubeLen/4*zi)[2]<0;
//       allCrust=allCrust && ecefToLla(pos[0]+cubeLen/4*xi,pos[1]+cubeLen/4*yi,pos[2]+cubeLen/4*zi)[2]<0;
//    allCrust=allCrust && ecefToLla(pos[0]+cubeLen/2*x)[3]<0;
  //  allCrust=allCrust && ecefToLla(pos[0]+cubeLen/2*x)[3]<0;
      }
     }
    }
    %><br/>insert into cube (id,material) values (<%=idCt%>,<%=allCrust?7:1%>); <%
    %><br/>update cube set <%=childName%>=<%=idCt%> where id=<%=cube%>;<%
    idCt++;
    if (allCrust) {
    }
   }
  }
 }
   if (!st.step() ) {
 %><br/>ChildrenExist!<%
    return;
   }
%>