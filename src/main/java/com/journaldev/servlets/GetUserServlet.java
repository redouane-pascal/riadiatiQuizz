package main.java.com.journaldev.servlets;

import java.awt.AWTException;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetUserServlet")
public class GetUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String quizzNumber = request.getParameter("quizzNumber");
		RenderedImage image = takePicture(quizzNumber);
		if(image != null){
			ImageIO.write(image, "PNG", response.getOutputStream());
		}
	}

	private RenderedImage takePicture(String quizzNumber) {
		String FILE_PATH = getServletContext().getRealPath("/WEB-INF/destination/");

		try {
			Robot robot = new Robot();
			BufferedImage screenShot = robot.createScreenCapture(new Rectangle(Toolkit.getDefaultToolkit().getScreenSize()));

			ImageIO.write(screenShot, "png", new File(FILE_PATH + quizzNumber + "_old.png"));
			System.out.println("screenShot taken");

			File imageFile = new File(FILE_PATH + quizzNumber + "_old.png");

			BufferedImage bufferedImage = ImageIO.read(imageFile);
			RenderedImage image = cropImage(bufferedImage, 564, 97, 710, 600);
			File pathFile = new File(FILE_PATH + quizzNumber + ".png");
			ImageIO.write(image, "png", pathFile);
			System.out.println("Done");

			return image;
		} catch (IOException e) {
			e.printStackTrace();
		} catch (AWTException e) {
			e.printStackTrace();
		}
		return null;
	}

	private BufferedImage cropImage(BufferedImage bufferedImage, int x, int y, int width, int height) {
		BufferedImage croppedImage = bufferedImage.getSubimage(x, y, width, height);
		return croppedImage;
	}

}
