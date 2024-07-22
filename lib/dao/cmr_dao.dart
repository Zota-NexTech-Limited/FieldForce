import 'dart:convert';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:http/http.dart' as http;


class CmrDao{
  Future addCustomer(
      {
        required NewLeadModel leadDetails,
      }) async {
    var url = '${Config.url}/feild-force/lead/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=leadDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.headers(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("new lead  Response Status Code : ${response.statusCode}");
    print("new lead  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }
}