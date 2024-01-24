import 'package:featuretodolist/presentation/bloc/todo_list_bloc/todolist_bloc.dart';
import 'package:featuretodolist/presentation/doing/doing_page.dart';
import 'package:featuretodolist/presentation/done/done_page.dart';
import 'package:featuretodolist/presentation/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<TodolistBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _incrementCounter() {
    setState(() {
      print('object');
      // _counter++;
    });
  }

  static const List<Tab> _tabs = [
     Tab(child: Text('To - do')),
     Tab(text: 'Doing'),
     Tab(text: 'Done'),
    // const Tab(icon: Icon(Icons.looks_3), text: 'Tab Three'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 80),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi! User',),
              Text('This is just a sample UI.'),
              Text('Open to create your style :D'),
            ],
          ),
        ),
        bottom: TabBar(
          // physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          tabs: _tabs,
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // title: Text(widget.title),

      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: TabBarView(
          controller: _tabController,
          children: [
            TodoPage(),
            DoingPage(),
            DonePage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
