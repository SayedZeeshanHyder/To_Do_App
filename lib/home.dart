import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/addListPage.dart';
import 'package:todo/alertdialogue.dart';
import 'package:todo/taskdetailspage.dart';

import 'auth/Login_Page.dart';


class Home extends StatefulWidget{

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  final _currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  bool light=true;

  @override
  Widget build(BuildContext context) {

    final firestore = FirebaseFirestore.instance.collection('Tasks').doc(_currentUserUid.toString()).collection('mytasks').snapshots();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddList()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Home page"),
        actions: [
          IconButton(onPressed: (){
            if(light){
              Get.changeTheme(ThemeData.dark());
            }
            else{
              Get.changeTheme(ThemeData.light());
            }
            setState(() {light=!light;});
          }, icon: light ? Icon(Icons.light_mode):Icon(Icons.dark_mode)),
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },icon: Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
        stream: firestore,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.data!.docs.length==0){
            return Center(
                child: Text("No Task Added"),
            );
          }
          else{
            final doc=snapshot.data!.docs;
            return ListView.builder(itemCount: doc.length,itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Theme.of(context).cardColor,
                      elevation: 6,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskDetailsPage(title: doc[index]['title'], description: doc[index]['Description'], id: doc[index]['time'])));
                        },
                        title: Text("Task : "+doc[index]['title'],style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text("Description : "+doc[index]['Description'],overflow: TextOverflow.ellipsis,),
                        trailing: InkWell(
                            onTap: (){
                              AlertDialogueBox.showAlertDialog(context, content: "Are You Sure you want to Delete This Task ?", title:"Delete Task", no: "No", yes: "Yes", yesbutt: (){
                                FirebaseFirestore.instance.collection('Tasks').doc(_currentUserUid).collection('mytasks').doc(doc[index]['time']).delete();
                                Navigator.pop(context);
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }
        },
      ),
    );
  }
}