import 'package:assingment/page/Profile.dart';
import 'package:assingment/page/homee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class homeScreen extends StatefulWidget {
   const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  var fireStore = FirebaseFirestore.instance;
  int _currentIndex = 0;
  List<Widget> pages = const[
   myProfile(),
    home()

  ];


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.chevron_left_2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('My Application'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bars,
            ),
          )
        ],
      ),
      body: pages[_currentIndex],

     bottomNavigationBar: BottomNavigationBar(
       onTap: (Index) => setState(() {
         _currentIndex =Index;
       }),
       currentIndex: _currentIndex,
       items: const [
         BottomNavigationBarItem(
           icon: Icon(Icons.account_circle_outlined),
           label: "Profile",
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           label: "Home",
         ),
       ],
     ),

    );
  }
}

