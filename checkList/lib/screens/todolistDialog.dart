
import 'package:checkList/todologic/todosprovider.dart';
import 'package:checkList/widgets/reuseable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../todologic/todoWidget.dart';
import '../todologic/todo.dart';

class tododialog extends StatefulWidget {
  const tododialog({Key? key}) : super(key: key);

  @override
  State<tododialog> createState() => _tododialogState();
}

class _tododialogState extends State<tododialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String price = '';
  String shop = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 130),
      child: AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Add your list', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
              ),
              SizedBox(
                height: 8,
              ),
              TodoFormWidget(
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
                }),
                onSavedTodo: addTodo,
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        shop: shop,
        price: price,
        description: description, createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }

}


