import 'package:http/http.dart' as http;
import 'dart:convert';
import './model.dart';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String myKey = 'ca7609f6-fd29-4a43-b592-af7b36fb80b6';  //"hardcoded" so the same list of todos appear every time the app starts

Future<String> getAPI() async{
  print('Getting API');
  final response = await http.get(Uri.parse('$ENDPOINT/register'));
  final json = jsonDecode(response.body);
  return json['key'];
}

Future<List<Todo>> getTodos() async{
  http.Response response = await http.get(Uri.parse('$ENDPOINT/todos?key=$myKey'));
  print("API response: ${response.body}"); 
  List todosJson = jsonDecode(response.body);                      //the id for each todo is given from the API
  return todosJson.map((json) => Todo.fromJson(json)).toList();
}

Future<void> postTodo(String title) async {
  final response = await http.post(Uri.parse('$ENDPOINT/todos?key=$myKey'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"title": title, "done": false}),             //only title and done is submitted, not id
  );

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception("Failed to create todo: ${response.statusCode}");
  }
}


Future<void> putTodo(String id, bool done, String title) async {
  final response = await http.put(Uri.parse('$ENDPOINT/todos/$id?key=$myKey'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"done": done, "title": title}),
  );
}

Future<void> deleteTodo(String id) async {
  final response = await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=$myKey'),
  headers: {"Content-Type": "application/json"},
  );
}