import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/models.dart';

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
  final _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  RegExp phone = RegExp(
      r'^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$');
  RegExp exp = RegExp(r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$');
  RegExp userName = RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$');
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
          source:
          source); //ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() => _imageFile = pickedFile);
    } on PlatformException catch (e) {
      print('Faild to pick imag: $e');
    }
  }

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
                  imageProfile(),
                  Container(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Container(
                      height: 580,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff295b85), Colors.blueGrey])),
                      child: Column(
                        children: [
                          Padding(padding: const EdgeInsets.all(10.0),

                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: firstNameController,
                                validator: (value) =>
                                value!.isEmpty
                                    ? 'Enter Your full Name'
                                    : (exp.hasMatch(value)
                                    ? null
                                    : 'Enter a valid Name'),
                                decoration: InputDecoration(
                                    label: const Text("Full Name."),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.deepOrangeAccent))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: lastNameController,
                                validator: (value) =>
                                value!.isEmpty
                                    ? 'Enter your user Name'
                                    : (exp.hasMatch(value)
                                    ? null
                                    : 'try another user'),
                                decoration: InputDecoration(
                                    label: const Text(" userName:"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.deepOrangeAccent))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) =>
                                value!.isEmpty
                                    ? 'Enter Email'
                                    : (email.hasMatch(value)
                                    ? null
                                    : 'Enter a valid email'),
                                decoration: InputDecoration(
                                  hintText: 'html@gmail.com',
                                  label: const Text("Email:"),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: phoneNumberController,
                                validator: (value) =>
                                value!.isEmpty
                                    ? 'Enter the Number'
                                    : (phone.hasMatch(value)
                                    ? null
                                    : 'Enter your phone number'),
                                decoration: InputDecoration(
                                  label: const Text("Phone Number "),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) =>
                                value!.isEmpty
                                    ? 'Enter your password'
                                    : (password.hasMatch(value)
                                    ? null
                                    : 'Enter your correct password'),
                                decoration: InputDecoration(
                                  label: const Text("Password"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.deepOrangeAccent)),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 80,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                validator: (value) =>
                                passwordController.text != value
                                    ? 'Password not the same'
                                    : null,
                                decoration: InputDecoration(
                                  label: const Text("confirmPassword"),
                                  hintText: 'repeat the same password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.deepOrangeAccent)),
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        ],
                      ),
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
    userModel.id = user.uid;
    userModel.fullName = firstNameController.text;
    userModel.userName = lastNameController.text;
    userModel.phone = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully ");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const homeScreen()),
            (route) => false);
  }

  Widget imageProfile() {
    var file = File(_imageFile!.path) ;
    return Center(
        child: Stack(
            children: [
            CircleAvatar(
            radius: 70,
            backgroundImage: _imageFile != null
                ?  _storage.ref()
            .child('folderName/imageName')
            .putFile(file)as ImageProvider
            :const AssetImage('assets/website.jpg')
            ),
    Positioned(
    bottom: 15.0,
    right: 15.0,
    child: InkWell(
    onTap: () {
    showModalBottomSheet(
    context: context, builder: ((builder) => bottomSheet()));
    },
    child: const Icon(
    Icons.add_a_photo_outlined,
    color: Colors.teal,
    size: 30.0,
    )),
    ),
    ],
    ),
    );
  }

  Widget bottomSheet() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  }),
              const SizedBox(
                width: 60,
              ),
              TextButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  })
            ],
          )
        ],
      ),
    );
  }
}
