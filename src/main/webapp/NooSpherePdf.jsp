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
  public TreeMap<String,Vector<Integer>> ti=new TreeMap<String,Vector<Integer>>();
 
  public void add(String title, int wikiLevel) throws Exception {
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
   Vector<Integer> tt=new Vector<Integer>();
   ti.put(title,tt);
   tt.add(writer.getCurrentPageNumber());

   Paragraph pt=new Paragraph(title,new Font(FontFamily.COURIER,18,Font.BOLD));
   pt.setSpacingAfter(2);
   doc.add(pt);
   String h="#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest());
   doc.add(new Paragraph(h.toLowerCase()+" - wl"+wikiLevel,
    new Font(FontFamily.COURIER,7)));

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
    if (line.startsWith("http://sl4.eu/wiki/")) line=lnr.readLine(); //FansOfIso8601
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
     line=line.substring(13);
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
 short rel=9;
 String tapeOut="54b";
 short rc=1;
 response.setContentType("application/pdf");
 response.setHeader("Content-Disposition", "inline; filename=\"TapeOut"+tapeOut+"Rc"+rc+".pdf\"");

 Cookie[] cookies = request.getCookies();
 String sc="";
 if( cookies != null) {
  for (int i = 0; i < cookies.length; i++){
   if ("JSESSIONID".equals( cookies[i].getName())) {
    sc=cookies[i].getValue();
    System.out.println(">"+sc+"<");
   }
  }
 }
 Cookie sec=new Cookie("SemperCookie",sc);
 sec.setMaxAge(Integer.MAX_VALUE);
 response.addCookie(sec);

 Document doc = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
 final PdfWriter writer = PdfWriter.getInstance(doc, baos);
 writer.setPageEvent(new PageStamper());
 doc.open();
 Paragraph pt = new Paragraph("RainerWasserfuhr EtAlii", 
  new Font(FontFamily.HELVETICA,22,Font.BOLD,new BaseColor(192,192,192)));
 pt.setSpacingBefore(-20);
 pt.setSpacingAfter(160);
 doc.add(pt);
 pt = new Paragraph("DuKommstDrinVorOderUm:",
  new Font(FontFamily.HELVETICA,24, Font.NORMAL,new BaseColor(255,255,255)));
 pt.setAlignment(Element.ALIGN_LEFT);
 pt.setLeading(0,1.1f);
 pt.setSpacingAfter(60);
 doc.add(pt);
 pt = new Paragraph("»NooSphere«", 
  new Font(FontFamily.HELVETICA,64, Font.BOLD ,new BaseColor(255,0, 0)));
 pt.setAlignment(Element.ALIGN_CENTER);
 pt.setSpacingAfter(100);
 doc.add(pt);
 pt = new Paragraph("Wie @tineroyal ihren\n"+
  "TraumMann fand und wir fast alle \n"+
  "UnSterblich werden",
  new Font(FontFamily.HELVETICA,24, Font.NORMAL,new BaseColor(255,255,255)));
 pt.setAlignment(Element.ALIGN_RIGHT);
 pt.setLeading(0,1.1f);
 pt.setIndentationRight(8f);
 pt.setSpacingAfter(82);
 doc.add(pt);
 pt = new Paragraph("\n\nEditionPieschen",
  new Font(FontFamily.HELVETICA,22, Font.BOLD));
 pt.setSpacingBefore(0);
 doc.add(pt);
 // Image img = Image.getInstance("/home/rawa/TittelBild1704x2272.png");
 Image img = Image.getInstance("/home/rawa/c.png");
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
 gf=new Font(FontFamily.TIMES_ROMAN,20,Font.BOLDITALIC, new BaseColor(127, 127, 127));
 pv=new Paragraph("UnStaatsSpiel",gf);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("WendeChronik",gf);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("ZukunftsRoman",gf);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);
 pv=new Paragraph("\n\n\n\n\n\nEditionPieschen",
   new Font(FontFamily.HELVETICA,20,Font.BOLD));
 pv.setSpacingBefore(140);
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
 String h=
  "CreatedBy planet.sl4.eu"+request.getServletPath()+
  " (#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest()).toLowerCase()+")"+
  "\nfrom "+request.getRemoteHost()+" "+
  "on "+new SimpleDateFormat("yyyy-MM-dd:HHmmss ZZ").format(now)+
  " ("+now.getTime()+", st"+ String.format("%08x",now.getTime()/1000)+")"+
  "\nAufLage"+rel+", TapeOut"+tapeOut+", ~RelCan "+rc+", "+commit+
  "\nSemperCookieHash: #"+
   "8566f4524ba8f866589bedd2507d2160416d56ce7db3c3a3feb9654b0315cbdc";
  //("1".equals(sc)?"063bd77036b211daede5108a33b3c19b6fc26db09f1a4906fd86749f3883e78e":"???");
 pv=new Paragraph(h,new Font(FontFamily.COURIER,8));
 pv.setSpacingBefore(20);
 pv.setAlignment(Element.ALIGN_CENTER);
 doc.add(pv);

 doc.newPage();
 doc.newPage();

 PageHelper ph=new PageHelper();
 ph.doc=doc;
 ph.writer=writer;

 //
 sl(doc,1);
 ph.add("EndMontage",1);
 ph.add("DesSturmesWucht",1);
 ph.add("ReSet",1);
 ph.add("NurFuerVerRuchte",4);
 ph.add("LeserInnen",1);
 ph.add("RoMa",1);
 ph.add("AlexanderGrothendieck",1);
 ph.add("RealRoman",1);
 ph.add("SchnuefffChen",3);
 ph.add("MusTer",1);
 ph.add("SeeLe",1);
 ph.add("SoFort",1);
 ph.add("AnFang",1);
 ph.add("VorWort547",4);
 ph.add("AriadneFaden",1);
 ph.add("TraumPaare",3);
 ph.add("InnBankSe",4);
 ph.add("LebensKunst",1);
 ph.add("SchickSaal",3);
 ph.add("ZukunftsRomanGlossar",1);
 ph.add("DeepBlue",1);
 ph.add("GeBurt",1);
 ph.add("GenSeidenFaden",1);
 ph.add("FliederChen",4);
 ph.add("LeckToRat",4);
 ph.add("AugenBlick",1);
 ph.add("GegenWart",1);
 ph.add("GoPlay",1);
 ph.add("FaceBook",1);
 ph.add("CommodoreSixtyFour",1);
 ph.add("BeuteSchema",1);
 ph.add("FansOfIso8601",3);
 ph.add("IceCream2019",1);
 ph.add("MeinPlaton",1);
 ph.add("AtariSt",1);
 ph.add("UniKl",1);
 ph.add("MissBliss",3);
 ph.add("AlanTuring",1);
 ph.add("MooresLaw",1);
 ph.add("SiSanien",1);
 ph.add("TalDerAhnungslosen",1);
 ph.add("ThaliaCamp",4);
 ph.add("UbiComp",1);
 ph.add("KurbelWelle",1);
 ph.add("UnsereGeschichte",1);
 ph.add("TraumFirma548",4);
 ph.add("TwentyFirstCentury",1);
 ph.add("SehnSucht",1);
 ph.add("ZeitSprung",1);
 ph.add("MindTower",1);
 ph.add("AlbertPlatz",1);
 ph.add("GlasKugel",1);
 ph.add("VladimirLenin",1);
 ph.add("SmallGroupOfCommittedPeople",3);
 ph.add("PieschenRevolution",1);
 ph.add("ChangeAgent",3);
 ph.add("SeaNation",1);
 ph.add("DieMacht",1);
 ph.add("TrueMan",1);
 ph.add("HautAnHaut",4);
 ph.add("RayKurzweil",1);
 ph.add("GrossHausVision",4);
 ph.add("WindelWelt",1);
 ph.add("TafelDrama",4);
 ph.add("HampelMann",3);
 ph.add("NoMic",1);
 ph.add("FactOrFiction",3);
 ph.add("DougEngelbart",1);
 ph.add("TakeOff",1);
 ph.add("HaUndEm",1);
 ph.add("VerFassung",1);
 ph.add("VilfredoPareto",1);
 ph.add("BankRaub",1);
 ph.add("PieschenBank543",4);
 ph.add("SingularPresseMitteilung",3);
 ph.add("NachNeuenMeeren",1);
 ph.add("ElbSpaziergang",1);
 ph.add("DasNetz",1);
 ph.add("PeterPlan",1);
 ph.add("XiNao",1);
 ph.add("RayInDresden",1);
 ph.add("PostSingular",1);
 ph.add("RainersChristentum",1);
 ph.add("AkteNooPolis",1);
 ph.add("BeatriceBaranov",1);
 ph.add("EinSchlag",1);
 ph.add("ParallelUniversum",3);
 ph.add("MannOhneGeheimnisse",3);
 ph.add("BlueMan",1);
 ph.add("AktEins",3);
 ph.add("MorgenDanach",3);
 ph.add("TransparentMan",1);
 ph.add("DeutschIsDead",4);
 ph.add("VerLies",1);

 //
 sl(doc,2);
 ph.add("BeautifulMind",1);
 ph.add("BegruessungsGeld",1);
 ph.add("BeKenntnisseEinesAutors",4);
 ph.add("BlueBrain",1);
 ph.add("DankSagung",3);
 ph.add("DasIchErinnertSich",3);
 ph.add("DistanzSpiel",1);
 ph.add("EheRinge",1);
 ph.add("EigenMuster",1);
 ph.add("EigenRisk",1);
 ph.add("GeFab",3);
 ph.add("GoogleAi",1);
 ph.add("GoogleWiki",3);
 ph.add("HaeufigsteWoerter",1);
 ph.add("HeldenSage",3);
 ph.add("HildeTreu",4);
 ph.add("IchBinHeuteAmFlughafen",1);
 ph.add("KasimirNummer",3);
 ph.add("KhaldoonsDream",3);
 ph.add("KommUnion",1);
 ph.add("KopfWelt",1);
 ph.add("LebensEntwurf",1);
 ph.add("LockFutureSex",4);
 ph.add("MenschMaschinenMensch",1);
 ph.add("MindBroker",1);
 ph.add("MindEyes",1);
 ph.add("MindId",1);
 ph.add("MindMark",3);
 ph.add("MindNotFoundException",3);
 ph.add("MorgenMantel",4);
 ph.add("NooPolisFaqDe",1);
 ph.add("ObenVorn",1);
 ph.add("PieschenArtGroup",1);
 ph.add("PostReal",1);
 ph.add("PraterBrater",3);
 ph.add("ProvinzTrauma",1);
 ph.add("RawashiNakamoto",3);
 ph.add("RealFilm",1);
 ph.add("ReverseStrip",1);
 ph.add("SchneeVersicherung",1);
 ph.add("SingularAcademy",1);
 ph.add("SingularVirus",1);
 ph.add("SuperComp",1);
 ph.add("SystemKunst",1);
 ph.add("TheNooSphere",1);
 ph.add("TheOne",1);
 ph.add("TheSingularity",1);
 ph.add("TransSimian",1);
 ph.add("TrueLove",1);
 ph.add("WandelDruck",1);
 ph.add("WindelWeltFragmente",1);
 ph.add("WortSchatz",1);
 ph.add("ZeroResistance",1);
 ph.add("ZuKunft",1);

 //
 sl(doc,3);
 ph.add("AiWinter",1);
 ph.add("BabyAi",1);
 ph.add("CamelCase",1);
 ph.add("CarTraum",1);
 ph.add("ConScious",1);
 ph.add("ConVerg",1);
 ph.add("DealFutures",1);
 ph.add("DezentralKomitee",1);
 ph.add("EinHorn",1);
 ph.add("FixPunkt",1);
 ph.add("GeistMaschine",3);
 ph.add("GruenderPaar",3);
 ph.add("HauptStrasse",1);
 ph.add("HildeIndex",4);
 ph.add("IntelligenceExplosion",1);
 ph.add("IscIi",4);
 ph.add("LuxorChess",1);
 ph.add("MeatBrain",1);
 ph.add("MoebelWasserfuhr",1);
 ph.add("NewMind",1);
 ph.add("PreSingularityAbundanceMilestones",1);
 ph.add("SecondHalfOfTheChessboard",1);
 ph.add("SemanticSixSigma",3);
 ph.add("ShockLevel",1);
 ph.add("NooPolisBook",1);
 ph.add("SingularityReport",1);
 ph.add("SocialGraph",1);
 ph.add("TextForm",3);
 ph.add("TrueWoman",1);
 ph.add("WikiWeiber",1);

 //
 sl(doc,4);
 ph.add("AnLicht",1);
 ph.add("AtemZuege",1);
 ph.add("AusGang",3);

 doc.add(new Chapter(new Paragraph("DuKommstDrinVorOderUm"),5));

 Paragraph p=new Paragraph("",
  new Font(FontFamily.COURIER,8));
 p.setAlignment(Element.ALIGN_JUSTIFIED);

 //PdfPTable table = new PdfPTable(new float[] { 1, 1 });
 //table.setWidthPercentage(100f);
 Iterator<String> enumKey = ph.pi.keySet().iterator();
 while(enumKey.hasNext()) {
  String key = enumKey.next();
  Vector<Integer> val = ph.pi.get(key);
  String s=key;
  int last=0;
  for (int i:val) {
   if (i>last) {
    s+=" "+i;
    if (ph.ti.containsKey(key) && ph.ti.get(key).get(0)==i) {
     s+="*";
    }
   }
   last=i;
  }
  p.add(new Phrase(s+". "));
 }
 doc.add(p);

 pt=new Paragraph("PageIndex",new Font(FontFamily.COURIER,18,Font.BOLD));
 pt.setSpacingAfter(2);
 doc.add(pt);
 p=new Paragraph("",
  new Font(FontFamily.COURIER,9));
 p.setAlignment(Element.ALIGN_JUSTIFIED);
 enumKey = ph.ti.keySet().iterator();
 while(enumKey.hasNext()) {
  String key = enumKey.next();
  Vector<Integer> val = ph.ti.get(key);
  String s=key+" "+val.get(0);
  p.add(new Phrase(s+". "));
 }
 doc.add(p);
 doc.newPage();
 ph.add("KlappenText",1);
 ph.add("LiteraturPapst",3);

 img=Image.getInstance("/home/rawa/StauneBild.jpg");
 img=Image.getInstance("/home/rawa/DerAugenblick.jpg");
 img=Image.getInstance("/home/rawa/NooGrey.png");
 img.scaleToFit(320, 240);
 //doc.add(img);
 doc.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>