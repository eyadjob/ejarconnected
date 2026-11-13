package eyad.com.yelo.apisecuritychecker.service;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

@Service
public class ApiRequester {


    public HttpHeaders buildHeaders() {
        final String uri = "http://ejar-jor-test.iyelo.com:5800/api/TokenAuth/Authenticate";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Connection", "keep-alive");
        headers.set("Abp.TenantId", "1");
        headers.set("Host", "ejar-jor-test.iyelo.com:5800");
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0");
        headers.set("Accept", "application/json");
        headers.set("Accept-Language", "en");
        headers.set("Accept-Encoding", "gzip, deflate");
        headers.set("Content-Type", "application/json");
        headers.set("Pragma", "no-cache");
        headers.set("Cache-Control", "no-cache");
        headers.set("Expires", "Sat, 01 Jan 2000 00:00:00 GMT");
        headers.set("X-Requested-With", "XMLHttpRequest");
        headers.set(".AspNetCore.Culture", "en");
        headers.set("Origin", "http://172.16.30.17:5800");
        headers.set("Connection", "keep-alive");
        headers.set("Referer", "http://172.16.30.17:5800}/account/login");
        headers.set("Content-Length", "155");
        return headers;
    }


}
