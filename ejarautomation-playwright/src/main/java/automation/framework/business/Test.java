package automation.framework.business;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Test {

    public static void main(String[] args) throws IOException {


        for (int i=0; i < 10; i++) {
            setExecutionEnvironmentVariablesForScript("D:\\Ejar Connected API Testing - Rental Consultant - Rental Agent Scenaiors For Hot Fixes.jmx", i);
        }
    }

    public static void setExecutionEnvironmentVariablesForScript(String scriptPath, int i) throws IOException {
        String rentalAgentFileString = FileHandler.readFile(new File(Paths.get(scriptPath).toUri()));
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"ejarApiHost\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">ejarApiHost<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"ejarApiHost\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">ejarApiHost<\\/stringProp>\n            <stringProp name=\"Argument.value\">111.111.111.222" + i+"</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"ejarApiPort\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">ejarApiPort<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"ejarApiPort\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">ejarApiPort<\\/stringProp>\n            <stringProp name=\"Argument.value\">222.22.222.333</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"tenantName\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">tenantName<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>",   "<elementProp name=\"tenantName\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">tenantName<\\/stringProp>\n            <stringProp name=\"Argument.value\">555555555555</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"databaseIP\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">databaseIP<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"databaseIP\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">databaseIP<\\/stringProp>\n            <stringProp name=\"Argument.value\">66666666666</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"database  \" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">database<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"database\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">database<\\/stringProp>\n            <stringProp name=\"Argument.value\">7777777777</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"databaseUser\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">databaseUser<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"databaseUser\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">databaseUser<\\/stringProp>\n            <stringProp name=\"Argument.value\">8888888888</stringProp>");
        rentalAgentFileString = rentalAgentFileString.replaceAll("<elementProp name=\"databasePassword\" elementType=\"Argument\">\\n*\\s*<stringProp name=\"Argument.name\">databasePassword<\\/stringProp>\\n*\\s*<stringProp name=\"Argument.value\">(.*?)</stringProp>", "<elementProp name=\"databasePassword\" elementType=\"Argument\">\n           <stringProp name=\"Argument.name\">databasePassword<\\/stringProp>\n            <stringProp name=\"Argument.value\">99999999999</stringProp>");
        try {
            Files.writeString(Paths.get(scriptPath), rentalAgentFileString);
        } catch (IOException e) {
            System.out.println("writing on the script files has been failed:" + scriptPath );
            throw new RuntimeException(e);
        }
    }
}
