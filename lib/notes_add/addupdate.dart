import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isupdate;
  String? id;
  String title;
  String desc;
  NotesPage({this.id, this.isupdate = false, this.title = "", this.desc = ""});

  TextEditingController titlecontroller = TextEditingController();

  TextEditingController desccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isupdate) {
      titlecontroller.text = title;
      desccontroller.text = desc;
    }

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  hintText: "Enter title here...",
                  label: Text('Title'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: desccontroller,
                maxLines: 3,
                minLines: 2,
                decoration: InputDecoration(
                  hintText: "Enter description here...",
                  label: Text('Description'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [Expanded(child: OutlinedButton(onPressed: ()async{
                  if(titlecontroller.text.isNotEmpty & desccontroller.text.isNotEmpty){
                    if(isupdate && id!= null){
                      await  firestore.collection("notesadd").doc(id).update({
                        "title":titlecontroller.text,
                        "desc":desccontroller.text
                      }

                      );

                    }else{
                      await firestore.collection("notesadd").doc(DateTime.now().microsecondsSinceEpoch.toString()).set({
                        "title":titlecontroller.text,
                        "desc": desccontroller.text,
                        "createdAt":DateTime.now().microsecondsSinceEpoch,
                      });
                    }
                    Navigator.pop(context);
                  }
                }, child: Text(isupdate ?  "Edit notes" :"Add notes"  )
                )
                ),
                  Expanded(child: OutlinedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Cancel')))
                ],


              )
            ]
            )
        )
    );
  }
}
