package eyad.com.yelo.apisecuritychecker.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import eyad.com.yelo.apisecuritychecker.business.PropManager;
import eyad.com.yelo.apisecuritychecker.business.SendAggregatedReport;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Service class that handle the operations on data set : read, search, write, list.
 *
 * @author eyadm@amazon.com
 */

@Service
public class CheckerService {

    int environmentDownTimeCounter = 0;

    public String objectConverterToJSONString(Object payload) {

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
            return objectMapper.writeValueAsString(payload);
        } catch (Exception exception) {
            System.out.println("objectConverterToJSONString : " + exception);
        }
        return null;
    }

    public void setResponseTypesConfigurations(RestTemplate restTemplate) {
        List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.APPLICATION_JSON_UTF8));
        messageConverters.add(converter);
        restTemplate.setMessageConverters(messageConverters);
    }

    public String[] requestAPi(String apiUri, String requestMethod) {
        System.out.println("We are requesting the following API: " + apiUri);
        String[] requestResults = new String[4];
        RestTemplate restTemplate = new RestTemplate();
        setResponseTypesConfigurations(restTemplate);
        requestResults[2] = "false";
        try {
            switch (requestMethod.trim()) {
                case "post":
                    restTemplate.postForEntity(apiUri, objectConverterToJSONString(new Object()), Object.class);
                    break;
                case "get":
                    restTemplate.getForEntity(apiUri, Object.class);
                    break;
                case "put":
                    restTemplate.put(apiUri, objectConverterToJSONString(new Object()), Object.class);
                    break;
                case "delete":
                    restTemplate.delete(apiUri, objectConverterToJSONString(new Object()), Object.class);
                    break;
            }
        } catch (Exception e) {
            if (!e.getMessage().contains("401")) {
                requestResults[2] = "true";
            }
            requestResults[3] = e.getMessage();
        }
        requestResults[0] = apiUri;
        requestResults[1] = requestMethod;
        if (requestResults[3] == null || requestResults[3].isEmpty()) requestResults[3] = "200";
        return requestResults;
    }

    public ResponseEntity requestGetAPi(String apiUri) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = null;
        try {
            response = restTemplate.getForEntity(apiUri, String.class);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            return response;
        }
    }

    public void validateAPisSecurityForEjar() {
        try {
            ResponseEntity<String> swaggerResponse = requestGetAPi(PropManager.getInstance().getProperty("ejar.environment.url")+"swagger/v1/swagger.json");
            if (swaggerResponse == null || swaggerResponse.getBody() == null) {
                System.out.println("Error: Failed to retrieve swagger.json. Response is null.");
                return;
            }
            
            String ejarAPIs = swaggerResponse.getBody();
            if (ejarAPIs == null || ejarAPIs.isEmpty()) {
                System.out.println("Error: Swagger.json body is empty.");
                return;
            }
            
            Map<String, String> ejarApis = regxExtractor("(?=\")(.*):\\s\\{\\s+(\"post\"|\"get\"|\"put\"|\"delete\")", ejarAPIs);
            if (ejarApis == null || ejarApis.isEmpty()) {
                System.out.println("Warning: No APIs found in swagger.json using the regex pattern.");
            }
            int i=0;
            Map<String, String> apiWithoutAuthentication = new HashMap<>();
            for (Map.Entry<String, String> api : ejarApis.entrySet()) {
                String[] results = requestAPi(api.getKey(), api.getValue());
                if (results != null && results.length >= 4) {
                    apiWithoutAuthentication.put(results[0], results[1] + "," + results[2] + "," + results[3]);
                }
            }
            
            if (apiWithoutAuthentication.isEmpty()) {
                System.out.println("Warning: No API results to report. Email will not be sent.");
                return;
            }
            
            new SendAggregatedReport("Automation API Security Validation").buildTestResultsContent(apiWithoutAuthentication);
        } catch (Exception e) {
            System.out.println("Error in validateAPisSecurityForEjar: " + e.getMessage());
            e.printStackTrace();
        }
    }


    public Map<String, String> regxExtractor(String regxPattern, String text) {
        Map<String, String> ejarApis = new HashMap<>();
        Pattern pattern = Pattern.compile(regxPattern); // matches three-letter words
        Matcher matcher = pattern.matcher(text);
        while (matcher.find()) {
            ejarApis.put(PropManager.getInstance().getProperty("ejar.environment.url") + matcher.group(1).replace("\"", ""), matcher.group(2).replace("\"", ""));
            System.out.println(matcher.group());
        }
        return ejarApis;
    }

}
