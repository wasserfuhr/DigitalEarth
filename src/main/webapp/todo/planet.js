/*
VoWe
WipperFeld
Prohi
*/
 var ocTree=cubes;
 var root=UrCube;
 goog.require('goog.async.Delay');
 goog.require('goog.net.XhrIo');
 goog.require('goog.structs.Map');
 goog.require('goog.Uri.QueryData');

 //prevent older browsers like FireFox 3.6.13 from complaining
 function log(msg) {
  try {
   console.log(msg);
  } catch(e) {
  }
 }

 function modulo(v,pow) {
  return (v>>pow)<<pow;
 } 
log(root);
 var currParent=root;
 var currMaterial=2;
 var parentColumn='c111';
 var currNode=ocTree[root].parentColumn;
 var cursorLevel=23; // cube with size of 2^cursorLevel meter
 var zoomLevel=0;
 //const
 var baseDiff=Math.pow(2,cursorLevel);
 var levelLen=baseDiff;
 var rotX=0;
 var rotY=0;
 var rotZ=0;
 var cursorPos=[0,0,0]; // in meter
 //const
 var childNames=['c000','c001','c010','c011','c100','c101','c110','c111'];
 //const
 var pane=document.getElementById('pane');
 //const
 var ctx=pane.getContext('2d');
 //const
 var xBox=document.getElementById('xBox').getContext('2d');
 //const
 var yBox=document.getElementById('yBox').getContext('2d');
 //const
 var zBox=document.getElementById('zBox').getContext('2d');
 // fit 2^24=16777216 m on 160px:
 var meterPerPixel=55000;
 //const
 var SingularMeridian=13.7414;
 //const
 var materials={
  1:{r:20, g:20 ,b:20, name:'air'},
  2:{r:40, g:40 ,b:200,name:'water'},
  3:{r:40, g:220,b:20 ,name:'green'},
  4:{r:240,g:220,b:20 ,name:'desert'},
  5:{r:240,g:220,b:220,name:'ice'},
  6:{r:240,g:40 ,b:20 ,name:'urban'},
  7:{r:156,g:90 ,b:60 ,name:'crust'},
  8:{r:245,g:200,b:150,name:'LimeStone'},
  9:{r:245,g:220,b:150,name:'SandStone'},
  10:{r:40,g:40, b:40, name:'iron'},
  11:{r:240,g:220,b:20,name:'gold'},
 /* ToDo: https://en.wikipedia.org/wiki/Structure_of_the_Earth :
  1. continental crust – 2. oceanic crust – 3. upper mantle – 4. lower mantle – 5. outer core – 6. inner core –
 */
 };
 var recentMaterials=[1,2,3,4,5,6,7,8,9,10,11];
 var recentMaterialsPos=0;

 function setMaterial() {
  var col='rgb('+
   materials[currMaterial].r+','+
   materials[currMaterial].g+','+
   materials[currMaterial].b+')';
  document.getElementById('selectedMaterial').style.backgroundColor=col;
  document.getElementById('selectedMaterialName').innerHTML=materials[currMaterial].name;
 }

 function selectedMaterial(mat) {
  currMaterial=mat.id.substring(3);
  recentMaterials=[currMaterial].concat(recentMaterials);
  recentMaterialsPos=0;
  document.getElementById('selectMaterial').style.display='none';
  document.getElementById('palette').style.display='block';
  setMaterial();
 }

 function selectMaterial() {
  var t=document.getElementById('selectMaterial').style;
  t.display='block';
  t=document.getElementById('palette').style.display='none';
 }

 function toggleMaterial(m) {
  var mat=m.id.substring(7);
  var allM=document.getElementById('showMatAll');
  if ('All'==mat) {
   for(var m in materials) {
    if('air'!=materials[m].name) {
     document.getElementById('showMat'+m).checked=allM.checked;
    }
   }
  } else {
   var allChecked=false;
   for(var m in materials) {
    if('air'!=materials[m].name) {
     allChecked=allChecked&&document.getElementById('showMat'+m).checked;
    }
   }
   allM.checked=allChecked;
  }
  draw();
 }

 var animStage;
 var animTarget;

 function animate() {
  var delay=500;
  if(0==animStage) {
   if(zoomLevel>0) { // zoom out
    zoomLevel--;
   } else {
    animStage++;
   }
  }
  if(1==animStage) { //rotate
   delay=800;
   if (rotZ>0) {
    rotZ=(rotZ-1)%4;
   } else {
    animStage++;
   }
  }
  if(2==animStage) {
   //if(zoomLevel<15) { // zoom in
   delay=100;
   if(meterPerPixel>10000) { // zoom in
    //zoomLevel++;
    meterPerPixel-=5000;
   } else {
    cursorPos[0]=4016256;
    cursorPos[1]=0;
    cursorPos[2]=4938304;
    cursorLevel=8;
    zoomLevel=8;
    currNode=225048;
    draw();
    return;
   }
  }
  draw();
  var delay = new goog.async.Delay(animate, delay);
  delay.start();
 }
