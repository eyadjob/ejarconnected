//package eyad.com.yelo.apisecuritychecker.cron;
//
//import eyad.com.yelo.apisecuritychecker.business.PropManager;
//import eyad.com.yelo.apisecuritychecker.service.CheckerService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Component;
//
//@Component
//public class MyScheduledTask {
//    @Autowired
//    CheckerService checkerService;
//
//    @Scheduled(cron = "0 * * * * *") // run every 5 minutes
//    public void execute() {
//        System.out.println("entered the scheduler ");
//        checkerService.validateAPisSecurityForEjar();
//    }
//}
