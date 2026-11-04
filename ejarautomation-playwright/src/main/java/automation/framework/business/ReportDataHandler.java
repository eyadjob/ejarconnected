package automation.framework.business;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
public class ReportDataHandler {
    private String reportFileName;
    private int testCountInScenario;
    private int passCount;
    private int failCount;
    private int otherCount;
    private String featureName;
    private Date startTime;
    private Date endTime;
    private String startTimeString;
    private String endTimeString;
    private String elapsedTime;
    private String scenarioName;
    private String testReportFolder;
    private boolean allPass = false;
    private boolean allFail = false;

    public ReportDataHandler(String featureName, Date startTime, Date endTime, String elapsedTime, String reportFileName) {
        this.featureName = featureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.elapsedTime = elapsedTime;
        this.reportFileName = reportFileName;
    }
    public ReportDataHandler(String featureName, Date startTime, Date endTime, String elapsedTime) {
        this.featureName = featureName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.elapsedTime = elapsedTime;
    }

}
