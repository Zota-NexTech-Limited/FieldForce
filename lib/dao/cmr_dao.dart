import 'dart:convert';
import 'package:fieldsales/helper/config.dart';
import 'package:fieldsales/models/crm_models/create_activity_model.dart';
import 'package:fieldsales/models/crm_models/new_lead_model.dart';
import 'package:fieldsales/models/crm_models/opportinuty_model.dart';
import 'package:http/http.dart' as http;


class CmrDao{


  Future newLead(
      {
        required NewLeadModel leadDetails,
      }) async {
    var url = '${Config.url}/field-force/lead/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=leadDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.authHeaders(),
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
    var url = '${Config.url}/field-force/get-leads?from=$fromDate&to=$toDate&search=$search';
    print("----------Dao 1----------");


    final response = await http.get(Uri.parse(url),
      headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print(" lead List Response Status Code : ${response.statusCode}");
    print(" lead List  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }


  Future getLeadById(
      {
        required String id,
      }) async {
    var url = '${Config.url}/field-force/view-leads?id=$id';
    print("----------Dao 1----------");


    final response = await http.get(Uri.parse(url),
      headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("get Lead By Id  Response Status Code : ${response.statusCode}");
    print("get Lead By Id  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

  Future editLead(
      {
        required NewLeadModel leadDetails,
      }) async {
    var url = '${Config.url}/field-force/edit-leads';
    print("----------Dao 1----------");

    Map<String,dynamic> body=leadDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.authHeaders(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("edit Lead  Response Status Code : ${response.statusCode}");
    print("edit Lead  Response body : ${response.body}");

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


  Future createActivity(
      {
        required CreateActivityModel activityDetails,
      }) async {
    var url = '${Config.url}/field-force/activity/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=activityDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.authHeaders(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("create Activity  Response Status Code : ${response.statusCode}");
    print("create Activity Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }


  Future opportunityList() async {
    var url='${Config.url}/field-force/opportunity/get-list';

    final response = await http.get(Uri.parse(url),
        headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("get Opportunity List  Response Status Code : ${response.statusCode}");
    print("get Opportunity List Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;

  }


  Future addOpportunity(
      {
        required OpportunityDetailsModel opportunityDetails,
      }) async {
    var url = '${Config.url}/field-force/opportunity/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=opportunityDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.authHeaders(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("add opportunity  Response Status Code : ${response.statusCode}");
    print("add opportunity  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

  Future getOpportunityById(
      {
        required String id,
      }) async {
    var url = '${Config.url}/field-force/opportunity/get-opportunity-by-id?id=$id';
    print("----------Dao 1----------");


    final response = await http.get(Uri.parse(url),
        headers: Config.authHeaders(),
    );

    print("----------Dao 2-----------");

    print("get Opportunity By Id  Response Status Code : ${response.statusCode}");
    print("get Opportunity By Id  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

  Future editOpportunity(
      {
        required OpportunityDetailsModel opportunityDetails,
      }) async {
    var url = '${Config.url}/field-force/opportunity/edit-opportunity';
    print("----------Dao 1----------");

    Map<String,dynamic> body=opportunityDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.authHeaders(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("edit Opportunity  Response Status Code : ${response.statusCode}");
    print("edit Opportunity  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }


}