import 'package:checkList/screens/sidebar.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

//not enough time

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("B267EE"),
                hexStringToColor("FF84BA"),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Image.asset('asset/aboutsUS.jpg', fit: BoxFit.fitWidth),
            Positioned(
              top: 110, // Adjust the values according to your requirement
              left: 30,
              child: Text(
                'About Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 140, // Adjust the values according to your requirement
              left: 40,
              child: Text(
                'CheckList App',
                style: TextStyle(
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
