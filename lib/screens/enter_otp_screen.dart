import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key, required this.verificationID});

  final String verificationID;

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

TextEditingController otpController = TextEditingController();

class _EnterOtpScreenState extends State<EnterOtpScreen> {

  final _formkey = GlobalKey<FormState>();

  var otpAuth = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200,),
          Form(child: Column(
            children: [
              TextFormField(

                validator: (value) {
                  if (value == null || value.isEmpty)
                  {
                    print('email invalid hai');
                    return 'Enter a valid otp';
                  }
                  else {
                    print( 'good email');
                  }

                },
                keyboardType: TextInputType.number,
                controller: otpController,
                onSaved:(otp) {
                  otpAuth = otp!;
                },
                decoration: const InputDecoration(

                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                    hintText: 'OTP',hintStyle: TextStyle(fontFamily: 'Schyler', fontSize: 14)
                ),
              )
            ],
          )
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: () async{
              final cred = PhoneAuthProvider.credential(verificationId: widget.verificationID, smsCode: otpController.text);

            },
              child: Text('Verify the OTP'))
        ],
      ),
    );
  }
}
