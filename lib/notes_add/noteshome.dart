import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasenotes/notes_add/addupdate.dart';
import 'package:flutter/material.dart';

class Noteshome extends StatelessWidget {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(stream: firestore.collection("notesadd").snapshots(), builder: (_,snapshots){

        if(snapshots.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),

          );
        }
        if(snapshots.hasError){
          return Center(
            child: Text("error : ${snapshots.error}"),
          );
        }
        if(snapshots.hasData && snapshots.data != null){
          return snapshots.data!.docs.isNotEmpty? ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (_,index){
             var  docs=  snapshots.data!.docs[index];
             var finalData= docs.data();
             return ListTile(
               title: Text(finalData["title"]),
               subtitle: Text(finalData["desc"]),
               trailing: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   IconButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=>NotesPage(id: docs.id,
                     title: finalData["title"],
                       desc: finalData["desc"],
                       isupdate: true,
                     )));
                   }, icon: Icon(Icons.edit,color: Colors.blue,)),
                   IconButton(onPressed: ()async{
                     await firestore.collection("notesadd").doc(docs.id).delete();
                   }, icon: Icon(Icons.delete,color: Colors.red,))

                 ],
               ),
             );


          }):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("no notes"),


              ),
              ElevatedButton(

                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>NotesPage()));
              }, child: Text("Add notes"))
            ],
          );
        }
        return Container();
      }) ,
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>NotesPage()));
      },child: Icon(Icons.add_circle_outlined),),
    );
  }
}
