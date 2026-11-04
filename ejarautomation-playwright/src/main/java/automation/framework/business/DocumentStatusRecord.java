package automation.framework.business;

public record DocumentStatusRecord(
    String interactive,   // DOMContentLoaded / ready
    String complete,      // Fully loaded (load event)
    String load
) {

    // Static instance for easy access (recommended way)
    public static final DocumentStatusRecord INSTANCE = new DocumentStatusRecord(
            "interactive",
            "complete",
            "load"
    );

    // Convenience constructor (optional)
    public DocumentStatusRecord() {
        this("interactive", "complete", "loading");
    }
}
