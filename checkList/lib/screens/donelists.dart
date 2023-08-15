import 'package:checkList/screens/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todologic/todolistwidget.dart';
import '../todologic/todosprovider.dart';
import '../utils/colors.dart';

class PurchasedLists extends StatelessWidget {
  const PurchasedLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('Done lists', style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("B267EE"),
                hexStringToColor("FF84BA"),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15),
        child: DoneLists(),
      ),
    );
  }
}

class DoneLists extends StatelessWidget {
  const DoneLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<TodosProvider>(context);
    final donetodos = provider.donetodos;

    return donetodos.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/reading.png',
            fit: BoxFit.fitWidth,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            'No lists are done!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    )
        : ListView.separated(
      itemCount: donetodos.length,
      itemBuilder: (context, index) {
        final todo = donetodos[index];
        return ToDoWidget(todo: todo);
      },
      separatorBuilder: (context, index) {
        return Container(height: 6);
      },
    );
  }
}

