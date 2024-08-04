import 'package:bloc_app/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(loadEmployeeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body:
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EmployeeLoadedState) {
            return ListView.builder(
                itemCount: state.employees.length,
                itemBuilder: (context, index) => ListTile(
                      title:
                          Text(state.employees[index].name?.first ?? 'no name'),
                      subtitle: Text(state.employees[index].email ?? 'no name'),
                    ));
          }
          if (state is EmployeeErrorState) {
            return Center(child: Text('Employee: ${state.error}'));
          }
          return SizedBox.shrink();
        }));
  }
}
