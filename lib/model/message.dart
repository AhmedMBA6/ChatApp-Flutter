//import 'package:assingment/Utils.dart';
//
// class MessageField {
//   static final String createdAt = 'createdAt';
// }
//
// class Message {
//   final String? id;
//   final String? urlAvatar;
//   final String? firstName;
//   final String? message;
//   final String? createdAt;
//
//   Message(
//       {required this.id,
//       required this.urlAvatar,
//       required this.firstName,
//       required this.message,
//       required this.createdAt});
//
//   static Message fromJson(Map<String, dynamic> json) => Message(
//     id: json['id'],
//     firstName: json['firstName'],
//     urlAvatar: json['urlAvatar'],
//     message: json['message'],
//     createdAt: Utils.toDateTime(json['createdAt']),
//   );
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'urlAvatar': urlAvatar,
//       'createdAt' : Utils.fromDateTimeToJson(createdAt),
//       'message' : message,
//
//
//     };
//   }
// }