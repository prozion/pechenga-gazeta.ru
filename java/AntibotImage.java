package ru.ds.antibot;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.awt.image.AffineTransformOp;
import java.awt.geom.AffineTransform;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;

public class AntibotImage implements HttpSessionBindingListener {

	private final int STR_LEN = 4;

	private String realpath;
	private int width;
	private int height;
	String code;

	private File af;
	private String filename;

	private BufferedImage resbi;

	public AntibotImage(int width, int height, String realpath) {
		this.realpath = realpath;
		this.width = width;
		this.height = height;
	}

	public void createImage() throws IOException {

		formRndString();

		createFileName();
		String realname = realpath + "/" + filename;

		af = new File(realname);
		ImageIO.write(resbi, "gif", af);
	}

	public boolean deleteFile() throws IOException {

		return af.delete();
	}

	public String getCode() {

		return code;
	}

	public File getFile() {

		return af;
	}

	public String getFileName() {

		return filename;
	}

	private void createFileName() {

		filename = Integer.toString(Math.abs((new Date()).toString().hashCode()))
				+ ".gif";
	}

	private void formRndString() {

		code = "";
		resbi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		int width2 = (int) Math.floor(width * 0.8);
		Graphics2D gg = resbi.createGraphics();
		for (int i = 0; i < STR_LEN; i++) {
			gg.drawImage(getRndChar(), new AffineTransformOp(new AffineTransform(
					1 + rndN(), rndN(), rndN(), 1 + rndN(), rndN(), rndN()),
					AffineTransformOp.TYPE_BICUBIC), width / 10 + (width2 / STR_LEN) * i,
					height / 4);
		}
		//mesh_grid();
	}

	private BufferedImage getRndChar() {

		String ch = Integer.toString((int) Math.floor(Math.random() * 10)); // (math.floor (* (math.random) 10))
		code = code + ch;
		BufferedImage bufbufimg = new BufferedImage(width / STR_LEN, height,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D bufg = bufbufimg.createGraphics();

		bufg.setFont(new Font("Courier New", Font.BOLD, 15));
		bufg.setColor(new Color(0xf0, 0xf0, 0xf0));
		bufg.drawString(ch, 0, height / 2);

		return bufbufimg;

	}

	private void mesh_grid() {

		int amount = (int) Math.floor(Math.random() * 3)
				+ (int) Math.floor(Math.random() * 3);
		Graphics2D gg = resbi.createGraphics();
		gg.setColor(new Color(0xf0, 0xf0, 0xf0));
		for (int i = 0; i < amount; i++) {
			gg.drawLine(rndX(), rndY(), rndX(), rndY());
		}
	}

	private double rndN() {

		return (Math.random() - 0.5) * 0.5;
	}

	private int rndX() {

		return (int) (Math.random() * width);
	}

	private int rndY() {

		return (int) (Math.random() * height);
	}

	// HttpSessionBindingListener methods:
	public void valueBound(HttpSessionBindingEvent hsbe) {

	}

	public void valueUnbound(HttpSessionBindingEvent hsbe) {

		af.delete();
	}
}
