import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fieldforce/dao/expense_dao.dart';
import 'package:fieldforce/models/expense/expense_list_model.dart';
import 'package:meta/meta.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  late ExpenseDao expenseDao;
  ExpenseListBloc() : super(ExpenseListInitial()) {
    expenseDao=ExpenseDao();
    on<FetchExpenseListEvent>((event, emit) async{
      await mapFetchExpenseListEvent(event, emit);
    });
  }

  Future<void> mapFetchExpenseListEvent(
      FetchExpenseListEvent event, Emitter<ExpenseListState> emit) async {
    try{
      print("------------------1--------------------");
      emit(const ExpenseListLoadingState());

      print("------------------2--------------------");
      var response = await expenseDao.expenseList();

      print("------------------3--------------------");
      Map<String,dynamic> jsonDecoded = jsonDecode(response.body);

      print("The status Code : ${response.statusCode} ,The status:${jsonDecoded['status']}");

      print("------------------4--------------------");

      if(response.statusCode == 200 && jsonDecoded['status'] == true){
        print("------------------5--------------------");
        List<ExpenseListModel> expenseList=[];
        for(var item in jsonDecoded['data'])
        {
          expenseList.add(ExpenseListModel.fromJson(item));
        }


        print("------------------6--------------------");

        emit(ExpenseListSuccessState(expenseList: expenseList ));

      }else if(response.statusCode == 200 && jsonDecoded['status'] == false){
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(ExpenseListFailedState(message: message));
      }
      else{
        String message = jsonDecoded["message"];
        print("The failure reason: $message");
        emit(ExpenseListFailedState(message: message));
      }

    }catch(error){
      print("The error of Expense List Failed State : $error");
      emit(ExpenseListFailedState(message: "Something went wrong"));
    }
  }
}
