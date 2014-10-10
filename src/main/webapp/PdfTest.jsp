<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
java.nio.file.Files,
java.nio.file.Paths,
java.security.MessageDigest,
java.util.regex.Matcher,
java.util.regex.Pattern,
com.itextpdf.text.BaseColor,
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
"%>

<%! // http://blog.abelsky.com/2014/01/22/adding-page-number-to-itext-generated-pdf/
 public class PageStamper extends PdfPageEventHelper {
  @Override
  public void onEndPage(PdfWriter writer, Document document) {
   try {
    final Rectangle pageSize = document.getPageSize();
    final PdfContentByte directContent = writer.getDirectContent();
    directContent.setColorFill(BaseColor.BLACK);
    directContent.setFontAndSize(BaseFont.createFont(), 10);
    if (writer.getCurrentPageNumber()%2==0) {
     directContent.setTextMatrix(pageSize.getRight(40), pageSize.getBottom(30));
    } else {
     directContent.setTextMatrix(pageSize.getLeft(40), pageSize.getBottom(30));
    }
    directContent.showText(String.valueOf(3+writer.getCurrentPageNumber()));
   } catch (Exception e) {}
  }
}%>
<%!
public void page(Document document, String title, int wikiLevel) throws Exception {
 String content="";
 switch (wikiLevel) {
  case 1:
   content=new String(Files.readAllBytes(Paths.get("/home/rawa/tmp/mind/"+title+".txt")));
   break;
  case 3:
   content=new String(Files.readAllBytes(Paths.get("/home/rawa/tmp/btn/wiki/"+title+".wiki")));
   break;
  case 4:
   content=new String(Files.readAllBytes(Paths.get("/home/rawa/GitHoster/GoogleProjectHosting/ungit.wiki/"+title+".wiki")));
   break;
 }
 String c=content+" ";
 document.add(new Paragraph(title,
   new Font(FontFamily.COURIER,18,Font.BOLD)));
 MessageDigest hash=MessageDigest.getInstance("SHA-256");
 hash.update(content.getBytes());
 String h="#"+javax.xml.bind.DatatypeConverter.printHexBinary(hash.digest());
 document.add(new Paragraph(h.toLowerCase(),
   new Font(FontFamily.COURIER,6)));
 Paragraph p=new Paragraph("",
  new Font(FontFamily.TIMES_ROMAN, 13));
 p.setAlignment(Element.ALIGN_JUSTIFIED);
 Matcher m = Pattern.compile("[A-Z]+[a-z]+[A-Z]+[a-z]+[a-zA-Z0-9]*").matcher(c);
 int last=0;
 while (m.find()) {
  p.add(new Phrase(
   c.substring(last,m.start())));  
  Chunk pc=new Chunk(
   c.substring(m.start(),m.end()),
   new Font(FontFamily.COURIER));
//  pc.setCharacterSpacing(-0.5f);
  Phrase pp=new Phrase();
  pp.add(pc);
  p.add(pp);
  last=m.end();
  if ("'".equals(c.substring(last,last+1))) last++;
 }


 p.add(new Phrase(
   c.substring(last)));
 p.setSpacingAfter(10);
 document.add(p);
}
%>
<% // http://itextpdf.com/examples/iia.php?id=173
 response.setContentType("application/pdf");
 String text="SchnuefffChen";
 Document document = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
 final PdfWriter writer = PdfWriter.getInstance(document, baos);
 writer.setPageEvent(new PageStamper());
 document.open();
 String c;

 page(document,"TextForm",3);
 page(document,"DankSagung",3);
 //OUT:
 //page(document,"FansOfIso8601",3);
 page(document,"KlappenText",1);
 
 //1
 page(document,"SchnuefffChen",3);
 page(document,"EndMontage",1);
 page(document,"SchickSaal",3);
 page(document,"HeldenSage",3);
 page(document,"InnBankSe",4);
 page(document,"BeuteSchema",1);
 page(document,"GruenderPaar",3);
 //2
 //3
 //4
 page(document,"AnLicht",1);

 //
 page(document,"LiteraturPapst",3);


 Image img = Image.getInstance("/home/rawa/StauneBild.jpg");
 img.scaleToFit(320, 240);
// document.add(img);
 img = Image.getInstance("/home/rawa/DerAugenblick.jpg");
 img = Image.getInstance("/home/rawa/NooGrey.png");
 img.scaleToFit(320, 240);
 document.add(img);
 document.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>