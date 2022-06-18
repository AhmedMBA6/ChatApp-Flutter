import 'package:assingment/widgets/model/models.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final List<UserModel> users;

  const ChatPage({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      body: SafeArea(child: Column(
        children: [
          profileHeaderWidget(firstName: widget.user.firstName),
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: MessagesWidget(uid:widget.user.uid),
          ))
          NewMessageWidget(uid: widget.user.uid)
        ],
      ),),
    );
  }
}
