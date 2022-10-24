import 'package:flutter/material.dart';

import '../models/chatUsersModel.dart';
import '../widgets/conversationList.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatUsers> chatUsers = [
    ChatUsers(name: "Foba Alinet Blaise", messageText: "Awesome Setup", imageURL: "assets/images/Foba.jpg", time: "Now"),
    ChatUsers(name: "Youssouf Mohamed", messageText: "That's Great", imageURL: "assets/images/you.jpeg", time: "Yesterday"),
    ChatUsers(name: "Togyanouba Olivier", messageText: "Hey where are you?", imageURL: "assets/images/olver.JPG", time: "31 Mar"),
    ChatUsers(name: "Louakalba Rigobert", messageText: "Busy! Call me in 20 mins", imageURL: "assets/images/Rigobert.JPG", time: "28 Mar"),
    ChatUsers(name: "Saïda", messageText: "Thankyou, It's awesome", imageURL: "assets/images/saida.jpg", time: "23 Mar"),
    ChatUsers(name: "Amira", messageText: "will update you in evening", imageURL: "assets/images/amira.jpg", time: "17 Mar"),
    ChatUsers(name: "Mahamat", messageText: "Can you please share the file?", imageURL: "assets/images/mahamat.jpg", time: "24 Feb"),
    ChatUsers(name: "Leonnel", messageText: "How are you?", imageURL: "images/lion.jpg", time: "18 Feb"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.pink,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}