<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.BufferedReader,
java.io.ByteArrayOutputStream,
java.io.File,
java.io.InputStreamReader,
java.io.LineNumberReader,
java.io.OutputStream,
java.io.StringReader,
java.nio.file.Files,
java.nio.file.Paths,
java.security.MessageDigest,
java.text.SimpleDateFormat,
java.util.Date,
java.util.Iterator,
java.util.TreeMap,
java.util.regex.Matcher,
java.util.regex.Pattern,
java.util.Vector,
com.itextpdf.text.BaseColor,
com.itextpdf.text.Chapter,
com.itextpdf.text.Chunk,
com.itextpdf.text.Document,
com.itextpdf.text.DocumentException,
com.itextpdf.text.Element,
com.itextpdf.text.Font,
com.itextpdf.text.Font.FontFamily,
com.itextpdf.text.Image,
com.itextpdf.text.Paragraph,
com.itextpdf.text.Rectangle,
com.itextpdf.text.PageSize,
com.itextpdf.text.Paragraph,
com.itextpdf.text.Phrase,
com.itextpdf.text.pdf.BaseFont,
com.itextpdf.text.pdf.PdfPageEventHelper,
com.itextpdf.text.pdf.PdfContentByte,
com.itextpdf.text.pdf.PdfWriter
"%><%! // http://blog.abelsky.com/2014/01/22/adding-page-number-to-itext-generated-pdf/
 public class PageStamper extends PdfPageEventHelper {
  @Override
  public void onEndPage(PdfWriter writer, Document document) {
   try {
    final Rectangle pageSize = document.getPageSize();
    final PdfContentByte directContent = writer.getDirectContent();
    directContent.setColorFill(BaseColor.BLACK);
    directContent.setFontAndSize(
    //new Font(FontFamily.COURIER,18,Font.BOLD),10);
     BaseFont.createFont(BaseFont.TIMES_ROMAN,BaseFont.CP1250,true), 10);
    float pos;
    if (writer.getCurrentPageNumber()>1) {
     if (writer.getCurrentPageNumber()%2==0) {
      pos=pageSize.getRight(40);
     } else {
      pos=pageSize.getLeft(40);
     }
     directContent.setTextMatrix(pos, pageSize.getBottom(30));
     directContent.showText(String.valueOf(1+writer.getCurrentPageNumber()));
    }
   } catch (Exception e) {}
  }
 }
 public class PageHelper {
  public PdfWriter writer;
  public Document doc;
  public TreeMap<String,Vector<Integer>> pi=new TreeMap<String,Vector<Integer>>();
 
  public void addChapter(String title, int wikiLevel) throws Exception {
   String s="/home/rawa/GitHoster/";
   switch (wikiLevel) {
    case 1:
     s+="GitHub/wasserfuhr/DigitalEarth/src/main/webapp/MindWiki/"+title+".txt";
     break;
    case 3:
     s+="GitHub/wasserfuhr/DigitalEarth/src/main/webapp/BtnWiki/"+title+".wiki";
     break;
    case 4:
     s+="GoogleProjectHosting/ungit.wiki/"+title+".wiki";
     break;
   }
   String content=new String(Files.readAllBytes(Paths.get(s)));
   MessageDigest hash=MessageDigest.getInstance("SHA-256");
   hash.update(content.getBytes());
   String c;//=content.replaceAll("\r\n","\n");
   c=content.replaceAll("\r\n!","<h>");
   c=c.replaceAll("\r\n","\n");
   c=c.replaceAll("\n\n","\n");
   c=c.replaceAll("<h>","!");
   c=c+" "; //ensures that we always can append a postfix
   Vector<Integer> vt;
   if (pi.containsKey(title)) {
    vt=pi.get(title);
   } else {
    vt=new Vector<Integer>();
    pi.put(title,vt);
   }
   vt.add(writer.getCurrentPageNumber());

   doc.add(new Paragraph(title,
    new Font(FontFamily.COURIER,18,Font.BOLD)));
   String h="#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest());
   doc.add(new Paragraph(h.toLowerCase(),
    new Font(FontFamily.COURIER,6)));

   Paragraph p=new Paragraph("",
    new Font(FontFamily.TIMES_ROMAN, 9));
   Paragraph pAdd=p;
   p.setAlignment(Element.ALIGN_JUSTIFIED);
   p.setLeading(0,2f);
   LineNumberReader lnr=new LineNumberReader(new StringReader(c));
   String line;
   while ( (line=lnr.readLine())!=null) {
    Font f=new Font(FontFamily.TIMES_ROMAN,13);
    if (line.contains("* IsA: ")) line=lnr.readLine();
    if (line.contains("* MindTag: ")) line=lnr.readLine();
    if (line.contains("* MindTags: ")) line=lnr.readLine();
    if (line.contains("* InterWiki: ")) line=lnr.readLine();
    if (line.contains("* PieschenTv: ")) line=lnr.readLine();
    if (line.contains("* InspiredBy: ")) line=lnr.readLine();
    if (line.contains("* NamedAfter: ")) line=lnr.readLine();
    if (line.contains("* PreDict: ")) line=lnr.readLine(); //SeaNation
    if (line.contains("* PreDictDe: ")) line=lnr.readLine(); 
    if (line.contains("* SloGan: ")) line=lnr.readLine(); //VerFassung
    line+=" ";
    int fontSize=10;
    if (line.startsWith("!")) {
     fontSize=12;
     if (line.startsWith("!!")) {
      line=line.substring(2);
      fontSize=14;
     }
     line=line.substring(1);
     doc.add(pAdd);
     pAdd=new Paragraph(line,
      new Font(FontFamily.TIMES_ROMAN,fontSize,Font.BOLD));
     doc.add(pAdd);
     pAdd=new Paragraph("",
      new Font(FontFamily.TIMES_ROMAN,9));
     pAdd.setAlignment(Element.ALIGN_JUSTIFIED);
     pAdd.setLeading(0,2f);
     line="";
    }
    if (line.startsWith("|")) {
     doc.add(pAdd);
     pAdd=new Paragraph("",
      new Font(FontFamily.TIMES_ROMAN,9));
     pAdd.setAlignment(Element.ALIGN_JUSTIFIED);
     pAdd.setLeading(0,2f);
    }
    if (line.contains("* MindQuote: ")) {
     line=line.substring(12);
     pAdd=new Paragraph(line,
      new Font(FontFamily.TIMES_ROMAN,11,Font.ITALIC));
     pAdd.setAlignment(Element.ALIGN_JUSTIFIED);
     pAdd.setIndentationLeft(20f);
     doc.add(pAdd);
     line="";
     pAdd=new Paragraph(line,
       new Font(FontFamily.TIMES_ROMAN,13));
     pAdd.setAlignment(Element.ALIGN_JUSTIFIED);
    }
    Matcher m = Pattern.compile("[A-Z]+[a-z]+[A-Z]+[a-z]+[a-zA-Z0-9]*").matcher(line);
    int last=0;
    while (m.find()) {
     String ps=line.substring(last,m.start());
     pAdd.add(new Phrase(ps,f));
     String cc=line.substring(m.start(),m.end());
     Chunk pc=new Chunk( cc, new Font(FontFamily.COURIER,13));
     Vector<Integer> v;
     if (pi.containsKey(cc)) {
      v=pi.get(cc);
     } else {
      v=new Vector<Integer>();
      pi.put(cc,v);
     }
     v.add(writer.getCurrentPageNumber());
     //pc.setCharacterSpacing(-0.5f);
     Phrase pp=new Phrase();
     pp.add(pc);
     pAdd.add(pp);
     last=m.end();
     if ("'".equals(line.substring(last,last+1))) last++;
    }
    pAdd.add(new Phrase(line.substring(last),f));
    pAdd.setSpacingAfter(10);
   }
   doc.add(pAdd);
  }
 }
 public void sl(Document doc, int sl) throws Exception {
  doc.newPage();
  Paragraph pt = new Paragraph("\n\nShockLevel "+sl,
  new Font(FontFamily.TIMES_ROMAN,32,Font.BOLD));
  pt.setAlignment(Element.ALIGN_CENTER);
  doc.add(pt);
  doc.newPage();
 }
