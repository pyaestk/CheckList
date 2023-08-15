import 'package:dcdg/dcdg.dart';
import 'package:checkList/screens/donelists.dart';
import 'package:checkList/screens/sidebar.dart';
import 'package:checkList/todologic/todosprovider.dart';
import 'package:checkList/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/FirebaseApi.dart';
import '../todologic/todo.dart';
import '../todologic/todolistwidget.dart';
import 'todolistDialog.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Your Lists', style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("B267EE"),
                hexStringToColor("FF84BA"),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(5, 3), // Offset in the horizontal and vertical direction
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              hexStringToColor("B267EE"),
              hexStringToColor("FF84BA"),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return tododialog();
              },
              barrierDismissible: false,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.add),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: StreamBuilder<List<Todo>>(
          stream: FirebaseApi.readTodos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildText('Something Went Wrong... Try again later');
                } else {
                  final todos = snapshot.data;
                  final provider = Provider.of<TodosProvider>(context);
                  provider.setTodos(todos!);

                  return todos!.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/task.png',
                          fit: BoxFit.fitWidth,
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No lists here!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.separated(
                    itemCount: todos!.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ToDoWidget(todo: todo);
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 6);
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
