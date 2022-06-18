import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home_Screen.dart';

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/homeScreen': (context) => const homeScreen()},
    );
  }
}

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25) , bottomRight: Radius.circular(25),),
                child: Container(height: 50, decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff2905b8), Colors.blueGrey])),
                child: const Center(child: Text("Welcom" , style: TextStyle(fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontStyle: FontStyle.italic,
                ),)),),
              ),
              const SizedBox(
                height: 40,
              ),

              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Container(
                  height: 350,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff209b85), Colors.blueGrey])),

                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: emailController,
                              onSaved: (value){
                                emailController.text = value!;
                              },
                              validator: (value) =>
                              value!.isEmpty
                                  ? 'Enter your Email'
                                  : (email.hasMatch(value)
                                  ? null
                                  : 'Enter your Email'),
                              decoration: const InputDecoration(
                                hintText: 'txt@gmail.com',
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
                              controller: passwordController,
                              onSaved: (value){
                                passwordController.text = value!;
                              },
                              obscureText: true,
                              validator: (value) =>
                              value!.isEmpty
                                  ? 'Enter your password'
                                  : (password.hasMatch(value)
                                  ? null
                                  : 'Enter your correct password'),
                              decoration: const InputDecoration(
                                hintText: "Minimum eight characters, at least one letter and one number",
                                label: Text("Password"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                          TextButton(onPressed:(){
                            Navigator.pop(context);


                          }, child: const Text("Sing Up",  style: TextStyle(decoration: TextDecoration.underline))),
                          ElevatedButton(onPressed:() {
                            singIn(emailController.text, passwordController.text);


                          }, child:const Text("login"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  void singIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successfully"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const homeScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}

