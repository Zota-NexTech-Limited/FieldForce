import 'dart:convert';
import 'package:fieldforce/helper/config.dart';
import 'package:fieldforce/models/crm_models/create_activity_model.dart';
import 'package:fieldforce/models/crm_models/new_lead_model.dart';
import 'package:fieldforce/models/expense/add_ecpense_model.dart';
import 'package:http/http.dart' as http;


class ExpenseDao{


  Future addExpense(
      {
        required AddExpenseModel expenseDetails,
      }) async {
    var url = '${Config.url}/feild-force/expense/add';
    print("----------Dao 1----------");

    Map<String,dynamic> body=expenseDetails.toJson();

    final response = await http.post(Uri.parse(url),
        headers: Config.headers(),
        body:jsonEncode(body)
    );

    print("----------Dao 2-----------");

    print("add Expense  Response Status Code : ${response.statusCode}");
    print("add Expense  Response body : ${response.body}");

    print("----------Dao 3-----------");

    return response;
  }

}