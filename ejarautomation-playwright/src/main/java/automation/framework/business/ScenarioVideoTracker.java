package automation.framework.business;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Tracks scenario-name → relative-video-path mappings for the current test run.
 * Uses an ordered list so duplicate scenario names are handled correctly.
 * Populated by {@link stepdefs.generic.Hook} and consumed by
 * {@link automation.framework.business.SendAggregatedReport} during HTML post-processing.
 */
public class ScenarioVideoTracker {

    private static final List<Entry> ENTRIES = Collections.synchronizedList(new ArrayList<>());

    public static void add(String scenarioName, String videoRelativePath) {
        add(scenarioName, videoRelativePath, null);
    }

    public static void add(String scenarioName, String videoRelativePath, String oneDriveLink) {
        ENTRIES.add(new Entry(scenarioName, videoRelativePath, oneDriveLink));
    }

    public static List<Entry> getAll() {
        return new ArrayList<>(ENTRIES);
    }

    public static void clear() {
        ENTRIES.clear();
    }

    public static class Entry {
        public final String scenarioName;
        public final String videoPath; // null when no video was kept
        public String oneDriveLink;    // shareable OneDrive URL, null until uploaded

        public Entry(String scenarioName, String videoPath, String oneDriveLink) {
            this.scenarioName = scenarioName;
            this.videoPath = videoPath;
            this.oneDriveLink = oneDriveLink;
        }
    }
}
