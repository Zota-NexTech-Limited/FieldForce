import 'dart:convert';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/models/crm_models/create_activity_model.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:http/http.dart' as http;


class MyActivityDao{


  Future activityList() async {
    var url = '${Config.url}/field-force/get-activitys';
    print("----------Dao 1----------");

    final response = await http.get(Uri.parse(url),
        headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("activity List  Response Status Code : ${response.statusCode}");
    print("activity List Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

}