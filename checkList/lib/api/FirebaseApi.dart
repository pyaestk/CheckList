import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../todologic/todo.dart';

class FirebaseApi {
   static Future<String> createTodo(Todo todo) async {
     final docTodo = FirebaseFirestore.instance.collection('todo').doc();

     todo.id = docTodo.id;
     await docTodo.set(todo.toJson());

     return docTodo.id;
   }

   static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
       .collection('todo')
       .orderBy(TodoField.createdTime, descending: true)
       .snapshots()
       .transform(DateTimeUtils.transformer(Todo.fromJson));

   static Future updateTodo(Todo todo) async {
     final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
     await docTodo.update(todo.toJson());
   }

   static Future deleteTodo(Todo todo) async {
     final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
     await docTodo.delete();
   }
}