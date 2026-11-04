package automation.framework.listener;

import io.cucumber.plugin.EventListener;
import io.cucumber.plugin.event.EventHandler;
import io.cucumber.plugin.event.EventPublisher;
import io.cucumber.plugin.event.TestRunFinished;
import io.cucumber.plugin.event.TestRunStarted;

public class TestEventHandlerPlugin implements EventListener {

    private final EventHandler<TestRunFinished> teardown = event -> {
        System.out.println("we have reached TestRunFinished");
    };
    private final EventHandler<TestRunStarted> handleRunStarted = event -> {
        System.out.println("we have reached TestRunFinished");
    };
    private final EventHandler<TestRunStarted> starting = event -> {
        System.out.println("we have reached TestRunStarted");
    };

    @Override
    public void setEventPublisher(EventPublisher eventPublisher) {
        eventPublisher.registerHandlerFor(TestRunFinished.class, teardown);
        eventPublisher.registerHandlerFor(TestRunStarted.class, starting);
        eventPublisher.registerHandlerFor(TestRunStarted.class, this.handleRunStarted);
    }
}
