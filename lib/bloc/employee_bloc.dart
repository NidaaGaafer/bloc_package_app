import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_app/models/employee.dart';
import 'package:bloc_app/repoistory/emp_repository.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<loadEmployeeEvent>(loadEmployee);
  }

  FutureOr<void> loadEmployee(
      loadEmployeeEvent event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoadingState());
    await _employeeRepository.getEmployees().then((employees) {
      emit(EmployeeLoadedState(employees));
    }).catchError((error) {
      emit(EmployeeErrorState(error.toString()));
    });
  }
}
