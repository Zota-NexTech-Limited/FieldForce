part of 'add_expense_bloc.dart';

@immutable
sealed class AddExpenseState extends Equatable{
  const AddExpenseState();
  @override
  List<Object> get props => [];
}

final class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoadingState extends AddExpenseState{
  const AddExpenseLoadingState();
  @override
  List<Object> get props => [];
}

class AddExpenseSuccessState extends AddExpenseState{
  final String message;
  const AddExpenseSuccessState({required this.message,});
  @override
  List<Object> get props => [message];
}

class AddExpenseFailedState extends AddExpenseState{
  final String message;
  const AddExpenseFailedState({required this.message});
  @override
  List<Object> get props => [message];
}