package automation.framework.business;

public enum EnvironmentNames {
    Yelo,
    Alyam,
    Safwa,
    Ejar;

    public static EnvironmentNames fromString(String name) {
        if (name == null) {
            throw new IllegalArgumentException("Name cannot be null");
        }
        for (EnvironmentNames env : values()) {
            if (env.name().equalsIgnoreCase(name.strip())) {
                return env;
            }
        }
        throw new IllegalArgumentException("Unknown environment: " + name);
    }
}
