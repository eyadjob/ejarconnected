package eyad.com.yelo.apisecuritychecker.business;//package automation.framework.business;
//
//
//import com.google.api.client.http.FileContent;
//import com.google.api.services.drive.Drive;
//import com.google.api.services.drive.model.File;
//
//public class UploadToGoogleDrive {
//
//
//    public static void main(String[] args) {
//        Drive driveService = new Drive();
//        File fileMetadata = new File();
//        fileMetadata.setName("photo.jpg");
//        java.io.File filePath = new java.io.File("files/photo.jpg");
//        FileContent mediaContent = new FileContent("image/jpeg", filePath);
//        File file = driveService.files().create(fileMetadata, mediaContent)
//                .setFields("id")
//                .execute();
//        System.out.println("File ID: " + file.getId());
//    }
//
//}
