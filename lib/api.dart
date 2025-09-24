import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';

Future<String> getAPI() async{
  print('Getting API');
  final response = await http.get(Uri.parse('$ENDPOINT/register'));
  final json = jsonDecode(response.body);
  return json['key'];
}

Future<List<Todo>> getTodos() async{
  http.Response response = await http.get(Uri.parse('$ENDPOINT/todos?key=ca7609f6-fd29-4a43-b592-af7b36fb80b6'));
  print("API response: ${response.body}"); 
  List todosJson = jsonDecode(response.body);
  return todosJson.map((json) => Todo.fromJson(json)).toList();
}

Future<void> postTodo(String title) async {
  final response = await http.post(Uri.parse('$ENDPOINT/todos?key=ca7609f6-fd29-4a43-b592-af7b36fb80b6'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": title,
      "done": false,
    }),
  );
}

Future<void> putTodo(String id, bool done) async {
  final response = await http.put(Uri.parse('$ENDPOINT/todos/$id?key=ca7609f6-fd29-4a43-b592-af7b36fb80b6'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"done": done}),
  );
}

Future<void> deleteTodo(String id) async {
  final response = await http.delete(Uri.parse('$ENDPOINT/todos/$id?key=ca7609f6-fd29-4a43-b592-af7b36fb80b6'),
  headers: {"Content-Type": "application/json"},
  );
}