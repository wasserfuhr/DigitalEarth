<%@ page pageEncoding="UTF-8"%><%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
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
public void page(Document document, String title, String content) throws Exception {
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

 String c="\"SchnuefffChen, da vorne sind zwei Soldaten der SaxonianGeekArmy!\" rief er laut. RainerWasserfuhr stand auf der HauptStrasse vom HauptStaedtchen und zeigte mit ArmOne gen Süden Richtung GoldReiter, so dass die etwa vier Meter weiter östlich stehende ChristineSchlinck vom BuecherTisch aufschaute und ihr SuendenMund lächelte. Kurz vor dem OsterFest AnnoDomino2012 war die Erscheinung zweier erwachsener Männer im GanzKoerper-HasenKostuem auch keine allzu bedenkliche AbWeichung von sozialen Normen, sondern eine in der MarktWirtschaft durchaus tolerierte MarketingMacke. Da TineRoyal heute UrLaub von ihrem NineToFive-TraumJob als BauIngenieurin hatte, konnte sie entspannt ihre TagesFreizeit geniessen und stöberte in aller Ruhe weiter im BuecherTisch. \"Schau mal, da ist was für Dich: ZuKunft2057\". \"Ist das nicht von AndreasEschbach?\" entgegnete er. Er blätterte im Buch: \"Ah nein: Es war nicht von AndreasEschbach, sondern von KarlOlsberg. Der ist sogar mein XingLe-KonTakt. Ob er darin auch auf die VerschmelzungVonMenschUndMaschine eingeht?\" \"Ach Du schon wieder mit Deinem SingularVirus. Ich will die VerSchmelzung von TineRoyal und TraumMann!\". Sie schlenderten weiter Richtung GoldReiter. Er hatte sich damit abgefunden, dass er seine MitMensch'en nur in homöopathischen Dosen mit seinem \"SingularVirus\" impfen konnte. Aber SchnuefffChen, wie er sie jetzt schon seit über elf Jahren nannte, war damit schon hinreichend vertraut. Vor langer Zeit waren sie mal ein Paar, doch dann trennte sich ihr LiebesWeg, da sie, mittlerweile im besten Alter dafür, endlich ihren unbändigen KinderWunsch erfüllen wollte, während er der WindelWelt lieber aus dem Weg ging und neben seinem UnternehmerGen vor allem seine Passion als SelbstErnannt'er ZukunftsForscher ausleben wollte. Mittlerweile verband sie eine beinahe geschwisterliche FreundSchaft, die insbesondere dem wechselseitigen Austausch über die heissesten Single-Schnäppchen auf dem LiebesMarkt diente. Doch noch konnte TineRoyal nicht ahnen, dass die Suche nach ihrem TraumMann sehr bald zu einem SwarmIntelligence-Experiment von beinahe planetarischem Ausmasse werden würde.";


 page(document,"SchnuefffChen",c);

c="\"Bist Du TrueMan?\" - er stand an HalteStelleU, sich die SchnuerSenkel bindend, den rechten Fuss auf die gelbe Sitzbank gestützt, als sich von hinten eine Frauenstimme an ihn wandte. Er drehte sich überrascht um. Er kannte diese Frau nicht, auch wenn sie auf den ersten Blick wie die ElbElfe aussah. Sie war keinen halben Kopf kleiner als er, schlank, sportlich, mit dunklem Haar und überaus - schön. Sie mochte etwa ZweiUndDreissig Jahre alt sein. Ihre Augen waren lebendig. Auf ihrem Gesicht lag ein Lächeln, das aber nicht von Aufdringlichkeit zeugte, sondern von kluger Bestimmtheit. Ihr Teint und ihre Wangen wirkten, als habe sie italienische Sonne aufgesogen. Er schmunzelte. Er sah in ihre Augen, lies auch fortan nicht von direktem Blickkontakt ab und spürte etwas. Sie lächelte und neigte geduldig ihr holdes Köpfchen um fünf Bogengrad nach rechts. \"Was hast Du denn alles angeclickt? Und vor allem: Welcher Weg hat Dich in die NooSphere geführt?\" Das Köpfchen wandte sich wieder um fünf Bogengrad nach links: \"Ich denke es war... eine GoogleSearch nach... EiscafeVenezia und GoldenerReiter\". Sie lächelte. Er hatte keinen Grund, VerLegen zu sein. \"Ich war zu AnFang irritiert. Das »RabbitHole in die DatingMatrix«. Ich clickte zunächst wahllos herum. Dann merkte ich wohl LangSam, dass Du alles vernetzt. Du breitest Deinen Kopf aus. Im InterNet. Öffentlich. Und Du scheinst KeineAngst zu haben. TrueMan. Irgendwann fand ich den »PageIndex«. Da waren abertausend Seiten. Vieles nur kurze Schnipsel, aber fast immer vernetzt, zu wieder kleinen Schnipseln, doch manchmal landete ich auf opulenten Tabellen oder mehr oder minder langen FragMent'en einer ErZaehlung. Dann konnte ich auch VerSteh'en, dass ein RoterFaden da war. Zwischendurch dachte ich, Du machst das alles nur, um einer geistreichen Frau zu imponieren.\" Er lachte laut und neigte nun auch seinen Kopf um fünf Bogengrad nach rechts. \"Dann tauchten immer öfter diese KayGroschen auf, und ich landete bei der PieschenBank, wo anscheinend noch vor Kurzem Geld geflossen und sogar Aktien getauscht worden waren. Ich dachte kurz, Du habest das alles erfunden, aber alle dort angegebenen Namen führten zu scheinbar realen Profilen bei FaceBook, WerKenntWen oder »XingLe«, wie Du immer sagst. Die konntest Du Dir doch nicht alle ausgedacht haben?\" PatternMatch: UltraMatch";

 page(document,"BeuteSchema",c);

 c="GretChen war der KoseName von HeinRich für eine HochBegabt'e KunstStudentin an der KunstAkademie im HauptStaedtchen. Eines schönen SommerAbend's AnnoDomini2010, als sie mit BuergerLich'em RealName'n noch HeidiMorgenstern hieß, trat GretChen durch die Pforte zum EinGang in einen wunderschönen BallSaal in der NeuStadt des HauptStaedtchen's. Ein besonders großer ZuFall führte sie an genau jetzt hier her. Allein die Formulierung “großer ZuFall” lässt jedoch an dessen Existenz zweifeln, und die Überlegung aufkommen, den BeGriff durch “Fügung” oder sogar “SchickSaal” zu ersetzen. Nach einer gemeinsamen Flasche Wein mit DeborahMorgenstern, ihrer Schwägerin, auf den noch um MitterNacht juliwarmen Stufen der LutherKirche, ging GretChen einen kleinen UmWeg, um das vor der LutherKirche begonnene Gespräch über die Verstrickungen des Lebens LangSam ausklingen zu lassen. Dieser so um nicht viel mehr als 200 Meter verlängerte HeimWeg führte sie an dem sonst verschlossenen BallSaal vorbei. Die unscheinbare und üblicherweise verschlossene Tür stand offen, ein Schild mit der von Hand geschriebenen Aufschrift \"PieschenBank- 100 KG BegruessungsGeld\" lockte die beiden in den völlig dunklen BallSaal. Die einzige Beleuchtung bildete das bläulich-kühle Licht eines LapTop's, der ganz am Ende des BallSaal's offen auf einem SchreibTisch stand. Das GeSicht eines auf den BildSchirm fixierten Mannes bildete so den FluchtPunkt dieses riesigen Raumes, der sich wie in einem KlarTraum direkt hinter dieser völlig unscheinbaren Tür der kleinen Strasse auftat. Bald nach den ersten Sätzen der Begrüssung verlies die Schwägerin die Szene mit der Begründung, sehr müde zu sein, da sie schnell bemerkte welche Spannung zwischen GretChen und dem Unbekannten gleich in den ersten Momenten dieser nachmitternächtlichen Begegnung herrschte.";
 page(document,"SchickSaal",c);

 c=" * IsA: MindPlace\nWas war hier geschehen? Ich stand plötzlich in dieser seltsamen Zelle. Noch vor Sekundenbruchteilen war ich an meinem SchreibTisch in der WackenmuehlStrasse in KaisersLautern gesessen. Es war Samstag gewesen, der 23. September 1989 gegen 16:30h und ich hatte an meinem AtariSt ein kleines SelfImprove-Modul für eine neue Art von ReCur'siver TuringMaschine programmiert. Doch wo war ich jetzt? Ein quadratischer Käfig aus Glasscheiben trennte mich von einem Platz voller Barockgebäude. Ich trat durch die gläserne Tür aus dem Käfig. Verdammt, was war hier geschehen?\nHinter mir war eine riesige BarockKirche. Ich hatte eine andere Brille und staunte, dass sich an meinem Bauch eine winzige, aber unter einem schwarzen Hemd hervortretende Wölbung von etwa 16cm Durchmesser und 2,56 cm Dicke befand. Ich trug ein schwarzes Jackett und eine schwarze Jeans. Der Uhr einer weiteren Kirche gegenüber zufolge schien es etwa nach 16:32 zu sein. Auf dem umgebendenen Platz standen einige Autos, deren Modelle ich noch nie zuvor gesehen habe. An einem Hotel gegenüber prangte der Schriftzug \"SteigenBerger\".\nAn meiner linken Schulter war eine dunkelblaue Umhängetasche mit der Aufschrift \"Deutsch IsNt WissenschaftsSprache! - Tagung der StiftungsInitiative JohannGottfriedHerder - KlausenBurg/ClujNapoca 7.-10. Oktober 2007\".\nVerdammt nochmal, was war hier geschehen? Wo war ich? Aber vor allem, und dies sorgte mich weitaus mehr: *Wann* war ich? \"2007\"? Das waren wieviele Jahre? Ich rechnete verzweifelt: 18 Jahre? Und ich erinnerte mich an Nichts dazwischen? War ich etwa JeMand anders? Ich durchsuchte meine Kleidung: Kein GeldBeutel. Kein PersonalAusweis. In der rechten hinteren Hosentasche waren mehrere Geldscheine, die ich noch nie zuvor gesehen hatte: \"EURO\" stand dort und darunter \"EYPΩ\". Drei 50er, ein 20er, ein 10er und ein 5er. \"BCE ECB EZB EKT EKP 2002\" stand auf einem der Scheine. 2002?\nOh mein Gott, da war noch der 5-EuRo-Schein: Kleiner als die anderen, und darauf stand \"BCE ECB EZB EKP EKT EKB BĊE EBC 2013\". 2013? Ich rechnete schon wieder: 24 Jahre??\nHoffentlich erkannte mich hier NieMand. Ich sollte mich irgendwo hin verziehen und in aller Ruhe die Lage sondieren. Vielleicht in diese Kirche? Ich schlich schnell über den ge-KopfSteinPflaster'ten Platz. Durch den Eingang \"A\" betrat ich dieses \"GottesHaus\" und suchte mir ein ruhiges BaenkChen in den hinteren Reihen. Ich schaute in die Hosentaschen und fand vorn rechts ein Gerät, das etwas grösser aber flacher war als eine Zigarettenschachtel. Es hatte oben und an der Seite kleine Tasten. Als ich die obere drückte, erleuchtete ein bunter Bildschirm von etwa 5 mal 7 cm, auf dem stand: \"16:34 - NettoKom - Tuesday, September 23\", darunter ein kleines Schlosssymbol und \"Draw pattern to unlock\" und ganz unten \"EmergencyCall\".\nIn der UmhaengeTasche war ein Schirm, eine Tabakdose, ein seltsames Gerät aus rotem und schwarzem Plastik und... ein Buch: Etwa Din-A5 groß, nur dünn und auf dem Umschlag ein sehr grob gerastertes Bild mit einer schönen grossbusigen Frau. »NooSphere« stand darüber in roten Lettern - von \"RainerWasserfuhr EtAlii\". Verdammt? _Mein_ Buch? \"Wie wir fast alle UnSterblich werden und @tineroyal ihrem TraumMann findet\", war der UnterTitel. Ich blätterte hinein und fand zunächst einen kleinen Pappzettel, etwa halb so gross wie das Buch. Darauf waren 3 Zeilen geschrieben: In der ersten \"ArvidNeibohm\", der zweiten \"peterwunram\" gefolgt von einem \"a\" mit einem seltsam gegen den Uhrzeigersinn umrandeten Kringel und mit \"yahoo . Ae\" abschliessend und in der dritten \"rainerwasserfuhr\" diesmal mit einem \"o\" umkringelt, von dem der Kreis oben ansetzte und die vollen 360% vollzog, dann \"gmail.com\". Doch auf dem PappZettel klebte auch eine VisitenKarte: \"Ray Kurzweil - CEO AND EDITOR-IN-CHIEF\", \"KurzweilAI.net\" \"15 Walnut Street\". Ich drehte den PappZettel um und sah jetzt erst, dass es die Rückseite von einem Foto war: Es zeigte von hinten einen sommerlich bekleideten Mann mit einem schwarzen Hund, ausserdem sitztend auf seiner BildHoehe eine rauchende Blondine und links ist ein halber Mann zu sehen.\nIch blättere im Buch. Nur die ersten Seiten waren bedruckt. Ich überflog zunächst die \"EndMontage\" \"SchickSaal\" oder \"BeuteSchema\". Ganz hinten \"AnLicht\", das eher an ein GeDicht ErInner'te. \n Auf den leeren Seiten folgten einige Zeichnungen, und dann mehrere Seiten mit engbeschriebenen Notizen. Ich versuchte, einiges davon zu entziffern, aber meine EnErgie schwandt. Wo sollte ich diese Nacht schlafen? Wo war ich überhaupt? Mein Blick ging zur Kuppel und wanderte die pastellfarbenen Wände entlang. Dann trat eine schlanke grössere, etwa 30jährige Frau in den KuppelBau. Sie zog ihre graue Mütze aus und schüttelte sich durchs aschfarbene Haar. Sie erblickte mich und ging zielstrebig in meine Richtung. Sie setzte sich neben mich. \"Hallo HeinRich, ich bin GretChen\". \"HeinRich\"? - In welchem Film war ich hier gelandet? Sie schwieg. Sie kannte mich. Ich rang um die richtigen Worte. War sie meinetwegen hier? *Wer* war sie? War sie *das* GretChen aus der NooSphere? Die \"hochbegabte KunstStudentin\", die irgendwas \"Morgenstern\" hiess? Sie gab mir einen bedruckten Zettel, auf dem oben gross \"RaWaGuide\" stand und ging wieder.";

 page(document,"InnBankSe",c);

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