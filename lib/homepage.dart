import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
 FirebaseFirestore firestore= FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(stream: firestore.collection("notes").snapshots(), builder: (_,snapshots){
        if(snapshots.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );

        }
        if(snapshots.hasError){
          return Center(
            child: Text("error: ${snapshots.error}"),

          );

        }
        if(snapshots.hasData && snapshots.data !=null){
          return snapshots.data!.docs.isNotEmpty?ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (c,index){
            return ListTile(
              title: Text(snapshots.data!.docs[index].data()["title"]),
            );
          }):Center(child: Text("no data got"),);
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        firestore.collection("notes").doc().set({
          "title": "title",
          "desc":"desc",
          
        });

      },child: Icon(Icons.add),),
    );

  }

}
