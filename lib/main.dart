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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
        title: Center(child: Text('TIG333 TODO')),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 50, color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.square_outlined),
                Text('Write a book'),
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
          );
  }
}
