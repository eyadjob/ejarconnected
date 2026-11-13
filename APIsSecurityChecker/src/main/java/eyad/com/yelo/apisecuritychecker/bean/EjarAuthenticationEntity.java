package eyad.com.yelo.apisecuritychecker.bean;

import java.util.Objects;

public class EjarAuthenticationEntity {

    String userNameOrEmailAddress;
    String password;

    public EjarAuthenticationEntity() {
    }

    Boolean rememberClient = false;

    String twoFactorRememberClientToken = null;

    Boolean singleSignIn = false;

    String returnUrl = null;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EjarAuthenticationEntity that = (EjarAuthenticationEntity) o;
        return Objects.equals(userNameOrEmailAddress, that.userNameOrEmailAddress) && Objects.equals(password, that.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userNameOrEmailAddress, password);
    }


    public EjarAuthenticationEntity(String userNameOrEmailAddress, String password, Boolean rememberClient, String twoFactorRememberClientToken, Boolean singleSignIn, String returnUrl) {
        this.userNameOrEmailAddress = userNameOrEmailAddress;
        this.password = password;
        this.rememberClient = rememberClient;
        this.twoFactorRememberClientToken = twoFactorRememberClientToken;
        this.singleSignIn = singleSignIn;
        this.returnUrl = returnUrl;
    }

    public EjarAuthenticationEntity(String userNameOrEmailAddress, String password) {
        this.userNameOrEmailAddress = userNameOrEmailAddress;
        this.password = password;
    }

    public String getUserNameOrEmailAddress() {
        return userNameOrEmailAddress;
    }

    public void setUserNameOrEmailAddress(String userNameOrEmailAddress) {
        this.userNameOrEmailAddress = userNameOrEmailAddress;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getRememberClient() {
        return rememberClient;
    }

    public void setRememberClient(Boolean rememberClient) {
        this.rememberClient = rememberClient;
    }

    public String getTwoFactorRememberClientToken() {
        return twoFactorRememberClientToken;
    }

    public void setTwoFactorRememberClientToken(String twoFactorRememberClientToken) {
        this.twoFactorRememberClientToken = twoFactorRememberClientToken;
    }

    public Boolean getSingleSignIn() {
        return singleSignIn;
    }

    public void setSingleSignIn(Boolean singleSignIn) {
        this.singleSignIn = singleSignIn;
    }

    public String getReturnUrl() {
        return returnUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }

//    {"userNameOrEmailAddress":"ejaradmin","password":"123456","rememberClient":false,"twoFactorRememberClientToken":null,"singleSignIn":false,"returnUrl":null}

}
