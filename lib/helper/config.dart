import 'dart:io';

class Config{

  //static String url = "https://dev.zotanextech.com/api";
  static String url = "http://localhost:8003/api";
  static String accessToken ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1haGVzaEBmaXJzdGZsb29yLmFnZW5jeSIsInJvbGUiOm51bGwsInN0b3JlX2lkIjpudWxsLCJpYXQiOjE3MjI1ODU0OTJ9.70rTk8oEfUJ4zmdFREFqh_k_nDyLpIs394Rm4WArA3I";
  static String fountFamilyPrimary="Poppins";
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