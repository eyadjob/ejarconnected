package automation.framework;

import java.util.HashMap;
import java.util.Map;

public class ScenarioContextSingleton {

    private static ScenarioContextSingleton instance;
    private Map<String, String> scenarioContext = new HashMap<>();

    private ScenarioContextSingleton() {

    }

    public static ScenarioContextSingleton getInstance() {
        if (instance == null) {
            synchronized (ScenarioContextSingleton.class) {
                if (instance == null) {
                    instance = new ScenarioContextSingleton();
                }
            }
        }
        return instance;
    }

    public void setContextValue(String key, String value) {
        this.scenarioContext.put(key, value);
    }

    public String getContextValue(String key) {
        return (String) this.scenarioContext.get(key);
    }

    public Boolean isContainsKey(String key) {
        return this.scenarioContext.containsKey(key);
    }
}
