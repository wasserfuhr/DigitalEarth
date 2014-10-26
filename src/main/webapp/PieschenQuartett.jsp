B6~<%@ page pageEncoding="UTF-8"%><%@page import="
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
com.itextpdf.text.pdf.PdfPCell,
com.itextpdf.text.pdf.PdfPTable,
com.itextpdf.text.pdf.PdfWriter
"%><%!

%>
<% // http://itextpdf.com/examples/iia.php?id=173
 String tapeOut="545";
 short rc=4;
 response.setContentType("application/pdf");
 response.setHeader("Content-Disposition", "inline; filename=\"PqTapeOut"+tapeOut+"Rc"+rc+".pdf\"");

 Document doc = new Document();
 ByteArrayOutputStream baos = new ByteArrayOutputStream();
 final PdfWriter writer = PdfWriter.getInstance(doc, baos);
 doc.open();
 doc.add(new Paragraph("PieschenQuartett"));
 //PdfPTable table = new PdfPTable(new float[] { 1, 1 });
 PdfPTable table = new PdfPTable(2);
 PdfPCell cell = new PdfPCell(new Phrase("RaWa"));
 cell.setColspan(2);
 table.addCell(cell);
 PdfPCell cell1 = new PdfPCell(new Phrase("KayGroschen"));
 PdfPCell cell2 = new PdfPCell(new Phrase(">100000"));
 table.addCell(cell1);
 table.addCell(cell2);
 table.setWidthPercentage(100f);
 //img=Image.getInstance("/home/rawa/DerAugenblick.jpg");
 //img.scaleToFit(320, 240);
 //doc.add(img);
 doc.add(table);
 doc.close();
 response.setContentLength(baos.size());
 OutputStream os = response.getOutputStream();
 baos.writeTo(os);
 os.flush();
 os.close();
%>