package automation.framework.business;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CsvColumnReader {
    /**
     * Reads specific columns from a CSV file
     *
     * @param filePath      Path to the CSV file
     * @param columnIndices Zero-based indices of columns to read
     * @param hasHeader     Whether the CSV has a header row
     * @return List of maps where each map represents a row with column indices as keys
     * @throws IOException  If there's an error reading the file
     * @throws CsvException If there's an error parsing the CSV
     */
    public static List<Map<Integer, String>> readSpecificColumns(String filePath, List<Integer> columnIndices, boolean hasHeader) throws IOException, CsvException {

        List<Map<Integer, String>> result = new ArrayList<>();

        try (CSVReader reader = new CSVReader(new FileReader(filePath))) {
            List<String[]> allRows = reader.readAll();

            // Skip header if present
            int startRow = hasHeader ? 1 : 0;

            for (int i = startRow; i < allRows.size(); i++) {
                String[] row = allRows.get(i);
                Map<Integer, String> columnData = new HashMap<>();

                for (int colIndex : columnIndices) {
                    if (colIndex < row.length) {
                        columnData.put(colIndex, row[colIndex]);
                    } else {
                        columnData.put(colIndex, null); // or empty string based on your needs
                    }
                }
                result.add(columnData);
            }
        }

        return result;
    }

    /**
     * Alternative version that reads columns by header names
     *
     * @param filePath Path to the CSV file
     * @return List of maps where each map represents a row with column names as keys
     */


    public static Map<String, List<List<String>>> readColumnsGroupByThreadName(String filePath, String threadColumnName, String stepColumnName, String responseCodeColumnName, String responseMessageColumnName, String timeStampColumnName) {
        Map<String, List<List<String>>> result = new HashMap<>();

        try (CSVReader reader = new CSVReader(new FileReader(filePath))) {
            List<String[]> allRows = reader.readAll();

            if (allRows.isEmpty()) {
                return result;
            }

            String[] headers = allRows.get(0);
            Map<String, Integer> headerMap = new HashMap<>();

            // Create mapping from column name to index
            for (int i = 0; i < headers.length; i++) {
                headerMap.put(headers[i], i);
            }
            List<List<String>> threadGroupSteps = new ArrayList<>();
            List<String> stepLabelAndResult = new ArrayList<>();

            for (int i = 1; i < allRows.size(); i++) {
                String[] row = allRows.get(i);
                Integer threadColumnIndex = headerMap.get(threadColumnName);
                String threadGroupName = row[threadColumnIndex];
                if (result.get(threadGroupName) == null) {
                    threadGroupSteps = new ArrayList<>();
                    stepLabelAndResult = new ArrayList<>();
                    result.put(threadGroupName, threadGroupSteps);
                }

                if (threadColumnIndex != null && threadColumnIndex < row.length) {
                    Integer responseCodeColumnIndex = headerMap.get(responseCodeColumnName);
                    Integer responseMessageColumnIndex = headerMap.get(responseMessageColumnName);
                    Integer testSteColumnIndex = headerMap.get(stepColumnName);
                    Integer timeStampColumnIndex = headerMap.get(timeStampColumnName);
                    String testStepLabel = row[testSteColumnIndex];
                    String responseCode = row[responseCodeColumnIndex];
                    String responseMessage = row[responseMessageColumnIndex];
                    String timeStamp = row[timeStampColumnIndex];

                    stepLabelAndResult.add(testStepLabel);
                    stepLabelAndResult.add(responseCode);
                    stepLabelAndResult.add(responseMessage);
                    stepLabelAndResult.add(timeStamp);
                    threadGroupSteps.add(stepLabelAndResult);
                    result.put(threadGroupName, threadGroupSteps);
                    stepLabelAndResult = new ArrayList<>();

                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (CsvException e) {
            throw new RuntimeException(e);
        }
        System.out.println("Inside CSV test cases name reader, and the value of the test cases names and it steps were: ");
        result.entrySet().stream()
                .flatMap(entry ->
                        entry.getValue().stream()  // Stream of List<String>
                                .flatMap(List::stream) // Stream of String
                                .peek(value -> System.out.println(
                                        "Test Case name: " + entry.getKey() + ", Value: " + value
                                ))
                )
                .count(); // Terminal operation to trigger the stream

        return result;
    }

    public static List<Map<String, String>> readColumnsByName(String filePath, List<String> columnNames) throws IOException, CsvException {

        List<Map<String, String>> result = new ArrayList<>();

        try (CSVReader reader = new CSVReader(new FileReader(filePath))) {
            List<String[]> allRows = reader.readAll();

            if (allRows.isEmpty()) {
                return result;
            }

            String[] headers = allRows.get(0);
            Map<String, Integer> headerMap = new HashMap<>();

            // Create mapping from column name to index
            for (int i = 0; i < headers.length; i++) {
                headerMap.put(headers[i], i);
            }

            for (int i = 1; i < allRows.size(); i++) {
                String[] row = allRows.get(i);
                Map<String, String> columnData = new HashMap<>();

                for (String colName : columnNames) {
                    Integer colIndex = headerMap.get(colName);
                    if (colIndex != null && colIndex < row.length) {
                        columnData.put(colName, row[colIndex]);
                    } else {
                        columnData.put(colName, null);
                    }
                }
                result.add(columnData);
            }
        }

        return result;
    }

    public static void main(String[] args) {
        String csvFile = "data.csv";
        List<Integer> columnsToRead = new ArrayList<>();
        columnsToRead.add(0);// Read first, third and fifth columns
        columnsToRead.add(2);
        columnsToRead.add(4);

        try {
            // Read by column indices
            List<Map<Integer, String>> dataByIndex = readSpecificColumns(csvFile, columnsToRead, true);
            System.out.println("Data read by column indices:");
            dataByIndex.forEach(System.out::println);

            // Read by column names
            List<String> columnNames = new ArrayList<>();
            columnNames.add("Name");
            columnNames.add("Email");
            columnNames.add("Phone");
            List<Map<String, String>> dataByName = readColumnsByName(csvFile, columnNames);
            System.out.println("\nData read by column names:");
            dataByName.forEach(System.out::println);

        } catch (IOException | CsvException e) {
            System.err.println("Error reading CSV file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}