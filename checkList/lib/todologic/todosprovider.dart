import 'package:checkList/api/FirebaseApi.dart';
import 'package:flutter/cupertino.dart';

import 'todo.dart';

//observer pattern
//Defining the Subject (Observable)
abstract class TodoSubject {
  void attach(TodoObserver observer);
  void detach(TodoObserver observer);
  void notify();
}

//Implementing the Concrete Subject
class TodosProvider extends ChangeNotifier implements TodoSubject {
  List<Todo> _todos = [];
  List<TodoObserver> _observers = [];

  List<Todo> get todos => _todos.where((todo) => !todo.isDone).toList();
  List<Todo> get donetodos => _todos.where((todo) => todo.isDone).toList();

  void setTodos(List<Todo> todos) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _todos = todos;
      notify();
    });
  }

  void addTodo(Todo todo) {
    FirebaseApi.createTodo(todo);
    notify();
  }

  void deleteTodo(Todo todo) {
    FirebaseApi.deleteTodo(todo);
    notify();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    notify();
    return todo.isDone;
  }

  void updateTodo(
      Todo todo, String title, String description, String price, String shop) {
    todo.title = title;
    todo.description = description;
    todo.shop = shop;
    todo.price = price;
    FirebaseApi.updateTodo(todo);
    notify();
  }

  //Implementing the Observer methods
  @override
  void attach(TodoObserver observer) {
    _observers.add(observer);
  }

  @override
  void detach(TodoObserver observer) {
    _observers.remove(observer);
  }

  @override
  void notify() {
    for (var observer in _observers) {
      observer.update();
    }
    notifyListeners();
  }
}

//Defining the Observer
abstract class TodoObserver {
  void update();
}

//Implementing the Concrete Observer
class TodoWidget implements TodoObserver {
  final TodosProvider subject;

  TodoWidget(this.subject) {
    subject.attach(this);
  }

  @override
  void update() {
    //no need for now
  }
}



