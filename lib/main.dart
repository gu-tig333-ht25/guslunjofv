import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './ui.dart';
import './model.dart';

class MyState extends ChangeNotifier {
  List<Todo> _todos = [
    //list with the items included in the app's todolist
    /*Todo(title: 'Write a book'),
      Todo(title: 'Tidy room', done: true),*/
  ];

  MyState() {
    fetchTodos(); //uses getTodo()
  }

  String _filter = 'all';

  List<Todo> get todos {
    if (_filter == 'done') {
      //returns a new list with only the todos where todo.done==true
      return _todos.where((todo) => todo.done).toList();
    } else if (_filter == 'undone') {
      return _todos
          .where((todo) => !todo.done)
          .toList(); //returns a new list with only the todos where todo.done==false
    }
    return _todos; //for "all"
  }

  Future<void> removeTodo(Todo todo) async {
    await deleteTodo(todo.id); //delete the id corresponding to the todo
    _todos.remove(todo); //delete todo from the list
    notifyListeners();
  }

  Future<void> checkTodo(Todo todo, bool? value) async {
    var oldValue = todo.done;
    var newValue = value ?? false;

    todo.done = newValue; //if value is null, set todo.done to false
    notifyListeners();

    try {
      await putTodo(todo.id, newValue, todo.title);
      //all variables are needed to change the "state" of checkbox (to not get for ex. an empty title)
    } catch (e) {
      todo.done =
          oldValue; //if the server call with putTodo was not successful, "un-do" the check (local change)
      notifyListeners();
    }
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> fetchTodos() async {
    //uses getTodos() which returns a list of todos from the API to use here
    var todos = await getTodos();
    _todos = todos;
    notifyListeners();
  }

  Future<void> listNewTodo(String title) async {
    //addTodo() got replaced to this
    await postTodo(
      title,
    ); //uses the API to add a todo, and fetch the new updated list of todos
    await fetchTodos();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          MyState(), //creates a new object of class MyState(), the constructor then runs automatically
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO assignment',
      home: MyHomePage(title: 'assignment'),
    );
  }
}
