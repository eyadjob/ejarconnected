package automation.framework.ApiAutomation.beans;

public class AuthenticationResponseRecord {
    public record AuthenticationResponse(Result result, boolean success) {
    }

    public record Result(String accessToken) {
    }
}
