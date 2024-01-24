import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:featuretodolist/data/convert.dart';
import 'package:featuretodolist/data/datasources/todo_remote_data_source.dart';
import 'package:featuretodolist/data/usecase/todo_by_param_usecase.dart';
import 'package:featuretodolist/data/usecase/todo_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'todolist_event.dart';
part 'todolist_state.dart';

class TodolistBloc extends Bloc<TodolistEvent, TodolistState> {
  GetdataToDoUsecase taskTodo;
  GetdataToDoByPamUsecase taskTodoByParam;
  final ScrollController _controller = ScrollController();
  // TaskToDoRemoteDataSource taskTodo;
  TodolistBloc(
      this.taskTodo,
      this.taskTodoByParam
      ) : super(TodolistInitial()) {
    on<TodolistEvent>((event, emit) async {
      // TODO: implement event handler
    });

    on<OnQueryGetTodoEvent>((event, emit) async {
      // TODO: implement event handler
      var log = Logger();
      final locator = GetIt.instance;

      final res = await taskTodo.execute();
      List task_TODO = [];

      res.fold((l) => null, (r) {
        // final List test = r.tasks.where((element) =>
        //   element.status.name.toLowerCase() == 'todo').toList();

        for (var element in r.tasks) {
          if(element.status.name.toLowerCase() == 'todo'){
            // print('status ----> ${element.status.name}');
            task_TODO.add(
                {
                  "title": element.title ,
                  "description": element.description,
                  "createdAt": element.createdAt,
                }
            );
          }

        }
        // print('task_TODO ----> ${task_TODO.length}');
        // print('task_TODO ----> ${task_TODO}');
        // emit(TodolistHasData(TodoList: task_TODO));
      });


    });

    on<OnQueryGetTodoByParamEvent>((event, emit) async {
      // TODO: implement event handler
      emit(TodolistLoading());
      ScrollController _scrollController = ScrollController();

      var log = Logger();

      final res = await taskTodoByParam.execute(pageNumber: event.page ?? 0, status: event.status ?? '');
      List task_TODO = [];
      int totalpage = 0;
      bool _loadMore = false;

      res.fold((l) => null, (r) {
        totalpage = r.totalPages;
        if(r.tasks.isNotEmpty){
          for (var element in r.tasks) {
            var day = element.createdAt.day;
            var month = element.createdAt.month;
            var year = element.createdAt.year;
            // print('status ----> ${element.status.name}');
            DateTime convertedDate = DateFormat("yyyy-MM-dd hh:mm").parse('${element.createdAt}');
            // print('convertedDate ---> ${convertedDate}');
            var apiDate = DateFormat('dd/MM/yyyy');
            // var outputFormat = DateFormat('dd MMM yyyy HH:mm:ss');
            // var outputFormat = DateFormat('dd MMM yyyy');
            // var outputDates = outputFormat.format(convertedDate);
            // print('outputDate ---> ${outputDates.toUpperCase()}');
            // final outputDate = dateConverter('23/01/2024');
            final outputDate = dateConverter(apiDate.format(convertedDate));

            // final test = outputDate.contains(outputDate);
            // print('testtest ---> ${test}');
            // print('outputDate2 ---> ${outputDate}');
            task_TODO.add({
                "title": '${element.title}' ,
                "description": '${element.description}',
                "createdAt": '${outputDate}',
              });
            // print('result --->$result');
            // task_TODO.retainWhere((x) => ids.remove(x['createdAt']));
          }
          // print('task_TODO_By_Param ----> ${r.tasks.length}');
        }

      });

      // print('event page ---> ${event.page}');
      // print('loadmore ---> ${event.loadmore}');
      // print('totalpage ---> ${totalpage}');

      if(event.loadmore == true && event.page! < totalpage){
        res.fold((l) => null, (r) {
          if(r.tasks.isNotEmpty){
            _loadMore = true;
            for (var element in r.tasks) {
              // print('status ----> ${element.status.name}');
              DateTime convertedDate = DateFormat("yyyy-MM-dd hh:mm").parse('${element.createdAt}');
              var apiDate = DateFormat('dd/MM/yyyy');
              final outputDate = dateConverter(apiDate.format(convertedDate));
              task_TODO.add(
                  {
                    "title": element.title ,
                    "description": element.description,
                    "createdAt": outputDate,
                  }
              );
            }
          }

        });
      }else{
        // print('falseeeeeeeee');
        _loadMore = false;
      }


      // print('totalpage ----> ${totalpage}');
      // print('task_TODO_By_Param ----> ${task_TODO.length}');
      if(task_TODO.isNotEmpty){

        List result = task_TODO.fold({}, (previousValue, element) {
          Map val = previousValue;
          String date = element['createdAt'];
          if (!val.containsKey(date)) {
            val[date] = [];
          }
          element.remove('createdAt');
          val[date]?.add(element);
          return val;
        }).entries.map((e) => {'date': e.key,'value': e.value}).toList();


        log.d(result);

        emit(TodolistHasData(todoList: result, loadMore: _loadMore));
      }


    });

    on<OnLoadMoreTodoEvent>((event, emit) async {
      print('object111');

      final res = await taskTodoByParam.execute(pageNumber: 1, status: 'TODO');
      List task_TODO = [];
      int totalpage = 0;
      bool _loadMore = false;

      res.fold((l) => null, (r) {
        totalpage = r.totalPages;
        if(r.tasks.isNotEmpty){
          for (var element in r.tasks) {
            // print('status ----> ${element.status.name}');
            task_TODO.add(
                {
                  "title": element.title ,
                  "description": element.description,
                  "createdAt": element.createdAt,
                }
            );
          }
          // print('task_TODO_By_Param ----> ${r.tasks.length}');
        }

      });

      emit(TodolistLoadMore(todoList: task_TODO));
      //     // page++;
      //     // final posts = await repo.fetchPosts(page);
      //     // emit(PostLoadedState(posts: [...state.posts, ...posts]));
      //   } else {
      //     print("not called");
      //   }
      // }

    });
  }
}
