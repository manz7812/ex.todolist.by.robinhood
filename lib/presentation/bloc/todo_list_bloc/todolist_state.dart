part of 'todolist_bloc.dart';

abstract class TodolistState {
  const TodolistState();

  @override
  List<Object?> get props => [];
}

class TodolistInitial extends TodolistState {

}

class TodolistLoading extends TodolistState {
  TodolistLoading();
}

class TodolistHasData extends TodolistState {
  final List todoList;
  final bool loadMore;
  TodolistHasData({required this.todoList,required this.loadMore});

  @override
  List<Object?> get props => [todoList,loadMore];
}

class TodolistError extends TodolistState {
  String error;
  TodolistError({required this.error});
  @override
  List<Object> get props => [error];
}

class TodolistLoadMore extends TodolistState {
  final List todoList;
  TodolistLoadMore({required this.todoList});
}