import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenotes/authentication/signin.dart';
import 'package:firebasenotes/notes_add/noteshome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller= TextEditingController();
    TextEditingController pswrdcontoller= TextEditingController();
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(children: [
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(
                label: Text("email"),
                hintText: "enter your email.. ",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),

                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21))

            ),
          ),
          SizedBox(
            height: 11,
          ),
          TextField(
            controller: pswrdcontoller,
            decoration: InputDecoration(
                label: Text("pswrd"),
                hintText: "enter your pswrd.. ",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),

                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21))

            ),
          ),
          SizedBox(
            height: 11,
          ),
          ElevatedButton(onPressed: ()async{
            FirebaseAuth mauth=FirebaseAuth.instance;
            try{
              var cred= await mauth.signInWithEmailAndPassword(email: emailcontroller.text, password: pswrdcontoller.text);
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Noteshome()));
            }catch(e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error :${e.toString()}")));

            }
          }, child: Text("Login")),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Register()));
          }, child: Text("didn't have acc? register here"))
        ],

        ),

      ),

    );
  }
}
