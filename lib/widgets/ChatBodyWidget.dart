import 'package:assingment/page/chat_page.dart';
import 'package:assingment/widgets/model/models.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<UserModel> users;

  const ChatBodyWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: buildChats,
      ),
    );
  }

  Widget buildChats() => ListView.builder(
    physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatPage(users: users) ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.urlAvatar),
              ),
              title: Text(user.firstName),
            ),
          );
        },
        itemCount: users.length,
      );
}
