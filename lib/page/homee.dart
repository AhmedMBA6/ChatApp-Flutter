//import 'package:assingment/widgets/model/models.dart';
import 'package:assingment/model/models.dart';
import 'package:assingment/page/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ApiClient.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(title: Text(" Les's Chat"),),
          body: StreamBuilder<List<UserModel>>(
            stream: getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Somthing went wrong");
              }
              else if (snapshot.hasData) {
                final users = snapshot.data!;
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(children:
                      users.map(builduser).toList()
                        ,),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: ChatPage));
                    }, child: const Text("Message"))
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserPage()));
            },

          );
          Widget builduser(UserModel user)

  =>

  ListTile

  (
  leading:
  CircleAvatar
  (child:Icon(Icons.account_circle_outlined)
  ,)
  ,title:Text(user.userName!),
  subtitle:Text(user.phone!),
  );

  Stream<List<UserModel>> getAllUsers() =>
      FirebaseFirestore.instance.collection('users').snapshots().map((
          snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());

  Widget buildText(String text) =>
      Center(
        child: Text(text, style: TextStyle(fontSize: 24, color: Colors.white),),
      );

}
