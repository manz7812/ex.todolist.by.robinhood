import 'package:featuretodolist/data/datasources/todo_remote_data_source.dart';
import 'package:featuretodolist/data/failure.dart';
import 'package:featuretodolist/data/model/tasks_model.dart';
import 'package:dartz/dartz.dart';

class GetdataToDoByPamUsecase {
  final TaskToDoRemoteDataSource taskTodoByParam;

  GetdataToDoByPamUsecase({required this.taskTodoByParam});

  Future<Either<Failure, TaskTodoModel>> execute({required int pageNumber, required String status}) async {
    try{
      return  taskTodoByParam.getTaskToDoByParam(pageNumber: pageNumber, status: status);
    }catch (e) {
      rethrow;
    }
  }
}