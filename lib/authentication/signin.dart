import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenotes/notes_add/noteshome.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  TextEditingController nameController= TextEditingController();
  TextEditingController  emailController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController pswrdController= TextEditingController();
  TextEditingController cnfrmPwrdController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
     child: Column(
       children: [
         TextField(
           controller: nameController,
           decoration: InputDecoration(
             label: Text("name"),
             hintText: "enter your name.. ",
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
           controller: phoneController,
           decoration: InputDecoration(
               label: Text("phone"),
               hintText: "enter your phone no.. ",
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
           controller: emailController,
           decoration: InputDecoration(
               label: Text("email"),
               hintText: "enter your mail.. ",
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
           controller: pswrdController,
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
         TextField(
           controller: cnfrmPwrdController,
           decoration: InputDecoration(
               label: Text("re enterpswrd"),
               hintText: "enter your pswrd.. ",
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(21),

               ),
               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21))

           ),
         ),


         ElevatedButton(onPressed: ()async{
           FirebaseAuth mauth=FirebaseAuth.instance;
           if(pswrdController.text==cnfrmPwrdController.text){
             try{
           var cred=   await mauth.createUserWithEmailAndPassword(email: emailController.text, password: pswrdController.text);
           print(cred.user!.uid);
           FirebaseFirestore firestore= FirebaseFirestore.instance;
          await firestore.collection("users").doc(cred.user!.uid).set({
            "name":nameController.text,
            "email": emailController.text,
            "mobileNo":phoneController.text

          });
                print("user data added in firestore") ;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Noteshome()));
               
               
             }catch(e){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error: ${e}")));
             }
           }else{
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error: pswrd not matched")));
           }
         }, child: Text("Register"))



       ],
     ),)

    );

  }
}
