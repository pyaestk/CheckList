import 'package:checkList/screens/home.dart';
import 'package:checkList/screens/donelists.dart';
import 'package:checkList/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Drawer(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(user?.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final userData = snapshot.data?.data();
            final userName = userData?['userName'];

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        hexStringToColor("FF84BA"),
                        hexStringToColor("B267EE")
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  accountName: Text(
                    userName ?? 'User',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  accountEmail: Text(user?.email ?? 'example@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset('asset/woman.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                    leading: Icon(Icons.view_list),
                    title: Text('Your Lists', style: TextStyle(color: Colors.black54)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                    leading: Icon(Icons.done_all),
                    title: Text('Done lists', style: TextStyle(color: Colors.black54)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PurchasedLists()),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out', style: TextStyle(color: Colors.black54)),
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        print("Log out");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
