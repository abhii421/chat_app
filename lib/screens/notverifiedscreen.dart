import 'package:flutter/material.dart';
import 'package:chat_app/screens/login_screen.dart';

class notverifiedscreen extends StatefulWidget {
  const notverifiedscreen({super.key});

  @override
  State<notverifiedscreen> createState() => _notverifiedscreenState();
}

class _notverifiedscreenState extends State<notverifiedscreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
        onPressed: (){
          Navigator.of(context).pop();
        }
      ),),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200
            ),
            Center(
              child : Text('    Email not verified\n Verify then try logging in')
            ),

            SizedBox(
                height: 200
            ),

            ElevatedButton(onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()
            )
              );
              },
                child: Text('Verified?'))
          ],
        ),
      )


    );
  }
}
