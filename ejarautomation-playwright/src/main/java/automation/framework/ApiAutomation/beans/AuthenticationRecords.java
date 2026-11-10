package automation.framework.ApiAutomation.beans;

/** The login request and response */
public class AuthenticationRecords {

    public record AuthenticationRequest(
            String userNameOrEmailAddress,
            String password,
            boolean rememberClient) {
    }

    public record AuthenticationResponse(Result result, boolean success) {
    }

    public record Result(String accessToken) {
    }
}