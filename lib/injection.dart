import 'package:featuretodolist/presentation/bloc/todo_list_bloc/todolist_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/todo_remote_data_source.dart';
import 'data/usecase/todo_by_param_usecase.dart';
import 'data/usecase/todo_usecase.dart';

final locator = GetIt.instance;

void init() {

  if (!locator.isRegistered<TodolistBloc>()) {
    locator.registerFactory(() => TodolistBloc(
        locator(), locator()
      )
    );
  }

  if (!locator.isRegistered<GetdataToDoUsecase>()) {
    locator.registerFactory(() => GetdataToDoUsecase(taskTodo: locator()));
  }

  if (!locator.isRegistered<GetdataToDoByPamUsecase>()) {
    locator.registerFactory(() => GetdataToDoByPamUsecase(taskTodoByParam: locator()));
  }

  if (!locator.isRegistered<TaskToDoRemoteDataSource>()) {
    locator.registerLazySingleton<TaskToDoRemoteDataSource>(() => TaskToDoRemoteDataSourceImpl());
  }


  // if (!locator.isRegistered<TaskToDoRemoteDataSource>()) {
  //   locator.registerLazySingleton<TaskToDoRemoteDataSource>(() => TaskToDoRemoteDataSource());
  // }
}