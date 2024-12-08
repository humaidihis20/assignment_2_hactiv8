// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'dart:async';
// import '../models/data_model.dart';

// Future<List<Todo>> ReadJsonData() async{
//   final jsondata = await rootBundle.loadString('assets/api/todos.json');
//   final list = json.decode(jsondata) as List<dynamic>;
//   return list.map((el) => Todo.fromJson(el)).toList();
// }