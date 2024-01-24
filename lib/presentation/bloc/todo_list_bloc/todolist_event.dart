part of 'todolist_bloc.dart';


abstract class TodolistEvent {
  const TodolistEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryGetTodoEvent extends TodolistEvent {
  // final String? data;
  const OnQueryGetTodoEvent();
// @override
// List<Object?> get props => [];
}

class OnQueryGetTodoByParamEvent extends TodolistEvent {
  final int? page;
  final bool? loadmore;
  final String? status;
  const OnQueryGetTodoByParamEvent({this.page,this.loadmore,this.status});
// @override
// List<Object?> get props => [];
}

class OnLoadMoreTodoEvent extends TodolistEvent {
  // final String? data;
  const OnLoadMoreTodoEvent();
// @override
// List<Object?> get props => [];
}
