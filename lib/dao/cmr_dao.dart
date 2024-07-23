import 'dart:convert';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:http/http.dart' as http;


class CmrDao{


  Future newLead(
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



  Future leadList(
      {
        required String fromDate,
        required String toDate,
        required String search,
      }) async {
    var url = '${Config.url}/feild-force/get-leads?from=$fromDate&to=$toDate&search=$search';
    print("----------Dao 1----------");


    final response = await http.get(Uri.parse(url),
      headers: Config.headers(),
    );

    print("----------Dao 2-----------");

    print(" lead List Response Status Code : ${response.statusCode}");
    print(" lead List  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

  Future getAddressByPinCode(
      {
        required String pinCode,

      }) async {
    var url = 'https://api.postalpincode.in/pincode/$pinCode';
    print("----------Dao 1----------");

    final response = await http.get(Uri.parse(url),
      headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("get Address By Pincode Response Status Code : ${response.statusCode}");
    print("get Address By Pincode Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }
}