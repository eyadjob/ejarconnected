package automation.framework.business;



import automation.framework.threadData.TestData;

import javax.imageio.ImageIO;
import javax.media.MediaLocator;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;


/**
 * Main class that starts the Recording process of EasyCapture.
 *
 * @author eyad mubarak
 */
public class Recorder {

    /**
     * Screen Width.
     */
    public static int screenWidth = (int) Toolkit.getDefaultToolkit()
            .getScreenSize().getWidth();

    /**
     * Screen Height.
     */
    public static int screenHeight = (int) Toolkit.getDefaultToolkit()
            .getScreenSize().getHeight();

    /**
     * Interval between which the image needs to be captured.
     */
    public static int captureInterval = 50;


    /**
     * Status of the recorder.
     */
    public static boolean record = false;

    /**
     *
     */
    public static void startRecord() {
        System.out.println("started recording images in startRecord() ");
        Thread recordThread = new Thread() {
            @Override
            public void run() {
                Robot rt;
                int cnt = 0;
                try {
                    rt = new Robot();
                    while (cnt == 0 || record) {
                        BufferedImage img = rt
                                .createScreenCapture(new Rectangle(screenWidth,
                                        screenHeight));

                        File file = new File(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder());
                        boolean dirCreated = file.mkdir();
                        ImageIO.write(img, "jpeg", new File(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder()
                                + System.currentTimeMillis() + ".jpeg"));
                        if (cnt == 0) {
                            record = true;
                            cnt = 1;
                        }
                        // System.out.println(record);
                        Thread.sleep(captureInterval);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        };
        recordThread.start();
    }

    /**
     * @throws MalformedURLException
     */
    public static void makeVideo(String movFile) throws MalformedURLException {
        System.out.println("#### Easy Capture making video, please wait!!! ####");
        JpegImagesToMovie imageToMovie = new JpegImagesToMovie();

        Vector<String> imgLst = new Vector<String>();
        File f = new File(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder());
        File[] fileLst = f.listFiles();
        for (int i = 0; i < fileLst.length; i++) {
            imgLst.add(fileLst[i].getAbsolutePath());
        }
        // Generate the output media locators.
        MediaLocator oml;
        if ((oml = imageToMovie.createMediaLocator(movFile)) == null) {
            System.err.println("Cannot build media locator from: " + movFile);
            System.exit(0);
        }
        int captureInter = (1000 / captureInterval);
        imageToMovie.doIt(screenWidth, screenHeight, captureInter, imgLst, oml);

    }

    public static void stopRecord(String movieName) {
        Date x = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd,hh:mm:ss");
        String dateString = format.format(x);
        String newDate = dateString.replaceAll(" ", "").replace(":", "-");
        System.out.println("before making video");
        try {
            makeVideo(movieName + "_" + newDate + ".mov");
            FileHandler.deleteFilesInPath(TestData.getInstance().getThreadSharedMethods().get().getImagesTempFolder());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
