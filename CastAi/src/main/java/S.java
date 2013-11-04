import java.io.File;
//import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import org.jcodec.api.FrameGrab;
import org.jcodec.common.model.Picture;

public class S {
  public static void main(String[] args) throws Exception {
      File f=new File("S117.mp4");
    //    FrameGrab grab = new FrameGrab(new File("S111.mp4"));

      Picture p=FrameGrab.getNativeFrame(f,0);

      System.out.println(p.getWidth());
	//BufferedImage frame = FrameGrab.getFrame(new File("filename.mp4"), 0);
	//ImageIO.write(frame, "png", new File("frame_150.png"));
    	for (int i = 0; i < 10; i++) {
	    //	    ImageIO.write(grab.getFrame(), "png",
	    //		  new File(System.getProperty("user.home"), String.format("frame%08d.png", i)));
	}
    }
}
