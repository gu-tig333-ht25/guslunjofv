import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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

class TodoItem extends StatelessWidget {  //creates a new item in the list, a title/name is required to add
  final String title;

  const TodoItem({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsetsGeometry.all(5),
      child: Row(
        children: [
          Icon(Icons.square_outlined),
          Text(title, style: TextStyle(fontSize: 20)),
          Spacer(),
          Icon(Icons.close),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('TIG333 TODO'),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context) =>[     //menu in the upper right corner for filtering
            PopupMenuItem(child: Text('all'), value: 1),
            PopupMenuItem(child: Text('done'), value: 2),
            PopupMenuItem(child: Text('undone'), value: 3),
          ])
        ],
        
      ),
      body: ListView(                            //using the TodoItem class to add a new item in the list, title is required
        children: [
          TodoItem(title: 'Write a book'),
          TodoItem(title: 'Do homework'),
          TodoItem(title: 'Tidy room'),
          TodoItem(title: 'Watch TV'),
          TodoItem(title: 'Nap'),
          TodoItem(title: 'Shop groceries'),
          TodoItem(title: 'Have fun'),
          TodoItem(title: 'Meditate'),
          ],
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
                  decoration: InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    ),
                    ),
                Container(
                  child: TextButton(
                    child: Text('+ Add', style: TextStyle(color: Colors.black),), onPressed: (){} 
                  ),
                ),
            ],
          ),
          ),
        );
  }
}
