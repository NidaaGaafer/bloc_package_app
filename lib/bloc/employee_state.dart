part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeLoadingState extends EmployeeState {}

final class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employees;

  EmployeeLoadedState(this.employees);
}

final class EmployeeErrorState extends EmployeeState {
  final String error;

  EmployeeErrorState(this.error);
}