%>
<% // http://itextpdf.com/examples/iia.php?id=173
 response.setContentType("application/pdf");

 Document doc = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
 final PdfWriter writer = PdfWriter.getInstance(doc, baos);
 writer.setPageEvent(new PageStamper());
 doc.open();
 Paragraph pt = new Paragraph("RainerWasserfuhr EtAlii", 
  new Font(FontFamily.HELVETICA,22,Font.BOLD,new BaseColor(192,192,192)));
 pt.setSpacingBefore(-20);
 pt.setSpacingAfter(260);
 doc.add(pt);
 pt = new Paragraph("»NooSphere«", 
  new Font(FontFamily.HELVETICA,64, Font.BOLD ,new BaseColor(255,0, 0)));
 pt.setAlignment(Element.ALIGN_CENTER);
 pt.setSpacingAfter(60);
 doc.add(pt);
 pt = new Paragraph("Wie @tineroyal ihren\nTraumMann fand und wir fast alle \nUnSterblich werden",
  new Font(FontFamily.HELVETICA,24, Font.NORMAL,new BaseColor(255,255,255)));
 pt.setAlignment(Element.ALIGN_RIGHT);
 pt.setLeading(0,1.1f);
 pt.setIndentationRight(45f);
 pt.setSpacingAfter(109);
 doc.add(pt);
 pt = new Paragraph("\n\nEditionPieschen",
  new Font(FontFamily.HELVETICA,22, Font.BOLD,new BaseColor(0,0,0)));
 pt.setSpacingBefore(0);
 doc.add(pt);
 Image img = Image.getInstance(
   //"/home/rawa/NooSphereCoverR2Ld16571.png");
   "/home/rawa/TittelBild1704x2272.png");
 img.scaleToFit(480*1.187f,640*1.187f);
 img.setAbsolutePosition(
  (PageSize.A4.getWidth() - img.getScaledWidth()) / 2,
  (PageSize.A4.getHeight() - img.getScaledHeight()) / 2);
 doc.add(img);
 doc.newPage();
 Font gf=new Font(FontFamily.TIMES_ROMAN,24,Font.BOLDITALIC, new BaseColor(127, 127, 127));
 Paragraph pv=new Paragraph("\n\n\nRainerWasserfuhr EtAlii",gf);
 pv.setSpacingAfter(20);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("»NooSphere«",
  new Font(FontFamily.TIMES_ROMAN,32,Font.BOLD));
 pv.setAlignment(Element.ALIGN_CENTER);
 pv.setSpacingAfter(20);
 doc.add(pv);
 pv=new Paragraph("WendeChronik",gf);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("ZukunftsRoman",gf);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("\n\n\n\n\n\nEditionPieschen",
   new Font(FontFamily.HELVETICA,20,Font.BOLD));
 pv.setSpacingBefore(190);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 String sDir="/home/rawa/GitHoster/GitHub/wasserfuhr/DigitalEarth/";
 String creator=new String(Files.readAllBytes(Paths.get(sDir+"src/main/webapp/"+request.getServletPath())));
 MessageDigest hash=MessageDigest.getInstance("SHA-256");
 hash.update(creator.getBytes());
 Date now=new Date();
 Process ps = Runtime.getRuntime().exec("git log -1",null,new File(sDir));
 ps.waitFor();
 String commit = new BufferedReader(new InputStreamReader(ps.getInputStream())).readLine();
 String h="TapeOut545, "+commit+
  "\nCreatedBy "+request.getServletPath()+
  " (#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest()).toLowerCase()+") "+
  "\nfrom "+request.getRemoteHost()+" "+
  "on "+new SimpleDateFormat("yyyy-MM-dd:HHmmss ZZ").format(now)+
  " ("+now.getTime()+", st"+ String.format("%08x",now.getTime()/1000)+").";
 pv=new Paragraph(h,
   new Font(FontFamily.COURIER,7));
 pv.setSpacingBefore(20);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(new Paragraph(""));
 doc.add(pv);

 //
 sl(doc,1);

 PageHelper ph=new PageHelper();
 ph.doc=doc;
 ph.writer=writer;
 ph.addChapter("EndMontage",1);
 ph.addChapter("RoMa",1);
 //ph.addChapter("TextForm",3);
 ph.addChapter("SchnuefffChen",3);
 ph.addChapter("DesSturmesWucht",1);
 ph.addChapter("AnFang",1);
 ph.addChapter("TraumPaare",3);
 ph.addChapter("InnBankSe",4);
 ph.addChapter("HeldenSage",3);
 ph.addChapter("SchickSaal",3);
 ph.addChapter("GeBurt",1);

 ph.addChapter("GenSeidenFaden",1);
 //ph.addChapter("TrueWoman",1);
 //ph.addChapter("HauptStrasse",1);
 ph.addChapter("FliederChen",4);
 ph.addChapter("CommodoreSixtyFour",1);
 ph.addChapter("BeuteSchema",1);
 ph.addChapter("AtariSt",1);
 ph.addChapter("SiSanien",1);
 ph.addChapter("UbiComp",1);
 ph.addChapter("UniKl",1);
 ph.addChapter("GlasKugel",1);
 ph.addChapter("DistanzSpiel",1);
 ph.addChapter("TrueMan",1);
 ph.addChapter("GrossHausVision",4);
 ph.addChapter("WindelWelt",1);
