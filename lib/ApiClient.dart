//import 'package:assingment/model/message.dart';
// import 'package:assingment/model/models.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'Utils.dart';
//
// class FirebaseApi {
//   static Stream<List<UserModel>> getUsers() =>
//       FirebaseFirestore.instance
//           .collection('users')
//           .orderBy(UserField.lastMessageTime, descending: true)
//           .snapshots()
//           .transform(Utils.transformer(UserModel.fromJson));
//
//   static Future uploadMessage(String uid, String message) async {
//     final refMessage = FirebaseFirestore.instance.collection(
//         'chats/$uid/message');
//     final newMessage = Message(
//       uid: myId,
//       firstName: myFristName,
//       urlAvatar: myUrlAvatar,
//       message: message,
//       createdAt: DateTime.now(),
//     );
//     await refMessage.add(newMessage.toJson());
//     final refUsers = FirebaseFirestore.instance.collection('users');
//     await refUsers.doc(uid).
//     update({UserField.lastMessageTime: DateTime.now()});
//   }
//
//   static Stream<List<Message>> getMessages(String uid) =>
//       FirebaseFirestore.instance.collection('chats/$uid/messages').orderBy(
//           MessageField.createdAt, descending: true).snapshots().transform(Utils.transformer((Message.fromJson));
//
// }