<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
java.nio.file.Files,
java.nio.file.Paths,
java.security.MessageDigest,
java.util.Hashtable,
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
    directContent.setFontAndSize(BaseFont.createFont(), 10);
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
  public Hashtable pi=new Hashtable();
 
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
   String c=content+" ";
   doc.add(new Paragraph(title,
    new Font(FontFamily.COURIER,18,Font.BOLD)));
   MessageDigest hash=MessageDigest.getInstance("SHA-256");
   hash.update(content.getBytes());
   String h="#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest());
   doc.add(new Paragraph(h.toLowerCase(),
    new Font(FontFamily.COURIER,6)));
   Paragraph p=new Paragraph("",
    new Font(FontFamily.TIMES_ROMAN, 13));
   p.setAlignment(Element.ALIGN_JUSTIFIED);
   Matcher m = Pattern.compile("[A-Z]+[a-z]+[A-Z]+[a-z]+[a-zA-Z0-9]*").matcher(c);
   int last=0;
   while (m.find()) {
    p.add(new Phrase(
     c.substring(last,m.start())));  
    String cc=c.substring(m.start(),m.end());
    Chunk pc=new Chunk( cc, new Font(FontFamily.COURIER));
    int pn=writer.getCurrentPageNumber();    
    Vector v;
    if (pi.containsKey(cc)) {
     v=(Vector)pi.get(cc);
    } else {
     v=new Vector();
     pi.put(cc,v);
    }
    v.add(pn);
    //pc.setCharacterSpacing(-0.5f);
    Phrase pp=new Phrase();
    pp.add(pc);
    p.add(pp);
    last=m.end();
    if ("'".equals(c.substring(last,last+1))) last++;
   }
   p.add(new Phrase(c.substring(last)));
   p.setSpacingAfter(10);
   doc.add(p);
  }
 }
%>
<% // http://itextpdf.com/examples/iia.php?id=173
 response.setContentType("application/pdf");

 Document doc = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
 final PdfWriter writer = PdfWriter.getInstance(doc, baos);
 writer.setPageEvent(new PageStamper());
 doc.open();
 Image img = Image.getInstance("/home/rawa/NooSphereCoverR2Ld16571.png");
// Image.getInstance("/home/rawa/StauneBild.jpg");
 img.scaleToFit(550,800);
 doc.add(img);
 img = Image.getInstance("/home/rawa/InnerTitel.png");
 img.scaleToFit(600,1580);
 doc.add(img);
 Chapter ch=new Chapter(new Paragraph("ShockLevel1"),0);
 doc.add(ch);
 doc.add(new Chapter(new Paragraph("ShockLevel"),1));
 PageHelper ph=new PageHelper();
 ph.doc=doc;
 ph.writer=writer;
 ph.addChapter("RoMa",1);
 ph.addChapter("EndMontage",1);
 ph.addChapter("SchnuefffChen",3);
 ph.addChapter("SchickSaal",3);
 ph.addChapter("HeldenSage",3);
 ph.addChapter("TrueMan",1);
 ph.addChapter("TrueWoman",1);
 ph.addChapter("HauptStrasse",1);
 ph.addChapter("InnBankSe",4);
 ph.addChapter("FliederChen",4);
 ph.addChapter("BeuteSchema",1);
 ph.addChapter("HildeIndex",4);
 ph.addChapter("RainersChristentum",1);
 ph.addChapter("BeKenntnisseEinesAutors",4);
 ph.addChapter("GruenderPaar",3);
 ph.addChapter("SiSanien",1);
 ph.addChapter("PieschenBank543",4);
 ph.addChapter("BeatriceBaranov",1);

 doc.add(new Chapter(new Paragraph("ShockLevel"),2));
 //too long!!:
 //ph.addChapter(doc,"LuxorChess",1);
 ph.addChapter("TrueLove",1);
 ph.addChapter("TextForm",3);
 ph.addChapter("DankSagung",3);
 //OUT:
 //ph.addChapter(doct,"FansOfIso8601",3);
 ph.addChapter("KlappenText",1);

 doc.add(new Chapter(new Paragraph("ShockLevel"),3));
 ph.addChapter("IscIi",4);

 doc.add(new Chapter(new Paragraph("ShockLevel"),4));
 ph.addChapter("AtemZuege",1);
 ph.addChapter("AnLicht",1);

 //
 doc.add(new Chapter(new Paragraph("BackPage"),5));
 ph.addChapter("LiteraturPapst",3);

 img = Image.getInstance("/home/rawa/DerAugenblick.jpg");
 img = Image.getInstance("/home/rawa/NooGrey.png");
 img.scaleToFit(320, 240);
 doc.add(img);
 doc.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>