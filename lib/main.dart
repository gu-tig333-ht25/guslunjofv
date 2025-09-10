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
          PopupMenuButton(itemBuilder: (context) =>[
            PopupMenuItem(child: Text('all'), value: 1),
            PopupMenuItem(child: Text('done'), value: 2),
            PopupMenuItem(child: Text('undone'), value: 3),
          ])
        ],
        
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 50, color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.square_outlined),
                Text('Write a book', style: TextStyle(fontSize: 20),),
                Spacer(),
                Icon(Icons.close)
              ],
            ),),
            Container(height: 50, color: Colors.blue,
            child: Text('Do homework'),),
            Container(height: 50, color: Colors.green,
            child: Text('Tidy room'),),
            Container(height: 50, color: Colors.yellow,
            child: Text('Watch TV'),),
            Container(height: 50, color: Colors.green,
            child: Text('Nap'),),
            Container(height: 50, color: Colors.red,
            child: Text('Shop groceries'),),
            Container(height: 50, color: Colors.green,
            child: Text('Have fun'),),
            Container(height: 50, color: Colors.purple,
            child: Text('Meditate'),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
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

class AddPage extends StatelessWidget{
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
