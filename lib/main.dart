import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier{
  final List<String> _todos = [
    "Write a book",
    "Do homework",
    "Tidy room",
    "Watch TV",
    "Nap",
    "Shop groceries",
    "Have fun",
    "Meditate",
    "Cook food"
  ];

  List<String> get todos => _todos;

  void addTodo(String title) {
    _todos.add(title);
    notifyListeners();
}
  void removeTodo(String title) {
    _todos.remove(title);
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
  final String title;

  const TodoItem({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    var state = context.read<MyState>();

    return Container(
      height: 60,
      margin: EdgeInsetsGeometry.all(5),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.square_outlined), onPressed: (){},),  //gör om detta till en iconbutton också (för att kunna kryssa i rutan)?? 
          Text(title, style: TextStyle(fontSize: 20)),
          Spacer(),
          IconButton(icon: Icon(Icons.close), onPressed: () => state.removeTodo(title),), //remove item if user clicks on the iconbutton
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
      body: ListView(                            //using the TodoItem class to add a new item in the list, title is required
        children: state.todos.map((title) => TodoItem(title: title)).toList(),
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
