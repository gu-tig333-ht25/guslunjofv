import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';
import './model.dart';

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
                        context.read<MyState>().listNewTodo(controller.text); //want to call the API via MyState (to not handle states/updating inside the widget) 
                                                                              //-> don't use fetchTodos() here
                      }
                      Navigator.pop(context); //Go to homepage after adding item
                    } 
                  ),
                ),
            ],
          ),
          ),
        );
  }
}

