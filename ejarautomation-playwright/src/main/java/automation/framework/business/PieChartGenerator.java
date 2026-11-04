package automation.framework.business;

import org.knowm.xchart.BitmapEncoder;
import org.knowm.xchart.PieChart;
import org.knowm.xchart.PieChartBuilder;
import org.knowm.xchart.style.PieStyler;
import org.knowm.xchart.style.Styler;

import java.awt.*;

public class PieChartGenerator {


    public void createPieChartWithDate(long passCount, long failCount, String title,String pieChartName) {
        try {
            PieChart chart = new PieChartBuilder().width(350).height(262).title(title).theme(Styler.ChartTheme.GGPlot2).build();
            chart.getStyler().setLegendVisible(true);
            chart.getStyler().setChartBackgroundColor(new Color(	255, 255, 255));
            chart.getStyler().setChartTitleBoxBackgroundColor(new Color(	255, 255, 255));
            chart.getStyler().setChartTitleBoxBorderColor(new Color(	255, 255, 255));
            chart.getStyler().setLegendBackgroundColor(new Color(	255, 255, 255));
            chart.getStyler().setPlotBackgroundColor(new Color(	255, 255, 255));
            chart.getStyler().setAnnotationType(PieStyler.AnnotationType.Value);
            chart.getStyler().setAnnotationDistance(0);
            chart.getStyler().setPlotContentSize(.1);
            chart.getStyler().setStartAngleInDegrees(90);
            chart.getStyler().setPlotContentSize(1);
            chart.getStyler().setSumFontSize(1);
            chart.addSeries("Pass: " + passCount +" ", passCount).setFillColor(new Color(0, 128, 0));
            chart.addSeries("Fail: " + failCount+" ", failCount).setFillColor(new Color(138, 3, 3));
            BitmapEncoder.saveBitmapWithDPI(chart, System.getProperty("user.dir")+"/chartTempFolder/"+pieChartName, BitmapEncoder.BitmapFormat.PNG, 100);
        } catch (Exception e) {
            System.out.println("There was exception during generating  the pie chart image!:" + e.getMessage());
        }

    }

}


