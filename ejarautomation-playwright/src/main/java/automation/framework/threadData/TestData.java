package automation.framework.threadData;


import lombok.Getter;

@Getter
public class TestData {
    public static TestData testData = new TestData();
    ThreadLocal<SharedMethods> threadSharedMethods = new ThreadLocal<>();

    private TestData() {
    }

    public static TestData getInstance() {
        if (testData == null)
            synchronized (TestData.class) {
                if (testData == null) {
                    testData = new TestData();
                }
            }
        if ( testData.getThreadSharedMethods().get() == null)
            testData.getThreadSharedMethods().set(new SharedMethods("initial","initial"));
        return testData;
    }
}
