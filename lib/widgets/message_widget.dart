//import 'package:assingment/ApiClient.dart';
// import 'package:flutter/material.dart';
//
// class MessagesWidget extends StatelessWidget {
//   final String uid;
//
//   const MessagesWidget({Key? key, required this.uid}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) =>
//       StreamBuilder<List<MessagesWidget>>(
//           stream: FirebaseApi.getMessages(uid), builder: (context, snapshot) {
//         final messages = snapshot.data;
//         return messages.isEmpty ? buildText('say hi ...') : ListView.builder(
//           physics: BouncingScrollPhysics(),
//           reverse: true,
//           itemCount: messages.length,
//           itemBuilder
//               : (context, index) {
//             final message = messages[index];
//             return MessagesWidget(message: message, isMe: message.uid == myId,);
//           },);
//       });
//
//   )
//
//   Widget buildText(String text) =>
//       Center(
//         child: Text(text, style: TextStyle(fontSize: 24),),
//       );
//
// }