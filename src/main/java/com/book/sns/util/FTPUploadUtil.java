package com.book.sns.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
 
/**
 * A program that demonstrates how to upload files from local computer
 * to a remote FTP server using Apache Commons Net API.
 * @author www.codejava.net
 */
public class FTPUploadUtil {
 
	public static String SERVER = "10.10.8.226";
	public static String LOCAL = "localhost:8888/sns/resources/images/FileRepo";
	public static String DESTINATION = "kita/workspace/project/sts/Booksns/src/main/webapp/resources/images/FileRepo";
	public static String UPLOADPATH = SERVER + "/" + DESTINATION;
			
    public static void upload(File selectedFile, String fileName) {
	//public static void upload(InputStream selectedFileStream, String fileName) {
        int port = 21;
        String user = "MinjeJung";
        String pass = "test1";
 
        FTPClient ftpClient = new FTPClient();
       
        try {
            ftpClient.connect(SERVER, port);
            ftpClient.login(user, pass);
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
            ftpClient.setDefaultPort(port);
            
            boolean result = ftpClient.changeWorkingDirectory(DESTINATION);
            if(result) {
               System.out.println("working dir change success");
            }
            String firstRemoteFile =fileName;
            System.out.println(firstRemoteFile);
            InputStream inputStream = new FileInputStream(selectedFile);
 
            System.out.println("Start uploading first file");
            //boolean done = ftpClient.storeFile(firstRemoteFile, selectedFileStream);
            //selectedFileStream.close();
            
            boolean done = ftpClient.storeFile(firstRemoteFile, inputStream);
            inputStream.close();
            
            if (done) {
                System.out.println("The first file is uploaded successfully.");
            }
 
        } catch (IOException ex) {
            System.out.println("Error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try {
                if (ftpClient.isConnected()) {
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
 
}