import 'dart:io';

class Config{

  static String url = "";
  static String accessToken ="";
  static String fountFamilyPrimary="Poppins";


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