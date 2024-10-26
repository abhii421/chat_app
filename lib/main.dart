import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/loading.dart';
import 'package:chat_app/screens/homepage.dart';
import 'package:flutter/material.dart';
//import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/screens/notverifiedscreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}






class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        home : StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder : (ctx, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting){
                return const SplashScreen();
                //const splashscreen();
              }

              if(snapshot.hasData){
                print('It is logged in now');
                return const Homepage();
              }

              else
              {
                return const LoginScreen();
              }
            }
        )
    );
  }
}
