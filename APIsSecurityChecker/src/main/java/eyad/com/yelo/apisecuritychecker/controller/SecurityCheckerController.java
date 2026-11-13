package eyad.com.yelo.apisecuritychecker.controller;

import eyad.com.yelo.apisecuritychecker.service.CheckerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * explore data set controller
 *
 * @author eyadm@amazon.com
 */

@RestController
@Slf4j
@RequestMapping("/SecurityValidator")
public class SecurityCheckerController {

    @Autowired
    private CheckerService checkerService;

    @RequestMapping(path = "/ValidateEjarAPis/", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, String>> searchAllDataSet() {
        try {
            checkerService.validateAPisSecurityForEjar();
            Map<String, String> response = new HashMap<>();
            response.put("status", "success");
            response.put("message", "API security validation started. Email will be sent upon completion.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("Error in ValidateEjarAPis endpoint: {}", e.getMessage(), e);
            Map<String, String> response = new HashMap<>();
            response.put("status", "error");
            response.put("message", "An error occurred: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

}
