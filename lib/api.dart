import 'package:http/http.dart' as http;

class ThingToDo{
  final String title;
  final bool? done;

  ThingToDo(this.title, [this.done]);
}