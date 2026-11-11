package automation.framework.ApiAutomation.beans;

/** The login request and response */
public class AuthenticationRequestRecord {

    public record AuthenticationRequest(
            String userNameOrEmailAddress,
            String password,
            boolean rememberClient) {
    }

}