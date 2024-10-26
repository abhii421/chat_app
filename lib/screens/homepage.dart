import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/add_user_details_screen.dart';
import 'package:chat_app/screens/verifiedornotscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:chat_app/widgets/chat_history_widget.dart';
import 'package:chat_app/widgets/send_new_message_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  @override
  void initState() {
    getUserData();
    super.initState();
  }



  Future<void> getUserData() async{

    // final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Chat Users').where('User UID', isEqualTo: userUID).get()
    //     .then((snapshot) => snapshot.docs.first);
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Chat Users').doc(userUID).get();


    if(userDoc.exists){
      setState(() {
        var data = userDoc.data() as Map<String, dynamic>;
        userName = data['Name'] as String;
        userAge = data['Age'] as String;

      });
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Welcome'),
        actions: [

          // ElevatedButton(onPressed: () async{
          //   await FirebaseFirestore.instance.collection('Chat Users').doc(userUID).set({
          //     'Name' : 'Abhinandan Raj',
          //     'Age' : '21',
          //   });
          //   //DEMO button for testing of insertion of document in the chat users collection. This each document named by userUID inside the Chat Users collection
          // }, child: Text('demo')),

          // ElevatedButton(onPressed: () {
          //   print(userName);
          //   print(userAge);
          //   print(userUID);
          //   print(FirebaseAuth.instance.currentUser!.uid);
          // }, child: Text('Print')),




          // ElevatedButton(onPressed: () {
          //     print(userName);
          //   },
          //     child: const Text('print'))
          IconButton(onPressed: () {
            
            showDialog(context: context, builder: (context) {
              return AlertDialog(title: Text('Debug Banner not removed'),
                  
                  content: Text('Despite adding this line of code -- \n\ndebugShowCheckedModeBanner:  false \nInside of Material app'),
                  actions: [
                    Center(
                      child: ElevatedButton(onPressed: () {
                        Navigator.of(context).pop();
                        },
                          child: Text('Okay!')),
                    ),
                    ],
              );
            },);
          }, icon: Icon(Icons.info))
      ],),


      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 100,),
            //Lottie.asset('assets/animations/Animation - 1727837813840.json'),
            Lottie.network('https://lottie.host/9b08c455-2ef9-4f4f-975d-aba5d4d75a97/WfjjQTftvJ.json'),
            SizedBox(height: 100,),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    userUID = '';

                    //await FirebaseServices().signOut();

                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => Homepage()));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(title: 'title')));
                  },
                  child: const Text('Sign Out')),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 45),

          Expanded(
              child: MessageWidget()
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SendNewMessageWidget(),
          ),

        ],
      ),
    );
  }
}
