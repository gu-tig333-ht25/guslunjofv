import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier{
  final List<Todo> _todos = [          //list with the items included in the app's todolist
    Todo(title: 'Write a book'),
    Todo(title: 'Do homework'),
    Todo(title: 'Tidy room', done: true),
    Todo(title: 'Watch TV'),
    Todo(title: 'Nap'),
    Todo(title: 'Shop groceries'),
    Todo(title: 'Have fun'),
    Todo(title: 'Meditate'),
  ];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
}
  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }
    void checkTodo(Todo todo, bool? value) {  
    todo.done = value ?? false;               //if value is null, set todo.done to false
    notifyListeners();
  }
}

void main() {
  //MyState state = MyState();

  runApp(
    ChangeNotifierProvider(create: (context) => MyState(),
    child: MyApp(),
    ),
    );
}

class Todo {         //class with title and done (true/false), can take more info than only a list taking String (as used before)
  String title;
  bool done;

  Todo({required this.title, this.done = false});
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO assignment',
     home: MyHomePage(title: 'assignment',)
    );
  }
}

class TodoItem extends StatelessWidget {  //creates (or removes) a new item in the list, a title/name is required to add
  final Todo todo;

  const TodoItem({super.key, required this.todo});
  
  @override
  Widget build(BuildContext context) {
    var state = context.read<MyState>();

    return Container(
      height: 60,
      margin: EdgeInsetsGeometry.all(5),
      child: Row(
        children: [
          Checkbox(value: todo.done, onChanged: (newValue){state.checkTodo(todo, newValue);}, activeColor: Colors.pink), //"newValue" is set to true or false when the box is clicked 
          Text(todo.title, style: TextStyle(fontSize: 20, decoration: todo.done ? TextDecoration.lineThrough : TextDecoration.none)), //format= condition ? valueIfTrue : valueIfFalse
          Spacer(),
          IconButton(icon: Icon(Icons.close), onPressed: () => state.removeTodo(todo),), //remove item if user clicks on the iconbutton
        ],
      ),
    );
  }
}  

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('TIG333 TODO'),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context) =>[     //menu in the upper right corner for filtering
            PopupMenuItem(value: 1, child: Text('all')),
            PopupMenuItem(value: 2, child: Text('done'), ),
            PopupMenuItem(value: 3, child: Text('undone'),),
          ])
        ],
        
      ),
      body: ListView(                            //builds a new TodoItem widget for every Todo in the list
        children: state.todos.map((todo) => TodoItem(todo: todo)).toList(),
          ),

      floatingActionButton: FloatingActionButton(              //button to navigate to the next page (AddPage())
        shape: CircleBorder(),
        backgroundColor: Colors.pink,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const AddPage(),
            ),
          );
        },
      ),
          );
  }
}

class AddPage extends StatelessWidget{    //the second page
  const AddPage({super.key});

  @override
  Widget build(BuildContext context){
    final TextEditingController controller = TextEditingController();
    var state = context.read<MyState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('TIG333 TODO'),
        centerTitle: true
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: 
                TextField(
                  controller: controller,
                  enableSuggestions: false,       //the suggestion bar is in the way of the textfield without this (but it's not the best solution...)
                  decoration: InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    ),
                    ),
                Container(
                  child: TextButton(
                    child: Text('+ Add', style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      if (controller.text.isNotEmpty){
                        state.addTodo(controller.text);
                      }
                    } 
                  ),
                ),
            ],
          ),
          ),
        );
  }
}
