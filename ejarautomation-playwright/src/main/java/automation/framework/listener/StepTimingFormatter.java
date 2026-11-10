package automation.framework.listener;

import io.cucumber.plugin.EventListener;
import io.cucumber.plugin.event.EventPublisher;
import io.cucumber.plugin.event.HookTestStep;
import io.cucumber.plugin.event.PickleStepTestStep;
import io.cucumber.plugin.event.Status;
import io.cucumber.plugin.event.TestCase;
import io.cucumber.plugin.event.TestCaseFinished;
import io.cucumber.plugin.event.TestCaseStarted;
import io.cucumber.plugin.event.TestStep;
import io.cucumber.plugin.event.TestStepFinished;

/**
 * Console formatter that prints every step followed by a TAB and the time it took, then a scenario
 * total. Replaces Cucumber's {@code pretty} plugin for the AI/MCP runner.
 *
 * <pre>
 *   Scenario: Login page renders the expected elements  # .../yelo login page via mcp.feature:7
 *     Given the Playwright MCP browser is started      2103 ms
 *     When I open the Yelo login page at "https://..." 4387 ms
 *   Scenario: Login page renders the expected elements 18900 ms PASSED
 * </pre>
 *
 * Use it with {@code --plugin automation.framework.listener.StepTimingFormatter}.
 */
public class StepTimingFormatter implements EventListener {

    private static final String TAB = "\t";

    private String currentScenario = "";

    @Override
    public void setEventPublisher(EventPublisher publisher) {
        publisher.registerHandlerFor(TestCaseStarted.class, this::onTestCaseStarted);
        publisher.registerHandlerFor(TestStepFinished.class, this::onStepFinished);
        publisher.registerHandlerFor(TestCaseFinished.class, this::onTestCaseFinished);
    }

    private void onTestCaseStarted(TestCaseStarted event) {
        TestCase testCase = event.getTestCase();
        currentScenario = testCase.getName();
        System.out.println("  Scenario: " + currentScenario
                + "  # " + testCase.getUri() + ":" + testCase.getLocation().getLine());
    }

    private void onStepFinished(TestStepFinished event) {
        long millis = durationMillis(event);
        Status status = event.getResult().getStatus();
        String line = "    " + describe(event.getTestStep())
                + TAB + millis + " ms"
                + (status == Status.PASSED ? "" : TAB + status.name());
        System.out.println(line);
    }

    private void onTestCaseFinished(TestCaseFinished event) {
        System.out.println("  Scenario: " + currentScenario
                + TAB + durationMillis(event) + " ms"
                + TAB + event.getResult().getStatus().name());
    }

    private static String describe(TestStep step) {
        if (step instanceof PickleStepTestStep) {
            PickleStepTestStep pickleStep = (PickleStepTestStep) step;
            return pickleStep.getStep().getKeyword() + pickleStep.getStep().getText();
        }
        if (step instanceof HookTestStep) {
            String type = ((HookTestStep) step).getHookType().name();
            return "@" + type.charAt(0) + type.substring(1).toLowerCase();
        }
        return step.getClass().getSimpleName();
    }

    private static long durationMillis(io.cucumber.plugin.event.Event event) {
        java.time.Duration duration = resultOf(event).getDuration();
        return duration == null ? 0L : duration.toMillis();
    }

    private static io.cucumber.plugin.event.Result resultOf(io.cucumber.plugin.event.Event event) {
        if (event instanceof TestStepFinished) {
            return ((TestStepFinished) event).getResult();
        }
        return ((TestCaseFinished) event).getResult();
    }
}
