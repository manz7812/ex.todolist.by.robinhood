import 'package:featuretodolist/data/datasources/todo_remote_data_source.dart';
import 'package:featuretodolist/data/failure.dart';
import 'package:featuretodolist/data/model/tasks_model.dart';
import 'package:dartz/dartz.dart';

class GetdataToDoUsecase {
  final TaskToDoRemoteDataSource taskTodo;

  GetdataToDoUsecase({required this.taskTodo});

  Future<Either<Failure, TaskTodoModel>> execute() async {
    try{
      return  taskTodo.getTaskToDo();
    }catch (e) {
      rethrow;
    }
  }
}