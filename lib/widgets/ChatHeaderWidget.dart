import 'package:assingment/widgets/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<UserModel> users;

  const ChatHeaderWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 75,
            child: Text(
              'Chat App ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                if (index == 0) {
                  return Container(margin: EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      radius: 24, child: Icon(Icons.search),),);
                } else {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(user.urlAvatar),
                      ),
                    ),
                  );
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
