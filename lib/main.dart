import 'dart:io';
import 'dart:ui';
import 'package:assingment/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'Home_Screen.dart';
import 'Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login': (context) => const login(),
        '/homeScreen': (context) => const homeScreen(),
        '/images': (context) => const images()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  RegExp phone = RegExp(
      r'^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');
  RegExp exp = RegExp(r'^[\w\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$');
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: images(),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.black,
                          size: 0.20,
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/images');
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Colors.deepPurple,
                        ),
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value) => value!.isEmpty
                          ? 'Enter Your Name'
                          : (exp.hasMatch(value) ? null : 'Enter a valid Name'),
                      decoration: const InputDecoration(
                        label: Text("First Name."),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) => value!.isEmpty
                          ? 'Enter your Last Name'
                          : (exp.hasMatch(value) ? null : 'Enter a valid name'),
                      decoration: const InputDecoration(
                        label: Text("Last Name."),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) => value!.isEmpty
                          ? 'Enter Email'
                          : (email.hasMatch(value)
                              ? null
                              : 'Enter a valid email'),
                      decoration: const InputDecoration(
                        hintText: 'html@gmail.com',
                        label: Text("Email"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: phoneNumberController,
                      validator: (value) => value!.isEmpty
                          ? 'Enter the Number'
                          : (phone.hasMatch(value)
                              ? null
                              : 'Enter your phone number'),
                      decoration: const InputDecoration(
                        label: Text("Phone Number "),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) => value!.isEmpty
                          ? 'Enter your password'
                          : (password.hasMatch(value)
                              ? null
                              : 'Enter your correct password'),
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) => passwordController.text != value
                          ? 'Password not the same'
                          : null,
                      decoration: const InputDecoration(
                        label: Text("confirmPassword"),
                        hintText: 'repeat the same password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        singUp(emailController.text, passwordController.text);
                      },
                      child: const Text("Sing Up"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void singUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastname = lastNameController.text;
    userModel.phone = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully ");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homeScreen()),
        (route) => false);
  }
}
