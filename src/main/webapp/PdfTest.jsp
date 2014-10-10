<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
java.util.regex.Matcher,
java.util.regex.Pattern,
com.itextpdf.text.BaseColor,
com.itextpdf.text.Document,
com.itextpdf.text.DocumentException,
com.itextpdf.text.Element,
com.itextpdf.text.Font,
com.itextpdf.text.Font.FontFamily,
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
    directContent.setColorFill(BaseColor.GRAY);
    directContent.setFontAndSize(BaseFont.createFont(), 10);
    directContent.setTextMatrix(pageSize.getRight(40), pageSize.getBottom(30));
    directContent.showText(String.valueOf(writer.getCurrentPageNumber()));
   } catch (Exception e) {}
  }
}%>
<%!
public void page(Document document, String title,String hash, String content) throws DocumentException {
 String c=content+" ";
 document.add(new Paragraph(title,
   new Font(FontFamily.COURIER,18,Font.BOLD)));
 document.add(new Paragraph("f9acd00ccf0fffac031f1f11ab3c5a9382639c9b",
   new Font(FontFamily.COURIER,8)));
 Paragraph p=new Paragraph("",
  new Font(FontFamily.TIMES_ROMAN, 16));
 p.setAlignment(Element.ALIGN_JUSTIFIED);
 // p.setSpacingBefore(10);
 Matcher m = Pattern.compile("[A-Z]+[a-z]+[A-Z]+[a-z]+[a-zA-Z0-9]*").matcher(c);
 int last=0;
 while (m.find()) {
  p.add(new Phrase(
   c.substring(last,m.start())));
  p.add(new Phrase(
   c.substring(m.start(),m.end()),
   new Font(FontFamily.COURIER)));
  last=m.end();
  if ("'".equals(c.substring(last,last+1))) last++;
 }
 p.add(new Phrase(
   c.substring(last)));
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

 String c="\"SchnuefffChen, da vorne sind zwei Soldaten der SaxonianGeekArmy!\" rief er laut. RainerWasserfuhr stand auf der HauptStrasse vom HauptStaedtchen und zeigte mit ArmOne gen Süden Richtung GoldReiter, so dass die etwa vier Meter weiter östlich stehende ChristineSchlinck vom BuecherTisch aufschaute und ihr SuendenMund lächelte. Kurz vor dem OsterFest AnnoDomino2012 war die Erscheinung zweier erwachsener Männer im GanzKoerper-HasenKostuem auch keine allzu bedenkliche AbWeichung von sozialen Normen, sondern eine in der MarktWirtschaft durchaus tolerierte MarketingMacke. Da TineRoyal heute UrLaub von ihrem NineToFive-TraumJob als BauIngenieurin hatte, konnte sie entspannt ihre TagesFreizeit geniessen und stöberte in aller Ruhe weiter im BuecherTisch. \"Schau mal, da ist was für Dich: ZuKunft2057\". \"Ist das nicht von AndreasEschbach?\" entgegnete er. Er blätterte im Buch: \"Ah nein: Es war nicht von AndreasEschbach, sondern von KarlOlsberg. Der ist sogar mein XingLe-KonTakt. Ob er darin auch auf die VerschmelzungVonMenschUndMaschine eingeht?\" \"Ach Du schon wieder mit Deinem SingularVirus. Ich will die VerSchmelzung von TineRoyal und TraumMann!\". Sie schlenderten weiter Richtung GoldReiter. Er hatte sich damit abgefunden, dass er seine MitMensch'en nur in homöopathischen Dosen mit seinem \"SingularVirus\" impfen konnte. Aber SchnuefffChen, wie er sie jetzt schon seit über elf Jahren nannte, war damit schon hinreichend vertraut. Vor langer Zeit waren sie mal ein Paar, doch dann trennte sich ihr LiebesWeg, da sie, mittlerweile im besten Alter dafür, endlich ihren unbändigen KinderWunsch erfüllen wollte, während er der WindelWelt lieber aus dem Weg ging und neben seinem UnternehmerGen vor allem seine Passion als SelbstErnannt'er ZukunftsForscher ausleben wollte. Mittlerweile verband sie eine beinahe geschwisterliche FreundSchaft, die insbesondere dem wechselseitigen Austausch über die heissesten Single-Schnäppchen auf dem LiebesMarkt diente. Doch noch konnte TineRoyal nicht ahnen, dass die Suche nach ihrem TraumMann sehr bald zu einem SwarmIntelligence-Experiment von beinahe planetarischem Ausmasse werden würde. ngularVirus. Ich will die VerSchmelzung von TineRoyal und TraumMann!\". Sie schlenderten weiter Richtung GoldReiter. Er hatte sich damit abgefunden, dass er seine MitMensch'en nur in homöopathischen Dosen mit seinem \"SingularVirus\" impfen konnte. Aber SchnuefffChen, wie er sie jetzt schon seit über elf Jahren nannte, war damit schon hinreichend vertraut. Vor langer Zeit waren sie mal ein Paar, doch dann trennte sich ihr LiebesWeg, da sie, mittlerweile im besten Alter dafür, endlich ihren unbändigen KinderWunsch erfüllen wollte, während er der WindelWelt lieber aus dem Weg ging und neben seinem UnternehmerGen vor allem seine Passion als SelbstErnannt'er ZukunftsForscher ausleben wollte. Mittlerweile verband sie eine beinahe geschwisterliche FreundSchaft, die insbesondere dem wechselseitigen Austausch über die heissesten Single-Schnäppchen auf dem LiebesMarkt diente. Doch noch konnte TineRoyal nicht ahnen, dass die Suche nach ihrem TraumMann sehr bald zu einem SwarmIntelligence-Experiment von beinahe planetarischem Ausmasse werden würde.";

 page(document,"SchnuefffChen","f9acd00ccf0fffac031f1f11ab3c5a9382639c9b",c);

c="\"Bist Du TrueMan?\" - er stand an HalteStelleU, sich die SchnuerSenkel bindend, den rechten Fuss auf die gelbe Sitzbank gestützt, als sich von hinten eine Frauenstimme an ihn wandte. Er drehte sich überrascht um. Er kannte diese Frau nicht, auch wenn sie auf den ersten Blick wie die ElbElfe aussah. Sie war keinen halben Kopf kleiner als er, schlank, sportlich, mit dunklem Haar und überaus - schön. Sie mochte etwa ZweiUndDreissig Jahre alt sein. Ihre Augen waren lebendig. Auf ihrem Gesicht lag ein Lächeln, das aber nicht von Aufdringlichkeit zeugte, sondern von kluger Bestimmtheit. Ihr Teint und ihre Wangen wirkten, als habe sie italienische Sonne aufgesogen. Er schmunzelte. Er sah in ihre Augen, lies auch fortan nicht von direktem Blickkontakt ab und spürte etwas. Sie lächelte und neigte geduldig ihr holdes Köpfchen um fünf Bogengrad nach rechts. \"Was hast Du denn alles angeclickt? Und vor allem: Welcher Weg hat Dich in die NooSphere geführt?\" Das Köpfchen wandte sich wieder um fünf Bogengrad nach links: \"Ich denke es war... eine GoogleSearch nach... EiscafeVenezia und GoldenerReiter\". Sie lächelte. Er hatte keinen Grund, VerLegen zu sein. \"Ich war zu AnFang irritiert. Das »RabbitHole in die DatingMatrix«. Ich clickte zunächst wahllos herum. Dann merkte ich wohl LangSam, dass Du alles vernetzt. Du breitest Deinen Kopf aus. Im InterNet. Öffentlich. Und Du scheinst KeineAngst zu haben. TrueMan. Irgendwann fand ich den »PageIndex«. Da waren abertausend Seiten. Vieles nur kurze Schnipsel, aber fast immer vernetzt, zu wieder kleinen Schnipseln, doch manchmal landete ich auf opulenten Tabellen oder mehr oder minder langen FragMent'en einer ErZaehlung. Dann konnte ich auch VerSteh'en, dass ein RoterFaden da war. Zwischendurch dachte ich, Du machst das alles nur, um einer geistreichen Frau zu imponieren.\" Er lachte laut und neigte nun auch seinen Kopf um fünf Bogengrad nach rechts. \"Dann tauchten immer öfter diese KayGroschen auf, und ich landete bei der PieschenBank, wo anscheinend noch vor Kurzem Geld geflossen und sogar Aktien getauscht worden waren. Ich dachte kurz, Du habest das alles erfunden, aber alle dort angegebenen Namen führten zu scheinbar realen Profilen bei FaceBook, WerKenntWen oder »XingLe«, wie Du immer sagst. Die konntest Du Dir doch nicht alle ausgedacht haben?\" PatternMatch: UltraMatch";

 page(document,"BeuteSchema","f9acd00ccf0fffac031f1f11ab3c5a9382639c9b",c);

 document.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>