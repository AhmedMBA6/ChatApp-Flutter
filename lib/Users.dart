import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class images extends StatefulWidget {
  const images({Key? key}) : super(key: key);

  @override
  State<images> createState() => _imagesState();
}

class _imagesState extends State<images> {
  File? image;
  final imagePicker = ImagePicker();
  Future getImage() async{
    try{
      final image = await imagePicker.getImage(source: ImageSource.gallery);//ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null)return;
      final imageTemp = File(image.path);
      setState(()

        => this.image = imageTemp
      );
    }
    on PlatformException catch(e){
      print('Faild to pick imag: $e');
    }
  }
  Future pickImageC() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null)return;
      final imageTemp = File(image.path);
      setState(()
      => this.image = imageTemp
      );
    }
    on PlatformException catch(e){
      print('Faild to pick imag: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  color: Colors.grey,
                  child: Text(
                    'Pick Image from gallary',
                    style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    getImage();
                  }),
              Container(
                height: 20,
              ),

              MaterialButton(
                  color: Colors.grey,
                  child: Text(
                    'Pick Image from camera',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    pickImageC();

                  }),

              SizedBox(
                height: 20,
              ),
              image != null ? Image.file(image!): Text('Not Image Selected'),
              FloatingActionButton(onPressed: (){
                Navigator.pop(context);
              }, child: Icon(Icons.done))
            ],
          ),
        ),
      ),
    );
  }
}
