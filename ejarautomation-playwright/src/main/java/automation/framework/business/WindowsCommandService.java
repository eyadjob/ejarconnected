package automation.framework.business;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class WindowsCommandService {


    public String executeWindowsCommand(String commandString) {

        StringBuilder output = new StringBuilder();

        try {
            // Create the process builder for cmd.exe
            ProcessBuilder processBuilder = new ProcessBuilder();

            // For Windows
            processBuilder.command("cmd.exe", "/c", commandString);

            // Start the process
            Process process = processBuilder.start();

            // Read the output from the command
            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream()));

            String line;
            while ((line = reader.readLine()) != null) {
                System.out.printf(line);
                output.append(line).append("\n");
            }

            // Wait for the command to complete
            int exitCode = process.waitFor();

            if (exitCode != 0) {
                // Read error stream if command failed
                BufferedReader errorReader = new BufferedReader(
                        new InputStreamReader(process.getErrorStream()));

                StringBuilder errorOutput = new StringBuilder();
                while ((line = errorReader.readLine()) != null) {
                    System.out.println(line);
                    errorOutput.append(line).append("\n");
                }

                output.append("Command failed with exit code ").append(exitCode).append("\n");
                output.append("Error output:\n").append(errorOutput);
            }

        } catch (IOException | InterruptedException e) {
            output.append("Exception occurred: ").append(e.getMessage());
        }

        return output.toString();

    }

}