/*
URGENT!: TerraChallenge
(16384-8416)*1000/(1383073200000-new Date().getTime())
*/

 var landmarks={
  'CristoRedentor' :{lat:-22.95194, lon:-43.21056, alt:700},
  'GoldRider'      :{lat: 29.97917, lon: 31.13435, alt:110},
  'GreatPyramid'   :{lat: 29.97917, lon: 31.13435, alt: 30},
  'IlColosseo'     :{lat: 41.89017, lon: 12.49227, alt:161}, // https://www.facebook.com/pages/Colosseum/106151256083561
  'LockSchuppen'   :{lat: 51.06713, lon: 13.74147, alt:120},
  'StatueOfLiberty':{lat: 40.68917, lon:-74.04444, alt: 20},
  'TourEiffel'     :{lat: 40.68917, lon:-74.04444, alt: 30},
 }//ToDo: AyersRock FluegelAuto GranPiramide KreuzKirche SecretCity

 function warn(s) {
  alert(s);
 }

 function hot(hot) {
  animStage=0;
  animTarget=hot;
  animate();
  return false;
 }

 //http://www.daveoncode.com/2009/11/17/goog-net-xhrio-make-simple-ajax-calls-with-google-closure/
 function remoteAdd() {
  document.getElementById('node').innerHTML='*creating...*';
  var request = new goog.net.XhrIo();
  var data = goog.Uri.QueryData.createFromMap(new goog.structs.Map({
   op: 'addChild',
   node: currParent,
   child: parentColumn,
   material: currMaterial}));

  goog.events.listen(request, 'complete', function() {
   if (request.isSuccess()) {
    var json=request.getResponseJson();
    log(json);
    if ('error'==json.status) {
     log("Server failed: "+ request.getStatusText());
    } else {
     currNode=json.newId;
     ocTree[currParent][parentColumn] = currNode;
     document.getElementById('node').innerHTML=currNode;
     ocTree[currNode] = {
      material: currMaterial,
      parent: currParent};
     draw();
    }
   } else {
    log("Server failed: "+ request.getStatusText());
   }
  });
  request.send('/earthOp?', 'POST', data.toString());
  return false;
 }

 function remoteSet() {
  document.getElementById('material').innerHTML='...';
  var request = new goog.net.XhrIo();
  var data = goog.Uri.QueryData.createFromMap(new goog.structs.Map({
   op: 'set',
   node: currNode,
   material: ocTree[currNode].material}));

  goog.events.listen(request, 'complete', function() {
   if (request.isSuccess()) {
    var json=request.getResponseJson();
    //log(json);
    if ('error'==json.status) {
     warn("Server failed: "+ request.getStatusText());
     //ToDo
    } else {
     draw();
    }
   } else {
    warn("Server failed: "+ request.getStatusText());
    //alert("Server failed: "+ request.getResponseText());
   }
  });
  request.send('/earthOp?', 'POST', data.toString());
  return false;
 }

 function rotColName(xi,yi,zi) {
  var cName='c'+xi+''+yi+''+zi;
  if (rotZ==1) {
   cName='c'+yi+''+(1-xi)+''+zi;      
  }
  if (rotZ==2) {
   cName='c'+(1-xi)+''+(1-yi)+''+zi;      
  }
  if (rotZ==3) {
   cName='c'+(1-yi)+''+(xi)+''+zi;      
  }
  return cName;
 }

 function drawTreeNode(node,x,y,z,level) {
  if(ocTree[node]) {
   if (ocTree[node].hidden) {
    return;
   }
   if(!materials[ocTree[node].material]) {
    log("Missing material "+ocTree[node].material+" for "+ node);
    return;
   }
   var m=document.getElementById('showMat'+ocTree[node].material);
   if(m && !m.checked) {
    return;
   }
  }
  var len=Math.pow(2,level);
  var len2=Math.pow(2,level-1);
  for(var xi=0;xi<2;xi++) {
   for(var yi=0;yi<2;yi++) {
    for(var zi=0;zi<2;zi++) {
     if (!ocTree[node]) {
      ocTree[node]={material:1};
     }
     ocTree[node].parent=node;
     var c=ocTree[node][rotColName(xi,yi,zi)];
     if (c) {
      drawTreeNode(c,x+len/2*xi,y+len/2*yi,z+len/2*zi,level-1);
     }
    }
   }
  }
  ctx.lineWidth=0.2;
  if(1==ocTree[node].material) { //air=transparent
   ctx.strokeStyle='#EEE';
   if (level==24) {
     ctx.lineWidth=2;
   } else {
     ctx.lineWidth=0.2;
   }
   //drawCube(x,y,z,len);
  } else {
   var isCursor=
    (x>=cursorPos[0]) && (x+len <= cursorPos[0]+levelLen) &&
    (y>=cursorPos[1]) && (y+len <= cursorPos[1]+levelLen) &&
    (z>=cursorPos[2]) && (z+len <= cursorPos[2]+levelLen);
   drawCube(x,y,z,len,materials[ocTree[node].material],isCursor);
  }
 }

 function drawTree() {
  drawTreeNode(root,-baseDiff,-baseDiff,-baseDiff,24);
 }

 function drawEarth() {
  ctx.lineWidth=2;
  ctx.strokeStyle='#666';
  drawCube(-baseDiff,-baseDiff,-baseDiff,2*baseDiff);
  ctx.strokeStyle='#ccc';
  ctx.lineWidth=0.4;
  drawCube(-baseDiff,-baseDiff,-baseDiff,baseDiff);
  drawBBox(-baseDiff,-baseDiff,-baseDiff,baseDiff,-baseDiff,-baseDiff);
  drawBBox(-baseDiff,-baseDiff,-baseDiff,-baseDiff,baseDiff,-baseDiff);
  drawBBox(-baseDiff,-baseDiff,0,-baseDiff,baseDiff,0);
  drawBBox(-baseDiff,-baseDiff,-baseDiff,-baseDiff,-baseDiff,baseDiff);
  drawBBox(0,0,-baseDiff,0,baseDiff,-baseDiff);
  drawCube(0,-baseDiff,-baseDiff,baseDiff);
  drawCube(-baseDiff,-baseDiff,0,baseDiff);
  drawCube(-baseDiff,-baseDiff,0,baseDiff);
  drawCube(0,0,-baseDiff,baseDiff);
  drawCube(-baseDiff,0,0,baseDiff);
  drawCube(0,0,0,baseDiff);
  drawCube(0,-baseDiff,-baseDiff,baseDiff);
  drawCube(0,0,0,baseDiff);
  ctx.fillStyle='#8080ff';
  ctx.beginPath();
  var rad=6300000.0;
  var radScale=80;
  ctx.moveTo(posX(0),posY(0));
  for (var i=0; i<360; i++) {
   ctx.moveTo(posX(i),posY(i));
  }
  //ctx.closePath();
  //ctx.stroke();
 }

 function nodeOfCursor(node,x,y,z,level) {
  level2=Math.pow(2,level-1);
  var xi=0;
  if (x>=level2) {
   xi=1;
   x-=level2;
  }
  var yi=0;
  if (y>=level2) {
   yi=1;
   y-=level2;
  }
  var zi=0;
  if (z>=level2) {
   zi=1;
   z-=level2;
  }
  var col=rotColName(xi,yi,zi);
  parentColumn=col;
  if(level==cursorLevel) {
   currNode=node;
   return;
  }
  var c= ocTree[node][col];
  currParent=node;
  if (c) {
   nodeOfCursor(c, x,y,z, level-1);
  } else {
   currNode=null;
  }
 }

 function keyHandler(event) {
  //log((event.shiftKey?"SH":"")+event.keyCode);
  var base=Math.pow(2,cursorLevel);
  if (event.keyCode==13) { //RET
   if(ocTree[currNode]) {
    ocTree[currNode].material=currMaterial;
    remoteSet();
    changed=true;
   } else {
    remoteAdd();
   }
  }
  //if (event.keyCode==32) { } //SPACE
  if (event.keyCode==37) { //left
    if (event.shiftKey) {
     cursorLevel--; //level down
     levelLen=Math.pow(2,cursorLevel);;
     var diff=Math.pow(2,cursorLevel);
     cursorPos[0]+=diff;
     cursorPos[1]+=diff;
     cursorPos[2]+=diff;
     draw();
    } else {
     if (cursorPos[1]> -Math.pow(2,23)) {
      cursorPos[1]-=base; //Y down
      draw();
     }
    }
  }
  if (event.keyCode==38) { //up
   if (event.shiftKey) {
    if (cursorPos[0]> -Math.pow(2,23)) {
     cursorPos[0]-=base; //X down
     draw();
    }
   } else {
    if (cursorPos[2]+base<Math.pow(2,23)) {
     cursorPos[2]+=base; //Z up
     draw();
    }
   }
  }
  if (event.keyCode==39) { //right
   if (event.shiftKey) { //level up
    if (cursorLevel<23) {
     cursorLevel++;
     levelLen=Math.pow(2,cursorLevel);
     cursorPos[0]= modulo(cursorPos[0],cursorLevel);
     cursorPos[1]= modulo(cursorPos[1],cursorLevel);
     cursorPos[2]= modulo(cursorPos[2],cursorLevel);
     //currNode=ocTree[currNode]['parent'];
     draw();
    }
   } else { //Y up
    if (cursorPos[1]+base<Math.pow(2,23)) {
     cursorPos[1]+=base;
     draw();
    }
   }
  }
  if (event.keyCode==40) { //down
   if (event.shiftKey) { //X up
    if (cursorPos[0]+base<Math.pow(2,23)) {
     cursorPos[0]+=base; 
     draw();
    }
   } else { //Z down
    if (cursorPos[2]> -Math.pow(2,23)) {
     cursorPos[2]-=base; 
     draw();
    }
   }
  }
  //if (event.keyCode==46) { } //DEL
  if (event.keyCode==82) { //'r'
   if (event.shiftKey) {
    rotZ=(rotZ+3)%4;
   } else {
    rotZ=(rotZ+1)%4;
   }
   draw();
  }
  if (event.keyCode==72) { //'h'
   var isHidden=ocTree[currNode].hidden;
   if (event.shiftKey) {
    for(var node in ocTree) {
     ocTree[node].hidden=false;
    }
   } else {
    ocTree[currNode].hidden=!isHidden;
   }
   draw();
  }
  if (event.keyCode==77) { //m
   recentMaterialsPos++;
   if(recentMaterialsPos>=recentMaterials.length) {
    recentMaterialsPos=0;
   }
   currMaterial=recentMaterials[recentMaterialsPos];
   setMaterial();
  }
  if (event.keyCode==187) { //'+'
   zoomLevel++;
   draw();
  }
  if (event.keyCode==189) { //'-'
   zoomLevel--;
   draw();
  }
 }

 function drawXYZ() {
  // see http://wiki.blender.org/index.php/Doc:2.4/Manual/3D_interaction/Transform_Control/Axis_Locking
  // X:
  var xOff=10;
  var yOff=10;
  ctx.fillStyle='red';
  ctx.strokeStyle='red';
  ctx.beginPath();
  ctx.moveTo(xOff+80,yOff+60);
  ctx.lineTo(xOff+70,yOff+70);
  ctx.stroke();
  ctx.fillText('x',xOff+65,yOff+70);
  // Y:
  ctx.fillStyle='green';
  ctx.strokeStyle='green';
  ctx.beginPath();
  ctx.moveTo(xOff+80,yOff+60);
  ctx.lineTo(xOff+100,yOff+60);
  ctx.stroke();
  ctx.fillText('y',xOff+100,yOff+55);
  // Z:
  ctx.fillStyle='blue';
  ctx.strokeStyle='blue';
  ctx.beginPath();
  ctx.moveTo(xOff+80,yOff+60);
  ctx.lineTo(xOff+80,yOff+40);
  ctx.stroke();
  ctx.fillText('z',xOff+83,yOff+50);
 }

 function pureIsoX(x,y,z) {
  return (y-x/2)/meterPerPixel*Math.pow(2,zoomLevel);
 }

 var xOff=270;
 function isoX(x,y,z) {
  return xOff+pureIsoX(x,y,z);
 }

 function pureIsoY(x,y,z) {
  return (x/2-z)/meterPerPixel*Math.pow(2,zoomLevel);
 }

 var yOff=250;
 function isoY(x,y,z) {
  return yOff+pureIsoY(x,y,z);
 }

 function drawBBox(xi,yi,zi,xo,yo,zo) {
  //top
  ctx.beginPath();
  ctx.moveTo(isoX(xo,yi,zo),isoY(xo,yi,zo));
  ctx.lineTo(isoX(xi,yi,zo),isoY(xi,yi,zo));
  ctx.lineTo(isoX(xi,yo,zo),isoY(xi,yo,zo));
  ctx.lineTo(isoX(xo,yo,zo),isoY(xo,yo,zo));
  ctx.closePath();
  ctx.stroke();
  //front
  ctx.beginPath();
  ctx.moveTo(isoX(xo,yi,zi),isoY(xo,yi,zi));
  ctx.lineTo(isoX(xo,yi,zo),isoY(xo,yi,zo));
  ctx.lineTo(isoX(xo,yo,zo),isoY(xo,yo,zo));
  ctx.lineTo(isoX(xo,yo,zi),isoY(xo,yo,zi));
  ctx.closePath();
  ctx.stroke();
  //right
  ctx.beginPath();
  ctx.moveTo(isoX(xo,yo,zo),isoY(xo,yo,zo));
  ctx.lineTo(isoX(xi,yo,zo),isoY(xi,yo,zo));
  ctx.lineTo(isoX(xi,yo,zi),isoY(xi,yo,zi));
  ctx.lineTo(isoX(xo,yo,zi),isoY(xo,yo,zi));
  ctx.closePath();
  ctx.stroke();
 }

 function drawCube(xi,yi,zi,len,fill,isCursor) {
  var x=isoX(xi,yi,zi);
  var y=isoY(xi,yi,zi);
  var l=len/meterPerPixel/2*Math.pow(2,zoomLevel);
  //top
  ctx.beginPath();
  ctx.moveTo(x-l,  y-l);
  ctx.lineTo(x,    y-2*l);
  ctx.lineTo(x+2*l,y-2*l);
  ctx.lineTo(x+l,y-l);
  ctx.closePath();
  var highlight=isCursor?30:0;
  ctx.stroke();
  if (fill) {
   ctx.fillStyle='rgb('+
    Math.max(0,fill.r-20+highlight)+','+
    Math.max(0,fill.g-20+highlight)+','+
    Math.max(0,fill.b-0+highlight)+')';
   ctx.fill();
  }
  //front
  ctx.beginPath();
  ctx.moveTo(x-l,y-l);
  ctx.lineTo(x+l,y-l);
  ctx.lineTo(x+l,y+l);
  ctx.lineTo(x-l,y+l);
  ctx.closePath();
  ctx.stroke();
  if (fill) {
   ctx.fillStyle='rgb('+
    Math.max(0,fill.r-0+highlight)+','+
    Math.max(0,fill.g-0+highlight)+','+
    Math.max(0,fill.b-0+highlight)+')';
   ctx.fill();
  }
  //right
  ctx.beginPath();
  ctx.moveTo(x+l,y-l);
  ctx.lineTo(x+2*l,y-2*l);
  ctx.lineTo(x+2*l,y);
  ctx.lineTo(x+l,y+l);
  ctx.closePath();
  ctx.stroke();
  if (fill) {
   ctx.fillStyle='rgb('+
    Math.max(0,fill.r-40+highlight)+','+
    Math.max(0,fill.g-30+highlight)+','+
    Math.max(0,fill.b-30+highlight)+')';
   ctx.fill();
  }
 }

 function addDiffTree(t) {
  var newCt=0;
  var updateCt=0;
  for(var cube in t) {
   if (ocTree[cube]) {
    updateCt++;
   } else {
    newCt++;
   }
   ocTree[cube]=t[cube];
  }
  log('added RecentCubes: '+ newCt + ' added, '+ updateCt+' updated');
 }

 function expandProperties() {
  //addDiffTree(diffTree);
  //addDiffTree(diffTree2);
  for(var node in ocTree) {
   ocTree[node].hidden=false;
   ocTree[node].material=ocTree[node].m;
   if( ocTree[node]['c']) {
    for( var i=0; i<8; i++) {
     if( ocTree[node]['c'][i]>0) {
      ocTree[node][childNames[i]]=ocTree[node]['c'][i];
     }
    }
   }
  }
 }
 expandProperties();

 function countChildren(node) {
  if(!ocTree[node]) {
   log("missing "+node);
   return;
  }
  ocTree[node].childCount=0;
  for(var i=0; i<8; i++) {
   var child=ocTree[node][childNames[i]];
   if (child) {
    ocTree[node].childCount++;
    ocTree[node].childCount+=countChildren(child);
   }
  }
  return ocTree[node].childCount;
 }
 countChildren(root);

 function findOrphanes() {
  for(var node in ocTree) {
   for(var i=0; i<8; i++) {
    var child=ocTree[node][childNames[i]];
    if (child) {
     if (ocTree[child]) {
      ocTree[child].parent=node;
     } else {
      log('*WARNING*: missing node: '+child);
     }
    }
   }
  }
  for(var node in ocTree) {
   if (! ocTree[node].parent && node != root) {
    log('*WARNING*: Orphan: '+node);
   }
  }
 }

 function drawCursorCube() {
  var len=Math.pow(2,cursorLevel);
  ctx.lineWidth=2;
  ctx.strokeStyle='#fff';
  drawCube(
   cursorPos[0], cursorPos[1], cursorPos[2], len);
  for(var i=0;i<23;i++) {
   if(cursorLevel<23-i) {
    ctx.lineWidth=2-i/5;
    ctx.strokeStyle='rgb('+(255-i*8)+','+(255-i*8)+','+(255-i*8)+')';
    drawCube(
     modulo(cursorPos[0],cursorLevel+i+1),
     modulo(cursorPos[1],cursorLevel+i+1),
     modulo(cursorPos[2],cursorLevel+i+1), len*Math.pow(2,i+1));
   }
  }
 }

 function drawCursor() {
  var len=Math.pow(2,cursorLevel);
  var lenS=(len<1000)?len+' m':(len/1000).toFixed(2)+' km';
  document.getElementById('size').innerHTML='2^'+cursorLevel+' m = '+lenS;
  ctx.strokeStyle='#888';
  ctx.lineWidth=1;
  ctx.strokeStyle='#f00';
  drawBBox(
   -baseDiff, cursorPos[1], cursorPos[2],
    baseDiff, cursorPos[1]+len, cursorPos[2]+len);
  ctx.strokeStyle='#0f0';
  drawBBox(
   cursorPos[0],    -baseDiff, cursorPos[2],
   cursorPos[0]+len, baseDiff, cursorPos[2]+len);
  ctx.strokeStyle='#00f';
  drawBBox(
   cursorPos[0],     cursorPos[1],    -baseDiff,
   cursorPos[0]+len, cursorPos[1]+len, baseDiff);
  drawCursorCube();
  var i=document.getElementById('info');
  i.innerHTML='['+cursorPos[0]+','+cursorPos[1]+','+cursorPos[2]+'] to';
  i=document.getElementById('infoTo');
  i.innerHTML='&nbsp;['+(cursorPos[0]+len)+','+(cursorPos[1]+len)+','+(cursorPos[2]+len)+']';
  document.getElementById('cubeCount').innerHTML=Object.keys(ocTree).length;
  document.getElementById('node').innerHTML=currNode?currNode:'*undefined*';
  document.getElementById('parent').innerHTML=currParent+' (as '+parentColumn+')';
  var cct=0;
  if (currNode) {
   var m=ocTree[currNode].material;
   if (m) {
    document.getElementById('material').innerHTML=materials[m].name;
    for(var i=0;i<8;i++) {
     if (ocTree[currNode][childNames[i]]) {
      cct++
     }
    }
   } else {
    log('missing material for '+currNode);
   }
   document.getElementById('allChildCount').innerHTML=ocTree[currNode].childCount;
  }
  document.getElementById('childCount').innerHTML=cct;
  drawInfo();
 }

 //const
 var a = 6378137;
 //const
 var e = 8.1819190842622e-2;
 var esq = Math.pow(e,2);

 //https://gist.github.com/klucar/1536194
 function llaToEcef(lat,lon,alt) {
  var N = a / Math.sqrt(1 - esq * Math.pow(Math.sin(lat),2));
  var x = (N+alt) * Math.cos(lat) * Math.cos(lon);
  var y = (N+alt) * Math.cos(lat) * Math.sin(lon);
  var z = ((1-esq) * N + alt) * Math.sin(lat);
  return [x, y, z];
 }

 function ecefToLla(x,y,z) {
  // via https://gist.github.com/klucar/1536194 and
  // http://www.gal-systems.com/2011/09/convert-coordinates-from-ecef-to.html :
  var b = Math.sqrt(Math.pow(a, 2) * (1 - Math.pow(e, 2)));
  var ep = Math.sqrt((Math.pow(a, 2) - Math.pow(b, 2)) / Math.pow(b, 2));
  var p = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
  var th = Math.atan2(a * z, b * p);
  var lon = Math.atan2(y, x);
  var lat = Math.atan2((z + Math.pow(ep, 2) * b * Math.pow(Math.sin(th), 3)),
         (p - Math.pow(e, 2) * a * Math.pow(Math.cos(th), 3)));
  var N = a / (Math.sqrt(1 - Math.pow(e, 2) * Math.pow(Math.sin(lat), 2)));
  var alt = p / Math.cos(lat) - N;

  lon = lon % (2 * Math.PI);

  if ( Math.abs(x) < 1.0 && Math.abs(y) < 1.0) {
   alt = Math.abs(z) - b;
  }

  lat = lat * 180 / Math.PI;
  lon = lon * 180 / Math.PI + SingularMeridian-rotZ*90;
  return [lat, lon, alt];
 }

 function drawInfo() {
  var center=Math.pow(2,cursorLevel-1);
  var x=cursorPos[0]+center;
  var y=cursorPos[1]+center;
  var z=cursorPos[2]+center;
  var ecef=ecefToLla(x,y,z);
  var lat=ecef[0];
  var lon=ecef[1];
  var alt=ecef[2];
  var latS=Math.abs(lat).toFixed(2)+'&deg;'+((lat<0)?'S':'N');
  var lonS=Math.abs(lon).toFixed(2)+'&deg;'+((lon<0)?'W':'E');
  var altS;
  if (Math.abs(alt)<1000) {
   altS=Math.abs(alt).toFixed(2)+' m';
  } else {
   altS=(Math.abs(alt)/1000).toFixed(2)+' km';
  }
  // http://wiki.openstreetmap.org/wiki/Static_map_images
  var imgBase='http://pafciu17.dev.openstreetmap.org/?module=map&width=260&height=250&';
  imgBase+='&zoom='+(24-cursorLevel);
  imgBase+='&lat='+lat;
  imgBase+='&lon='+lon;
  document.getElementById('img').src=imgBase;
  document.getElementById('pos').innerHTML=latS+' '+lonS+' '+((alt<0)?'-':'+')+altS;
  document.getElementById('spinner').style.zIndex=2;
  document.getElementById('osm').href='https://www.openstreetmap.org/?'+
   'mlat='+lat+'&'+
   'mlon='+lon+'&'+
   'zoom='+Math.min(18,(24-cursorLevel));
 }

 var boxSize=document.getElementById('xBox').width;

 // https://en.wikipedia.org/wiki/Earth_radius
 var rEarth=6371000.8; // ToDo: add ellipsoid

 function drawCutArc(box,dist,p1,p2) {
  // r^2+dist^2=rEarth^2
  var dDist=rEarth*rEarth-Math.pow(dist,2);
  // center relative to 50/50 and levelLen=80px
  if (dDist>0) {
   box.beginPath();
   var r=Math.sqrt(dDist)*(boxSize-20)/levelLen;
   box.arc(
    boxSize/2+(boxSize-20)*(p1+levelLen/2)/levelLen,
    boxSize/2+(boxSize-20)*(p2+levelLen/2)/levelLen,
    r,0,2*Math.PI);
   box.fill();
   box.strokeStyle='white';
   box.stroke();
  }
 }

 // how is the current cube cut by PlanetEarth?:
 function drawCutCircle(box,pos,p1,p2) {
  box.fillStyle='#000';
  box.fillRect(0,0,boxSize,boxSize);

  box.lineWidth=1;
  var sort=[
   {d:0,'c':'rgb(116,90,60)'},
   {d:Math.abs(pos),'c':'rgb(156,90,60)'},
   {d:Math.abs(pos+levelLen), 'c':'rgb(196,90,60)'}];
  sort.sort(function(a,b){return a['d']-b['d']});
  for( var i=0; i<3; i++) {
   box.fillStyle=sort[i]['c'];
   drawCutArc(box,sort[i]['d'], p1,p2);
  }
  box.strokeStyle='#fff';
  box.strokeRect(10,10,boxSize-20,boxSize-20);
 }

 var osmLoading=true;

 function osmLoaded() {
  document.getElementById('spinner').style.zIndex=-1;
 }

 function draw() {
  nodeOfCursor(root,
   cursorPos[0]+baseDiff,
   cursorPos[1]+baseDiff,
   cursorPos[2]+baseDiff,24);
  xOff=pane.width/2-pureIsoX(cursorPos[0],cursorPos[1],cursorPos[2]);
  yOff=pane.height/2-pureIsoY(cursorPos[0],cursorPos[1],cursorPos[2]);
  //main pane
  ctx.fillStyle='#000';
  ctx.fillRect(0,0,pane.width,pane.height);
  ctx.fillStyle='#444';
  ctx.font="160px Arial";
  ctx.fillText('Digital',110,150);
  ctx.fillText('Planet',200,450);
  ctx.font="16px Arial";

  //lower control pane:
  ctx.fillStyle='#aaa';
  //ctx.fillRect(2,302,230,16);

  drawCutCircle(xBox,cursorPos[0],cursorPos[1],cursorPos[2]);
  var box=xBox;
  box.font="16px Arial";
  box.lineWidth=2;

  box.fillStyle='green';
  box.strokeStyle='green';
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(60,40);
  box.stroke();
  box.fillText('y',55,55);
  box.fillStyle='blue';
  box.strokeStyle='blue';
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(40,20);
  box.stroke();
  box.fillText('z',45,30);

  drawCutCircle(yBox,cursorPos[1],cursorPos[0],cursorPos[2]);
  box=yBox;
  box.font="16px Arial";
  box.lineWidth=2;
  box.fillStyle='red';
  box.strokeStyle='red';
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(20,40);
  box.stroke();
  box.fillText('x',20,55);
  box.fillStyle='blue';
  box.strokeStyle='blue';
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(40,20);
  box.stroke();
  box.fillText('z',45,30);

  drawCutCircle(zBox,cursorPos[2],cursorPos[1],cursorPos[0]);
  box=zBox;
  box.font="16px Arial";
  box.fillStyle='green';
  box.strokeStyle='green';
  box.lineWidth=2;
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(60,40);
  box.stroke();
  box.fillText('y',60,55);
  box.fillStyle='red';
  box.strokeStyle='red';
  box.beginPath();
  box.moveTo(40,40);
  box.lineTo(40,60);
  box.stroke();
  box.fillText('x',45,65);

  drawEarth();
  drawTree();
  drawCursor();
  drawXYZ();
 }

 draw();

 document.onkeydown=keyHandler;

 findOrphanes();

 //ToDo

 // based on http://sl4.eu/wiki/SimplifiedLandPolygons plus PyShp:
 var shape=[
  [-221314.17945856444, 6565234.738303548],
  [-221457.3697195735, 6565590.933818393],
  [-220555.225434235, 6565682.084675092],
  [-220725.98953311297, 6565184.931190011],
  [-221314.17945856444, 6565234.738303548]];

 shape=[
  [-526864.129294976, 7464424.244210574],
  [-527244.1740365429, 7464540.668494733],
  [-527482.6203858217, 7465038.441399676],
  [-526979.0110094729, 7465000.679550971],
  [-526864.129294976, 7464424.244210574]];

 function mercatorToWgs(x,y) {
  //based on http://www.gal-systems.com/2011/07/convert-coordinates-between-web.html
  var num3 = x / 6378137.0;
  var num4 = num3 * 57.295779513082323;
  var num5 = Math.floor((num4 + 180.0) / 360.0);
  var lon = num4 - (num5 * 360.0);
  var num7 = 1.5707963267948966 - (2.0 * Math.atan(Math.exp((-1.0 * y) / 6378137.0)));
  lat = num7 * 57.295779513082323;
  return [lon,lat];
 }

 var ret="";
 for(var i=0;i<shape.length;i++) {
  ret+=mercatorToWgs(shape[i][0],shape[i][1])+"\n";
 }
 //alert(ret);

 function posX(deg) {
  return Math.sin(deg*Math.PI/180.0);   
 }

 function posY(deg) {
  return Math.cos(deg*Math.PI/180.0);
 }

 function toggleMenu(b) {
  id=b.id.substring(3);
  var t=document.getElementById('content'+id).style;
  if ('block'==t.display) {
   b.innerHTML='+';
   t.display='none';
  } else {
   b.innerHTML='-';
   t.display='block';
  }
 }

 // 
 // currently unused:
 //
 function click(event) {
 //http://stackoverflow.com/questions/9880279/how-do-i-add-a-simple-onclick-event-handler-to-a-canvas-element
  var x = event.pageX - pane.offsetLeft;
  var y = event.pageY - pane.offsetTop;
  if (x>0 && y>0) {
   log("click: "+x+" "+y);
  }
 }
pane.addEventListener('click',click,false);

 //initMaterials()
 for(var m in materials) {
  var col='rgb('+
   materials[m].r+','+
   materials[m].g+','+
   materials[m].b+')';
  document.getElementById('matName'+m).innerHTML=materials[m].name;
  document.getElementById('matColor'+m).style.backgroundColor=col;
  if('air'!=materials[m].name) {
   document.getElementById('showMatName'+m).innerHTML=materials[m].name;
   document.getElementById('showMatColor'+m).style.backgroundColor=col;
  }
 }

/*Point = function(lat,lon,opt_alt) {
  this.lat=lat;
  this.lon=lat;
  this.alt=opt_alt;
 }*/