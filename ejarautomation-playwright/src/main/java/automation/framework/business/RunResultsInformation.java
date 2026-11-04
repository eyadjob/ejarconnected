package automation.framework.business;


public class RunResultsInformation {

    static final String scenariosTestStatusPieChartName = "testScenariosStatusPieChart_300_DPI";
    static final String testStepsTestStatusPieChartName = "testStepsStatusPieChart_300_DPI";

    long scenarioPassCount = 0;
    long scenarioFailCount = 0;
    long featureCount = 0;
    long testCount = 0;

    long testStepsPassCount = 0;
    long testStepsFailCount = 0;

    public long getTestStepsPassCount() {
        return testStepsPassCount;
    }

    public void setTestStepsPassCount(long testStepsPassCount) {
        this.testStepsPassCount = testStepsPassCount;
    }

    public long getTestStepsFailCount() {
        return testStepsFailCount;
    }

    public void setTestStepsFailCount(long testStepsFailCount) {
        this.testStepsFailCount = testStepsFailCount;
    }

    public long getScenarioPassCount() {
        return scenarioPassCount;
    }

    public void setScenarioPassCount(long scenarioPassCount) {
        this.scenarioPassCount = scenarioPassCount;
    }

    public long getScenarioFailCount() {
        return scenarioFailCount;
    }

    public void setScenarioFailCount(long scenarioFailCount) {
        this.scenarioFailCount = scenarioFailCount;
    }

    public long getFeatureCount() {
        return featureCount;
    }

    public void setFeatureCount(long featureCount) {
        this.featureCount = featureCount;
    }

    public long getTestCount() {
        return testCount;
    }

    public void setTestCount(long testCount) {
        this.testCount = testCount;
    }

}
