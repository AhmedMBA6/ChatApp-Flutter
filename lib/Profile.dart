import 'package:assingment/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
class myProfile extends StatefulWidget {
  const myProfile({Key? key}) : super(key: key);

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel logined = UserModel();
  var fireStore = FirebaseFirestore.instance;

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value) {
      this.logined = UserModel.fromMap(value.data());
      setState(() {

      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapShot) {
              return snapShot.hasData
                  ? ListView.builder(


                  shrinkWrap: true,
                  itemCount: snapShot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Text(snapShot.data?.docs[index]['firstName']);
                  })
                  : snapShot.hasError
                  ? Text('Error')
                  : CircularProgressIndicator();
            },
              ),
          SizedBox(
            child: ActionChip(label:const Text("Log Out"), onPressed: (){
              logOut(context);
            }),
          )
        ],
      ),

    );
  }
  Future<void> logOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> login()));

  }
}
