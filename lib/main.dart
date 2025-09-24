import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';

class MyState extends ChangeNotifier{
  List<Todo> _todos = [          //list with the items included in the app's todolist
    /*Todo(title: 'Write a book'),
    Todo(title: 'Do homework'),
    Todo(title: 'Tidy room', done: true),
    Todo(title: 'Watch TV'),
    Todo(title: 'Nap'),
    Todo(title: 'Shop groceries'),
    Todo(title: 'Have fun'),
    Todo(title: 'Meditate'),*/
  ];

  MyState(){
    fetchTodos();
  }

  String _filter = 'all';

  List<Todo> get todos{
    if (_filter == 'done'){                               //returns a new list with only the todos where todo.done==true
      return _todos.where((todo) => todo.done).toList();
    }
    else if (_filter == 'undone'){
      return _todos.where((todo) => !todo.done).toList(); //returns a new list with only the todos where todo.done==false
    }
    return _todos; //for "all"
  }

  /*void addTodo(String title) {
    _todos.add(Todo(title: title)); //PROBLEM!! Todo har nu id required... kan använda listNewTodo() istället?
    notifyListeners();
}*/
   Future<void> removeTodo(Todo todo) async{
    await deleteTodo(todo.id);
    _todos.remove(todo);
    notifyListeners();
    //_todos.remove(todo);
    //notifyListeners();                      
    //await deleteTodo(todo.id); 
   }
  
    Future<void> checkTodo(Todo todo, bool? value) async{  
    todo.done = value ?? false;               //if value is null, set todo.done to false
    notifyListeners();
    await putTodo(todo.id, todo.done);
  }
  void setFilter(String filter){
    _filter = filter;
    notifyListeners();
  }
  Future<void> fetchTodos() async{
    var todos = await getTodos();
    _todos = todos;
    notifyListeners();
  }
  Future<void> listNewTodo(String title) async{  
    await postTodo(title);               //uses the API to add a todo, and fetch the new updated list of todos
    fetchTodos();                
    //notifyListeners();
  }
}

void main() {

  runApp(
    ChangeNotifierProvider(create: (context) => MyState(),
    child: MyApp(),
    ),
    );
}

class Todo {         //"model-class" with title and done (true/false), can take more info than only a list taking String (as used before)
  String title;
  bool done;
  String id;

  Todo({required this.title, this.done = false, required this.id}); //id added for "putTodo"

    factory Todo.fromJson(Map<String, dynamic>json){
    return Todo(title: json['title'], done: json['done'] ?? false, id: json['id']); //if null, set to false
  }
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

class TodoItem extends StatelessWidget {  //creates (or removes) a new item in the list (as a widget) and determines how a Todo-object should look in the UI
  final Todo todo;                        //takes in a Todo-object

  const TodoItem({super.key, required this.todo});
  
  @override
  Widget build(BuildContext context) {
    var state = context.read<MyState>();

    return Container(
      height: 60,
      margin: EdgeInsetsGeometry.all(5),
      child: Row(
        children: [
          Checkbox(
            value: todo.done, 
            onChanged: (newValue){
              state.checkTodo(todo, newValue);},activeColor: Colors.pink), //"newValue" is set to true or false when the box is clicked 
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
          PopupMenuButton<String>(onSelected: (filter){var state = context.read<MyState>(); state.setFilter(filter);}, //filtering by sending chosen filter (from the menu) to MyState.setFilter()
          itemBuilder: (context) =>[     //menu in the upper right corner for filtering                                //which updates the current filter state
            PopupMenuItem(value: 'all', child: Text('All')),
            PopupMenuItem(value: 'done', child: Text('Done'), ),
            PopupMenuItem(value: 'undone', child: Text('Undone'),),
          ],
          )
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
                    onPressed: () async {
                      if (controller.text.isNotEmpty){
                       // await postTodo(controller.text);
                        context.read<MyState>().listNewTodo(controller.text); //want to call the API via MyState (to not handle states/updating inside the widget) 
                        //state.fetchNotes();                                 //-> don't use fetchTodos() here
                        //getTodos();
                      }
                      Navigator.pop(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: '')), //Go to homepage after adding item
                      );
                    } 
                  ),
                ),
            ],
          ),
          ),
        );
  }
}