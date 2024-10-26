import 'package:chat_app/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){

        if(snapshot.hasData){
          return const Homepage();
        }
        else {
          return const MyHomePage(title: 'title');
        }


      }
      ),
    );
  }
}
