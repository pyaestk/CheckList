import 'package:checkList/todologic/todo.dart';
import 'package:checkList/screens/todolistDialog.dart';
import 'package:checkList/todologic/todolistwidget.dart';
import 'package:checkList/todologic/todosprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../todologic/todoWidget.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;
  const EditTodo({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  late String title;
  late String description;
  late String price;
  late String shop;

  final _formKey = GlobalKey<FormState>();

  void initState(){
    super.initState();
    title = widget.todo.title;
    price = widget.todo.price;
    description = widget.todo.description;
    shop = widget.todo.shop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit list', style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("B267EE"),
                hexStringToColor("FF84BA"),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: IconButton(onPressed: () {
              final provider = Provider.of<TodosProvider>(context, listen: false);
              provider.deleteTodo(widget.todo);
              Navigator.of(context).pop();
              },
                icon: Icon(Icons.delete)
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            title: title,
            price: price,
            shop: shop,
            description: description,
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }),
            onChangedShop: (shop) => setState(() {
              this.shop = shop;
            }),
            onChangedPrice: (price) => setState(() {
              this.price = price;
            }),
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }), onSavedTodo: saveTodo,
          ),
        ),
      )
    );


  }
  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if(!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description, price, shop);
      Navigator.of(context).pop();
    }
  }

}
