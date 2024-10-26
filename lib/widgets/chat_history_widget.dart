import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/screens/add_user_details_screen.dart';
import 'package:chat_app/widgets/single_message_widget.dart';

final _firestore = FirebaseFirestore.instance;
final _firebase = FirebaseAuth.instance;

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
        stream: _firestore.collection('Chats').orderBy('created At', descending: true).snapshots(),
        //order by parameter sorts the messages by time. ye msgs ko order me show krta h
        builder: (ctx, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }

            if(snapshot.data!.docs.isEmpty){
              return const Center(
                child: Text('No messages found!', style: TextStyle(fontWeight: FontWeight.w600),),);
            }

            if(snapshot.hasData == false){
              return const Center(
                child: Text('No messages found!', style: TextStyle(fontWeight: FontWeight.w600),),);
            }

            if(snapshot.hasError){

              String error = snapshot.error.toString();
              return Center(child: Text(error),);

            }




              final listOfMessages = snapshot.data!.docs;
            //In the above line of code we can assure that the data will never be null, because we have checked that above
            //using if blocks.

              return ListView.builder(
                reverse: true,
                itemCount: listOfMessages.length,
                itemBuilder: (ctx, index) {
                  final chatMessage = listOfMessages[index].data();
                  final nextChatMessage = index+1< listOfMessages.length? listOfMessages[index+1].data() : null;

                  final currentMessageUserId = chatMessage['user ID'];

                  final nextMessageUserId = nextChatMessage!=null ? nextChatMessage['user ID'] : null;

                  final nextUserIsSame = nextMessageUserId == currentMessageUserId;

                  if(nextUserIsSame){
                    return MessageBubble.next(message: chatMessage['text'],
                        isMe: FirebaseAuth.instance.currentUser!.uid == currentMessageUserId);
                  } else{
                    return MessageBubble.first(
                        username: chatMessage['username'],
                        message: chatMessage['text'],
                        isMe: FirebaseAuth.instance.currentUser!.uid == currentMessageUserId);
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text(listOfMessages[index]['text']),
                  );
              },);

        },);
    return const Center(
      child: Text('No messages found'),
    );
  }
}
