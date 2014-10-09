<%@page import="
java.io.ByteArrayOutputStream,
java.io.OutputStream,
com.itextpdf.text.Document,
com.itextpdf.text.DocumentException,
com.itextpdf.text.Paragraph,
com.itextpdf.text.pdf.PdfWriter
"%>
<% //http://itextpdf.com/examples/iia.php?id=173
 response.setContentType("application/pdf");
 response.setContentType("application/pdf");
           String text="»NooSphere«";
 Document document = new Document();
            // step 2
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            // step 3
            document.open();
            // step 4
            document.add(new Paragraph(String.format(
                "You have submitted the following text using the %s method:",
                request.getMethod())));
            document.add(new Paragraph(text));
            // step 5
            document.close();
 response.setContentLength(baos.size());
            // write ByteArrayOutputStream to the ServletOutputStream
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
            %>