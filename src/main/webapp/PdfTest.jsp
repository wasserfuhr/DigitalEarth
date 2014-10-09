<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
com.itextpdf.text.BaseColor,
com.itextpdf.text.Document,
com.itextpdf.text.DocumentException,
com.itextpdf.text.Element,
com.itextpdf.text.Font,
com.itextpdf.text.Font.FontFamily,
com.itextpdf.text.Paragraph,
com.itextpdf.text.Rectangle,
com.itextpdf.text.Paragraph,
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
    directContent.setColorFill(BaseColor.GRAY);
    directContent.setFontAndSize(BaseFont.createFont(), 10);
    directContent.setTextMatrix(pageSize.getRight(40), pageSize.getBottom(30));
    directContent.showText(String.valueOf(writer.getCurrentPageNumber()));
   } catch (Exception e) {}
  }
}%>
<% // http://itextpdf.com/examples/iia.php?id=173
 response.setContentType("application/pdf");
 String text="SchnuefffChen";
 Document document = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
// PdfWriter.getInstance(document, baos);
 final PdfWriter writer = PdfWriter.getInstance(document, baos);
 writer.setPageEvent(new PageStamper());
 document.open();
// document.add(new Paragraph("»NooSphere«"));
 document.add(new Paragraph(text,
   new Font(FontFamily.TIMES_ROMAN,20,Font.ITALIC)));
//   new Font(FontFamily.HELVETICA, 18)));
 Paragraph p=new Paragraph(
"\"SchnuefffChen, da vorne sind zwei Soldaten der SaxonianGeekArmy!\" rief er laut. RainerWasserfuhr stand auf der HauptStrasse vom HauptStaedtchen und zeigte mit ArmOne gen Süden Richtung GoldReiter, so dass die etwa vier Meter weiter östlich stehende ChristineSchlinck vom BuecherTisch aufschaute und ihr SuendenMund lächelte. Kurz vor dem OsterFest AnnoDomino2012 war die Erscheinung zweier erwachsener Männer im GanzKoerper-HasenKostuem auch keine allzu bedenkliche AbWeichung von sozialen Normen, sondern eine in der MarktWirtschaft durchaus tolerierte MarketingMacke. Da TineRoyal heute UrLaub von ihrem NineToFive-TraumJob als BauIngenieurin hatte, konnte sie entspannt ihre TagesFreizeit geniessen und stöberte in aller Ruhe weiter im BuecherTisch. \"Schau mal, da ist was für Dich: ZuKunft2057\". \"Ist das nicht von AndreasEschbach?\" entgegnete er. Er blätterte im Buch: \"Ah nein: Es war nicht von AndreasEschbach, sondern von KarlOlsberg. Der ist sogar mein XingLe-KonTakt. Ob er darin auch auf die VerschmelzungVonMenschUndMaschine eingeht?\" \"Ach Du schon wieder mit Deinem SingularVirus. Ich will die VerSchmelzung von TineRoyal und TraumMann!\". Sie schlenderten weiter Richtung GoldReiter. Er hatte sich damit abgefunden, dass er seine MitMensch'en nur in homöopathischen Dosen mit seinem \"SingularVirus\" impfen konnte. Aber SchnuefffChen, wie er sie jetzt schon seit über elf Jahren nannte, war damit schon hinreichend vertraut. Vor langer Zeit waren sie mal ein Paar, doch dann trennte sich ihr LiebesWeg, da sie, mittlerweile im besten Alter dafür, endlich ihren unbändigen KinderWunsch erfüllen wollte, während er der WindelWelt lieber aus dem Weg ging und neben seinem UnternehmerGen vor allem seine Passion als SelbstErnannt'er ZukunftsForscher ausleben wollte. Mittlerweile verband sie eine beinahe geschwisterliche FreundSchaft, die insbesondere dem wechselseitigen Austausch über die heissesten Single-Schnäppchen auf dem LiebesMarkt diente. Doch noch konnte TineRoyal nicht ahnen, dass die Suche nach ihrem TraumMann sehr bald zu einem SwarmIntelligence-Experiment von beinahe planetarischem Ausmasse werden würde. ngularVirus. Ich will die VerSchmelzung von TineRoyal und TraumMann!\". Sie schlenderten weiter Richtung GoldReiter. Er hatte sich damit abgefunden, dass er seine MitMensch'en nur in homöopathischen Dosen mit seinem \"SingularVirus\" impfen konnte. Aber SchnuefffChen, wie er sie jetzt schon seit über elf Jahren nannte, war damit schon hinreichend vertraut. Vor langer Zeit waren sie mal ein Paar, doch dann trennte sich ihr LiebesWeg, da sie, mittlerweile im besten Alter dafür, endlich ihren unbändigen KinderWunsch erfüllen wollte, während er der WindelWelt lieber aus dem Weg ging und neben seinem UnternehmerGen vor allem seine Passion als SelbstErnannt'er ZukunftsForscher ausleben wollte. Mittlerweile verband sie eine beinahe geschwisterliche FreundSchaft, die insbesondere dem wechselseitigen Austausch über die heissesten Single-Schnäppchen auf dem LiebesMarkt diente. Doch noch konnte TineRoyal nicht ahnen, dass die Suche nach ihrem TraumMann sehr bald zu einem SwarmIntelligence-Experiment von beinahe planetarischem Ausmasse werden würde.",
  new Font(FontFamily.TIMES_ROMAN, 16));
 p.setAlignment(Element.ALIGN_JUSTIFIED);
 p.setSpacingBefore(10);
 document.add(p);           
 document.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>