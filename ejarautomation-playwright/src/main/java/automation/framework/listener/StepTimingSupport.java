package automation.framework.listener;

/**
 * Carries the label of the step that is currently running on this thread.
 *
 * <p>{@link automation.framework.listener.StepTimingFormatter} only knows the step text when Cucumber
 * actually instantiates it, which happens for Maven/runner executions but not when a {@code .feature}
 * file is started straight from the IDE. Step definitions that already know their own text (the AI/MCP
 * steps) publish it here, and the generic hook falls back to it when Extent has no step name either.</p>
 */
public final class StepTimingSupport {

    private static final ThreadLocal<String> LABEL = new ThreadLocal<>();

    private StepTimingSupport() {
    }

    public static void setLabel(String label) {
        LABEL.set(label);
    }

    public static String getLabel() {
        return LABEL.get();
    }

    public static void clearLabel() {
        LABEL.remove();
    }
}
