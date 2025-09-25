import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';

class Todo {         //"model-class" with title, done (true/false) and id
  String title;
  bool done;
  String id;

  Todo({required this.title, this.done = false, required this.id}); //id added for "putTodo"

  factory Todo.fromJson(Map<String, dynamic> json) {      //the JSON format is "converted" to a Todo instance
  return Todo(
    title: json['title'].toString(),     
    done: json['done'] ?? false,
    id: json['id'].toString(),
  );
}

}