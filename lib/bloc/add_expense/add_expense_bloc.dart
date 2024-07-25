import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/expense_dao.dart';
import 'package:fieldforce/models/expense/add_ecpense_model.dart';
import 'package:meta/meta.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  late ExpenseDao expenseDao;
  AddExpenseBloc() : super(AddExpenseInitial()) {
    expenseDao=ExpenseDao();
    on<TriggerAddExpenseEvent>((event, emit) async{
      await mapTriggerAddExpenseEvent(event, emit);
    });
  }
  Future<void> mapTriggerAddExpenseEvent(
      TriggerAddExpenseEvent event, Emitter<AddExpenseState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const AddExpenseLoadingState());

      print("------------------2--------------------");
      var response = await expenseDao.addExpense(expenseDetails: event.expenseDetails);

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){

        String message = jsonDecoded["message"];
        emit(AddExpenseSuccessState(message:message));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddExpenseFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(AddExpenseFailedState(message: message));
      }

    }catch(error){
      print("The error of Add Expense Failed State  : $error");
      emit(const AddExpenseFailedState(message: "Something went wrong"));
    }
  }

}
