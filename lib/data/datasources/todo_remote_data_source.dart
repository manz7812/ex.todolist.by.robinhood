
import 'package:dio/dio.dart';
import 'package:featuretodolist/data/model/tasks_model.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';

import '../failure.dart';

abstract class TaskToDoRemoteDataSource {
  Future<Either<Failure, TaskTodoModel>> getTaskToDo();
  Future<Either<Failure, TaskTodoModel>> getTaskToDoByParam({pageNumber,status});

}

class TaskToDoRemoteDataSourceImpl extends TaskToDoRemoteDataSource {

  @override
  Future<Either<Failure, TaskTodoModel>> getTaskToDo() async {
    var log = Logger();
    try {
      final dio = Dio();
      final response = await dio.get('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list');
      // print(response.data['tasks']);
      // log.d(response.data['tasks']);
      return Right(TaskTodoModel.fromJson(response.data));
    } catch (e) {
      print('Error: $e');

      rethrow;
    }
  }

  @override
  Future<Either<Failure, TaskTodoModel>> getTaskToDoByParam({pageNumber,status}) async {
    var log = Logger();
    // print('pageNumber ---> ${pageNumber}');
    // print('status ---> ${status}');
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=${pageNumber}&limit=10&sortBy=createdAt&isAsc=true&status=${status}'
      );
      // print(response.data['tasks']);
      log.d(response.data);
      return Right(TaskTodoModel.fromJson(response.data));
    } catch (e) {
      print('Error: $e');

      rethrow;
    }
  }
}

