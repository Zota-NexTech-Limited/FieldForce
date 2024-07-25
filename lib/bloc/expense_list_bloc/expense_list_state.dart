part of 'expense_list_bloc.dart';

@immutable
sealed class ExpenseListState extends Equatable{
  const ExpenseListState();
  @override
  List<Object> get props => [];
}

final class ExpenseListInitial extends ExpenseListState {}


class ExpenseListLoadingState extends ExpenseListState{
  const ExpenseListLoadingState();
  @override
  List<Object> get props => [];
}

class ExpenseListSuccessState extends ExpenseListState{
  final List<ExpenseListModel>expenseList;
  const ExpenseListSuccessState({required this.expenseList});
  @override
  List<Object> get props => [expenseList];
}

class ExpenseListFailedState extends ExpenseListState{
  final String message;
  const ExpenseListFailedState({required this.message});
  @override
  List<Object> get props => [message];
}