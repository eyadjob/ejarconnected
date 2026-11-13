package eyad.com.yelo.apisecuritychecker.bean;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.codehaus.jackson.annotate.JsonProperty;

/**
 * data set writer bean class that wrap two fields : contentId, StringToAdd
 *
 * @author eyadm@amazon.com
 */
@Slf4j
@Data
public class RegexSearchPayloadWrapper {

    @JsonProperty("file_name")
    String fileName;

    @JsonProperty("regex_query")
    String regexQuery;

}
