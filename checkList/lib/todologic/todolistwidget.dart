
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:checkList/screens/editTodo.dart';
import 'package:checkList/todologic/todo.dart';
import 'package:checkList/todologic/todosprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ToDoWidget extends StatelessWidget {
  final Todo todo;
  const ToDoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        editTodo(context, todo);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 2), // Adjust the offset values to change the shadow position
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Slidable(
              key: Key(todo.id),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: todo.isDone ? Icons.delete : Icons.remove_circle,
                    label: todo.isDone ? 'delete'  : 'remove',
                    onPressed: (context) => deleteTodo(context, todo),
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => editTodo(context, todo),
                    foregroundColor: Colors.lightBlue,
                    icon: Icons.archive,
                    label: 'edit',
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.white,
                      checkColor: Colors.purpleAccent,
                      value: todo.isDone,
                      onChanged: (_) {
                        final provider = Provider.of<TodosProvider>(context, listen: false);
                        final isDone = provider.toggleTodoStatus(todo);
                        final snackbar = SnackBar(
                          content: todo.isDone ? Center(child: Text('list has been moved to done lists')) : Center(child: Text('list has been unmarked')),
                          duration: Duration(seconds: 1),
                          backgroundColor: todo.isDone ? Colors.deepPurpleAccent : Colors.purple,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          if (todo.shop.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                'Shop: ${todo.shop}',
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black45),
                              ),
                            ),
                          if (todo.price.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                'Price: \$ ${todo.price}',
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black45),
                              ),
                            ),
                          if (todo.description.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                'Description: ${todo.description}',
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black45),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.deleteTodo(todo);

    final snackbar = SnackBar(
      content: todo.isDone ? Center(child: Text('marked list has been deleted')) : Center(child: Text('unmarked list has been removed')),
      duration: Duration(seconds: 1),
      backgroundColor: todo.isDone ? Colors.deepPurpleAccent : Colors.purple,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditTodo(todo: todo)));
}


abstract class TodoComponent {
  void delete();
  void edit();
}
