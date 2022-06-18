//import 'package:flutter/material.dart';
//
// class MessageWidget extends StatelessWidget {
//   final String message;
//   final bool isMe;
//
//   const MessageWidget({Key? key, required this.message, required this.isMe})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final radius = Radius.circular(12);
//     final borderRaduis = BorderRadius.all(radius);
//     return Row(
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment
//             .start,
//         children: [
//         if(!isMe)
//     CircleAvatar(
//       radius: 16, backgroundImage: NetworkImage(message.urlAvatar),
//
//     ),
//     Container(
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.all(16),
//         constraints: BoxConstraints(maxWidth: 140),
//         decoration: BoxDecoration(
//             color: isMe ? Colors.greenAccent : Theme
//                 .of(context)
//                 .accentColor,
//             borderRadius: isMe
//                 ? borderRaduis.subtract(BorderRadius.only(bottomRight: radius))
//                 : borderRaduis.subtract((BorderRadius.only(bottomLeft: radius)))
//         ),
//         child:buildMessage()
//     )
//     ]
//     ,
//
//     );
//   }
//     Widget buildMessage()
//     =>
//         Column(
//           crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment
//               .start,
//           children: [
//             Text(message.message, style:TextStyle(color: isMe ? Colors.black : Colors.white),
//               textAlign: isMe ? TextAlign.end : TextAlign.start,),
//           ],
//         );
// }