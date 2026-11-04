package automation.framework.beans;


/**
 * Utility class for building HTML tables with consistent styling
 * Provides fluent interface for table construction
 */
public class HtmlTableBuilderForSoftAssertions {
    private final StringBuilder table = new StringBuilder();

    public HtmlTableBuilderForSoftAssertions startTable() {
        table.append("<table border='1' style='width:100%; border-collapse: collapse;'>");
        return this;
    }

    public HtmlTableBuilderForSoftAssertions addHeaderRow(String... headers) {
        table.append("<tr>");
        for (String header : headers) {
            table.append("<th>").append(header).append("</th>");
        }
        table.append("</tr>");
        return this;
    }

    public HtmlTableBuilderForSoftAssertions addDataRow(String backgroundColor, String... cells) {
        table.append("<tr style='background-color: ").append(backgroundColor).append(";'>");
        for (String cell : cells) {
            table.append("<td>").append(cell).append("</td>");
        }
        table.append("</tr>");
        return this;
    }

    public String build() {
        table.append("</table>");
        return table.toString();
    }
}