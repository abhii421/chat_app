import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/enter_otp_screen.dart';

final _firebase = FirebaseAuth.instance;

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

final TextEditingController phonecontroller = TextEditingController();

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  final _formkey = GlobalKey<FormState>();
  var usersPhone = '';


  sendOtpFunction(){

    bool check = _formkey.currentState!.validate();
    _formkey.currentState!.save();
    print('**************************');
    print(check);

    _firebase.verifyPhoneNumber(
        phoneNumber: phonecontroller.text,
        verificationCompleted: (phoneAuthCredential) {
            
        },
        verificationFailed: (error) {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('OOPS! An error Occurred'),
              content: Text(error.toString()),
              actions: [
                Center(
                  child: ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                    },
                      child: Text('Okay!')),
                )
              ],
            );
          },);
        },
        codeSent: (verificationId, forceResendingToken) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EnterOtpScreen(verificationID: verificationId,);
              },));
        },
        codeAutoRetrievalTimeout: (verificationId) {

        },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length<10 )
                          {
                            print('phone invalid hai');
                            return 'Enter a valid phone number';
                          }
                          else {
                            print( 'good number');
                          }



                        },
                        onSaved:(num) {
                          usersPhone = num!;
                        },
                        keyboardType: TextInputType.number,
                        controller: phonecontroller,
                        decoration: const InputDecoration(

                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                            hintText: 'Phone Number (Add +91)',hintStyle: TextStyle(fontFamily: 'Schyler', fontSize: 14)
                        ),

                      ),
                    ),
                  ),
                  IconButton(onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(content: Text('Firebase Phone Auth is now a paid feature\nTry sending the OTP, an error for billing occurs'),);
                    },);
                  }, icon: Icon(Icons.info))
                ],
              ),
            ),
            SizedBox(height: 150),

            ElevatedButton(onPressed: (){
              sendOtpFunction();
            },
                child: const Text('Send OTP')
            ),
          ],
        ),
      ),
    );
  }
}
