<html>
 <head>
  <title>DigitalEarth</title>
  <script src="DigitalPlanetOne.js"></script>
 </head>
 <body style="font-family:Arial;background-color:#aaa">
<script>
console.log(
 Object.keys(cubes).length
);
 for(var node in cubes) {
  if (!cubes[node].CreatedAt) {
   console.log('Nnode: '+node);
  }
 }

 //maps old AppEngine ids to shorter new ones
 var keyMap={};
 var idCt=1;

 function mapKey(id) {
  var key=keyMap[id];
  if(key) {
   return key;
  }
  keyMap[id]=idCt;
  idCt++;
  return keyMap[id];
 }

 //const
 var childNames=['c000','c001','c010','c011','c100','c101','c110','c111'];
 var keys=Object.keys(cubes).sort(function(a,b){
 return cubes[a].CreatedAt-cubes[b].CreatedAt});

 var sql='PRAGMA foreign_keys = ON;\n';
 sql+='create table SocialProfile (id integer primary key,identifier varchar(255));\n';
 sql+='insert into SocialProfile values (1,"https://www.google.com/profiles/104902405791729007647");\n';
 sql+='create table cube (id integer primary key,'+
  'material byte, CreatedAt int, CreatedBy int,'+
  'LastEditAt int, LastEditBy int,'+
  'c000 int,c001 int,c010 int,c011 int,c100 int,c101 int,c110 int,c111 int,'+
  'AppEngineId,\n'+
  'FOREIGN KEY(CreatedBy) REFERENCES SocialProfile(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(LastEditBy) REFERENCES SocialProfile(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c000) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c001) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c010) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c011) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c100) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c101) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c110) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED,\n'+
  'FOREIGN KEY(c111) REFERENCES cube(id) DEFERRABLE INITIALLY DEFERRED);\n';
 sql+='begin;\n';
 //sql+="insert into cube (CreatedAt,id,material,CreatedAt,CreatedBy,LastEditAt,LastEditBy,";
 //sql+="c000,c001,c010,c011, c100,c101,c110,c111,AppEngineId) values\n";
 for(var i=0; i<keys.length; i++) {
  keyMap[keys[i]]=i+1;
 }
 for(var i=0; i<keys.length; i++) {
  sql+="insert into cube values ";
  var c=cubes[keys[i]];
  //for(var node in keys) {
  //console.log(keys[i]+': '+new Date(c.CreatedAt));
  //sql+=new Date(cubes[keys[i]].CreatedAt);
  sql+='('+mapKey(keys[i])+','+c.material+','+c.CreatedAt+',1,';
  sql+=c.LastEditAt?c.LastEditAt:c.CreatedAt;
  sql+=',1,';
  for(var j=0; j<8; j++) {
   var child=keyMap[c[childNames[j]]];
   sql+=child?child:'null';
   //sql+=j==7?'':',';
   sql+=',';
  }
  sql+=keys[i]+')';
  //sql+=(i==keys.length-1)?'':',';
  sql+=';\n';
 }
 sql+='commit;\n';
 console.log(sql);
</script>
 </body>
</html>
