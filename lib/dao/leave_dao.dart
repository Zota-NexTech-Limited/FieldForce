import 'dart:convert';

import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/models/leave/leave_model.dart';
import 'package:http/http.dart' as http;


class LeaveDao{


  Future leaveList() async {
    var url = '${Config.url}/field-force/get-leave';
    print("----------Dao 1----------");

    final response = await http.get(Uri.parse(url),
      headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("Leave List  Response Status Code : ${response.statusCode}");
    print("Leave List Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

  Future addLeave(
      {required Leave leaveDetails}
      ) async {
    var url = '${Config.url}/field-force/leave/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=leaveDetails.toJson();
    final response = await http.post(Uri.parse(url),
      headers: Config.authHeaders(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("add Leave  Response Status Code : ${response.statusCode}");
    print("add Leave Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }
}