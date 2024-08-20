import 'dart:convert';
import 'package:fieldforce/helper/config.dart';
import 'package:http/http.dart' as http;


class AuthDao{
  Future login(
      {
        required String userEmail,
        required String password,
      }) async {
    var url = '${Config.url}/field-force/user/login';
    print('login  url in dao :----------------------${Config.url}');
    print("----------Dao 1----------");
    Map<String, dynamic> body ={
      "user_email"  : userEmail,
      "password"  : password
    };
    print("url---------------------------------${url}");
    print("body---------------------------------${body}");
    final response = await http.post(Uri.parse(url),
        headers: Config.headers(),
        body: jsonEncode(body)
    );

    print("----------Dao 2-----------");


    print("login  Response Status Code : ${response.statusCode}");
    print("login  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }


/*  Future resetPassword(
      {
        required String userEmail,
      }) async {
    var url = '${Config.url}/user/forgot/password';
    print("----------Dao 1----------");
    Map<String, dynamic> body ={
      "user_email"  : userEmail,
    };

    final response = await http.post(Uri.parse(url),
        headers: Config.headers(),
        body: jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("reset Password  Response Status Code : ${response.statusCode}");
    print("reset Password  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }*/
}