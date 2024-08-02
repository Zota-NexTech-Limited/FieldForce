import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalConstant{
  static String accessToken = "AccessToken";
  static String hostUrl = "HostUrl";
  static String userName = "UserName";
  static String userRole = "UserRole";
  static String userEmail = "UserEmail";
  static String userPhoneNumber = "UserPhoneNumber";
  static String userDepartment = "userDepartment";
}

storeToLocalStorage(dynamic key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}



