part of 'add_expense_bloc.dart';

@immutable
sealed class AddExpenseEvent extends Equatable{
  const AddExpenseEvent();
  @override
  List<Object> get props => [];
}


class TriggerAddExpenseEvent extends AddExpenseEvent{
  final  AddExpenseModel expenseDetails;
  const TriggerAddExpenseEvent({required this.expenseDetails,});
  @override
  List<Object> get props => [expenseDetails];
}