// ph.addChapter("
 ph.addChapter("VerFassung",1);
 ph.addChapter("SingularPresseMitteilung",3);
 ph.addChapter("NachNeuenMeeren",1);
 ph.addChapter("SeaNation",1);
 ph.addChapter("DasNetz",1);
 ph.addChapter("RayInDresden",1);
 ph.addChapter("MooresLaw",1);
 ph.addChapter("RainersChristentum",1);
 //ph.addChapter("BeKenntnisseEinesAutors",4);
 //ph.addChapter("GruenderPaar",3);
 ph.addChapter("PieschenBank543",4);
 ph.addChapter("BeatriceBaranov",1);

 //
 sl(doc,2);

 ph.addChapter("TrueLove",1);
 //ph.addChapter("DankSagung",3);
 //ph.addChapter("HildeIndex",4);
 //ph.addChapter(doct,"FansOfIso8601",3);
 //ph.addChapter("KlappenText",1);
 //too long!!:
 //ph.addChapter(doc,"LuxorChess",1);

 //
 sl(doc,3);

 ph.addChapter("IscIi",4);
 ph.addChapter("SecondHalfOfTheChessboard",1);

 //
 sl(doc,4);

 ph.addChapter("AnLicht",1);
 ph.addChapter("AtemZuege",1);
 ph.addChapter("AusGang",3);

 doc.add(new Chapter(new Paragraph("DuKommstDrinVorOderUm"),5));

 Paragraph p=new Paragraph("",
  new Font(FontFamily.COURIER,8));
 p.setAlignment(Element.ALIGN_JUSTIFIED);

// PdfPTable table = new PdfPTable(new float[] { 1, 1 });
 //table.setWidthPercentage(100f);
 Iterator<String> enumKey = ph.pi.keySet().iterator();
 while(enumKey.hasNext()) {
  String key = enumKey.next();
  Vector<Integer> val = ph.pi.get(key);
  String s=key+"...";
  int last=0;
  for (int i:val) {
   if (i>last) {
    s+=" "+i;
   }
   last=i;
  }
  p.add(new Phrase(s+". "));
 }
 doc.add(p);
 //
 doc.newPage();//add(new Chapter(new Paragraph("BackPage"),6));
 ph.addChapter("LiteraturPapst",3);

//Image.getInstance("/home/rawa/StauneBild.jpg");
 img = Image.getInstance("/home/rawa/DerAugenblick.jpg");
 img = Image.getInstance("/home/rawa/NooGrey.png");
 img.scaleToFit(320, 240);
// doc.add(img);
 doc.close();
 response.setContentLength(baos.size());
 response.setHeader("Content-Disposition", "inline; filename=\"NooSphere.pdf\"");
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>