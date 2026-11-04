package automation.framework.business;

public class SoftAssertBean {

    private String message;
    private boolean expected;
    private boolean actual;
    private boolean results;

    public SoftAssertBean(boolean expected, boolean actual,String message) {
        this.message = message;
        this.expected = expected;
        this.actual = actual;
        results = getResults();
    }

    public boolean getResults() {
        return actual == expected;
    }


    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isExpected() {
        return expected;
    }

    public void setExpected(boolean expected) {
        this.expected = expected;
    }

    public boolean isActual() {
       return actual;
    }



}
