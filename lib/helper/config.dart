import 'dart:io';

class Config{

  //static String url = "https://dev.zotanextech.com/api";
  static String url = "http://$hostUrl/api";
  static String accessToken ="";
  static String fountFamilyPrimary="Inter";
  static String hostUrl = "";
  static String userName = "";
  static String userRole = "";
  static String userEmail = "";
  static String userPhoneNumber = "";
  static String userDepartment = "";


  static Map<String, String> headers(){
    return {
      HttpHeaders.contentTypeHeader : "application/json",
    };
  }
  static Map<String, String> authHeaders() {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      "Authorization" :Config.accessToken
    };
  }
}