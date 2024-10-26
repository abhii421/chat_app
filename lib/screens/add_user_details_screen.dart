import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/homepage.dart';

class AddUserDetailsScreen extends StatefulWidget {
  const AddUserDetailsScreen({super.key});

  @override
  State<AddUserDetailsScreen> createState() => _AddUserDetailsScreenState();
}

final _firestore = FirebaseFirestore.instance;
final _firebase = FirebaseAuth.instance;


String userName = '';
String userAge = '';
String userUID = _firebase.currentUser!.uid;


TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();


bool nameOkay = false;
bool ageOkay = false;




class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {

  final _userDetailsFormKey = GlobalKey<FormState>();


  void addUserInfoToFirestore() async {
    if(_userDetailsFormKey.currentState!.validate() == true){

      print(nameOkay);
      print(ageOkay);

      print(userName);
      print(userAge);
       print('All values are valid');



      _userDetailsFormKey.currentState!.save();
      //String userUID = _firebase.currentUser!.uid;

      if(nameOkay == true && ageOkay == true ){
        await _firestore.collection('Chat Users').doc(_firebase.currentUser!.uid).set({
          'Name' : userName,
          'Age' : userAge,
        });
      }



      //await FirebaseAuth.instance.currentUser!.


      if(nameOkay == true && ageOkay == true ){
        Navigator.push(context,  MaterialPageRoute(builder: (context) {
          return Homepage();
        },));
      }

    }

    else {
      // print(nameOkay);
      // print(addressOkay);
      // print(numberOkay);

      print('Some values are wrong');
    }
  }

  @override
  void initState() {
    print('********************************************************************************');
    print('********************************************************************************');

    print(_firebase.currentUser!.uid);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _userDetailsFormKey,
                child: Column(
                  children: [
                    const SizedBox(height : 20),


                    TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Name'),
                      validator: (value) {
                        if(value == null || value.length<2 || value.isEmpty)
                        {
                          nameOkay = false;
                          return 'Invalid Name';
                        }
                        else {
                          setState(() {
                            nameOkay = true;
                          });
                        }
                      },
                      controller: nameController,
                      onSaved: (newValue1) {
                        //print(newValue1);
                        userName = newValue1!;
                      },
                    ),



                    const SizedBox(height : 30),



                    TextFormField(

                      decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Age'),

                      validator: (value) {
                        if(value==null || value.isEmpty || value == '0'){
                          ageOkay = false;
                          return 'Please give correct age';
                        }
                        else{
                          setState(() {
                            ageOkay = true;
                          });
                        }
                      },
                      controller: ageController,
                      onSaved: (newValue2) {
                        userAge = newValue2!.trim();
                      },
                      keyboardType: TextInputType.number,
                    ),

                  ],
                ),


              ),



              const SizedBox(height : 35),



              ElevatedButton(
                  onPressed: (){
                    addUserInfoToFirestore();
                  },
                  child: const Text('Add Info')),

            ],
          ),
        ),
      ),
    );
  }
}

















// ElevatedButton(onPressed: (){
// print(nameOkay);
// print(addressOkay);
// print(numberOkay);
// },
// child: Text('Print bools')),
