import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final _firebase = FirebaseAuth.instance;


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}


final TextEditingController emailcontroller = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _formkey = GlobalKey<FormState>();

  var usersEmail = '';


  resetpasswordfunction() async {
    _formkey.currentState!.validate();
    _formkey.currentState!.save();

    try{


      await _firebase.sendPasswordResetEmail(email: usersEmail);
      showDialog(context: context, builder: (context) {
        return Dialog(

          child: Container(

            height: 300,
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 100,),
                Center(child: Text('Check your email please!', style: TextStyle(fontWeight: FontWeight.w600),)),
                SizedBox(height: 60,),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('Okay'))
              ],
            ),
        ),);
      },);


    }  on FirebaseAuthException catch (error)
    {
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
                content: Text(error.message!),
         ),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [
          //main column starts here
          Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(color: Colors.pink.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [BoxShadow(
                            blurRadius: 1.9,
                            blurStyle: BlurStyle.outer,
                            color: Colors.white.withOpacity(0.98)
                        )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left : 15),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || !value.contains('@') || value.isEmpty || !value.contains('.com'))
                          {
                            print('email invalid hai');
                            return 'Enter a valid email address';
                          }
                          else {
                            print( 'good email');
                          }
                          //return 'good email';


                        },
                        onSaved:(email) {
                          usersEmail = email!;
                        },

                        controller: emailcontroller,
                        decoration: const InputDecoration(

                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                            hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Schyler', fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 150),

          ElevatedButton(onPressed: (){
            resetpasswordfunction();
          },
              child: Text('Reset Password')
          ),

          SizedBox(height: 80,),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Go back to Login'))

        ],
      ),
    );
  }
}
