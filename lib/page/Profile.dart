import 'package:assingment/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../login_screen.dart';

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
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<UserModel?>(
            future: getOneUser(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text('Something went wrong!');
              }
              else if (snapshot.hasData) {
                final user = snapshot.data;
                return user == null ? Center(child: Text('No User'))
                    :buildUser(user);
              }else{
                return Center(child:  CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
            child: ActionChip(
                label: const Text("Log Out"),
                onPressed: () {
                  logOut(context);
                }),
          )
        ],
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => login()));
  }

  Widget buildUser(UserModel user) =>
      Padding(padding: EdgeInsets.all(10),
      child:Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 80,
            child: TextFormField(
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Text(user.fullName! ,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),),
              IconButton(onPressed: (){}, icon:Icon(Icons.edit) )
                  ],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent)),
              ),
            ),
          ),
        ),
        SizedBox(height: 25,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 80,
            child: TextFormField(
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Text(user.userName!,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),),
  IconButton(onPressed: (){}, icon:Icon(Icons.edit) )
                  ],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent)),
              ),
            ),
          ),
        ),
        SizedBox(height: 25,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 80,
            child: TextFormField(
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Text(user.email!,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),),
  IconButton(onPressed: (){}, icon:Icon(Icons.edit) )
                  ],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent)),
              ),
            ),
          ),
        ),
        SizedBox(height: 25,)
        ,Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 80,
            child: TextFormField(
              decoration: InputDecoration(
                label: Row(
                  children: [
                    Text(user.phone!,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),),
                    IconButton(onPressed: (){}, icon:Icon(Icons.edit) )
                  ],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                        color: Colors.deepOrangeAccent)),
              ),
            ),
          ),
        ),

      ],) ,);



  Future<UserModel?> getOneUser() async{
    final docUser = FirebaseFirestore.instance.collection('users').doc('4bBObgtrK3byMCzJsKq1NdQq23r2');
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return UserModel.fromMap(snapshot.data()!);
    }
  }
}
