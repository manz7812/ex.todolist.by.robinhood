import 'package:featuretodolist/presentation/bloc/todo_list_bloc/todolist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class DoingPage extends StatefulWidget {
  const DoingPage({Key? key}) : super(key: key);

  @override
  State<DoingPage> createState() => _DoingPageState();
}

class _DoingPageState extends State<DoingPage> {
  int page = 0;
  bool loadMore = false;

  ScrollController controller = ScrollController();

  void _loadMore() async{
    // print('pixels----> ${controller.position.pixels }');
    // print('maxScrollExtent----> ${controller.position.maxScrollExtent}');
    if (controller.position.pixels ==
        controller.position.maxScrollExtent) {

      setState(() {
        loadMore = true;
        page+=1;
      });

      try{
        context.read<TodolistBloc>().add(OnQueryGetTodoByParamEvent(page: page,loadmore: loadMore, status: 'DOING'));
      } catch(e){

      }

      await Future.delayed(const Duration(seconds: 1));



      setState(() {
        loadMore = false;
      });

    }else{
      // print('23423');
    }

  }

  @override
  void initState() {
    context.read<TodolistBloc>().add(const OnQueryGetTodoEvent());
    context.read<TodolistBloc>().add(const OnQueryGetTodoByParamEvent(page: 0,status: 'DOING'));
    controller.addListener(() {
      // context.read<TodolistBloc>().add(const OnLoadMoreTodoEvent());
      _loadMore();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodolistBloc, TodolistState>(
      builder: (context, state) {
        if(state is TodolistLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is TodolistHasData){
          // print('more--->${state.loadMore}');
          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var value = state.todoList[index]['value'];
                      var date = state.todoList[index]['date'];
                      // for(var e in value){
                      //   print('eee->${e}');
                      // }
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                              child: Text('$date'),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: value.length,
                              itemBuilder: (BuildContext context, int index) {
                                var title = value[index]['title'];
                                var description = value[index]['description'];
                                return ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange[50],
                                    ),
                                    width: 50,
                                    height: 50,
                                    // child: Text('${index}'),
                                    // alignment: Alignment.centerLeft,
                                    child: const Icon(
                                      LineIcons.userClock,
                                      size: 30,
                                      color:Colors.orange,
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("$title"),
                                      Text("$description"),
                                    ],
                                  ),
                                  // trailing: Text("$description"),
                                );
                              },

                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
                loadMore == true
                    && state.loadMore == true
                    ? Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    :Container()
              ],
            ),
            // child: Column(
            //   children: List.generate(
            //       state.TodoList.length, (index) {
            //     var todo = state.TodoList[index];
            //     return Column(
            //       // mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('${todo['title']}'),
            //         Text('${todo['description']}'),
            //       ],
            //     );
            //     }
            //   ),
            // ),
          );

        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
