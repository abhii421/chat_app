import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/add_user_details_screen.dart';

//String userUID = FirebaseAuth.instance.currentUser!.uid;


class SendNewMessageWidget extends StatefulWidget {
  const SendNewMessageWidget({super.key});

  @override
  State<SendNewMessageWidget> createState() => _SendNewMessageWidgetState();
}

class _SendNewMessageWidgetState extends State<SendNewMessageWidget> {

  final _msgController = TextEditingController();

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _fetchMessageFromTextBoxAndSend() async{

        final fetchedMessageFromTextBox = _msgController.text;

        if(fetchedMessageFromTextBox.trim().isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No message content')));
          return;
        }

        //else{

        final user = FirebaseAuth.instance.currentUser!;
        final userData = await FirebaseFirestore.instance.collection('Chat Users')
            .doc(user.uid)
            .get();

          FirebaseFirestore.instance.collection('Chats').add({
            'text' : fetchedMessageFromTextBox,
            'created At' : Timestamp.now(),
            'user ID' : user.uid,
            //'username' : FirebaseFirestore.instance.collection('Chat Users').doc(FirebaseAuth.instance.currentUser!.uid)['Name'];
            'username' : userData.data()!['Name']

          });



        //}

        _msgController.clear();
        FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: 'Send a message', ),
            controller: _msgController,
        )),
        IconButton(
            onPressed: () {
          _fetchMessageFromTextBoxAndSend();
          },
            icon: const Icon(Icons.send))
      ],
    );
  }
}
