package automation.framework.ApiAutomation.beans;

import com.google.gson.JsonElement;

public record ComboboxResponseRecord(result result) {

    public record result(Item[] items) {

        public record Item(String displayText, boolean isSelected, int value) {

        }
    }

}