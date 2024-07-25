part of 'expense_list_bloc.dart';

@immutable
sealed class ExpenseListEvent extends Equatable{
  const ExpenseListEvent();
  @override
  List<Object> get props => [];
}


class FetchExpenseListEvent  extends ExpenseListEvent{
  const FetchExpenseListEvent();
  @override
  List<Object> get props => [];
}
