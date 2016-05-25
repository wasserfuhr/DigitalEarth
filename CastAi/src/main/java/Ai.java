import java.io.File;
import org.jcodec.api.FrameGrab;
import org.jcodec.common.model.Picture;
public class Ai{
 public static void main(String[]a) throws Exception{
  File f=new File(System.getProperty("user.home"),"TerraDrive/8d972587a19fc69e328529b283c6243ed5a9845c.mp4");
  Picture p=FrameGrab.getNativeFrame(f,0);
  System.out.println(p.getWidth()+"x"+p.getHeight()+":");
  for(int i=0; i<8; i++) {
   for(int j=0; j<8; j++) {
    System.out.print(p.getData()[i][j]+" ");}
   System.out.println("");}}}
