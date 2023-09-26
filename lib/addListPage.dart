import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/alertdialogue.dart';

class AddList extends StatefulWidget{

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {

  int _currentStep=0;
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {


    final _currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    final firestore = FirebaseFirestore.instance.collection('Tasks').doc(_currentUserUid.toString()).collection('mytasks');

    final titleController = TextEditingController();
    final descrController = TextEditingController();

    List<Step> stepList = [
      Step(isActive: _currentStep >= 0,title: Text('Task Title'),subtitle: Text(title), content: TextField(
        onChanged: (value){
          title=value;
        },
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Title"
        ),
      ),),
      Step(isActive: _currentStep >= 1,title: Text('Task Description'),subtitle: Text(description), content: TextField(
        onChanged: (value){
          description=value;
        },
        controller: descrController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter Description"
        ),
      ),),
      Step(isActive: _currentStep >= 2,title: Text('Confirm'), content: Text("Add Task ?")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo Item"),
      ),
      body: Stepper(
        onStepContinue: (){
          setState(() {
            if(_currentStep>=stepList.length-1){
              String timeid=DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(timeid).set({
                'time':timeid,
                'title':title,
                'Description':description
              });
              Navigator.pop(context);
              //FireStore Instruction
              //reached last
            }
            else if(_currentStep==0){
              if(titleController.text.isEmpty){

                const snackBar = SnackBar(
                  content: Text('Enter Title'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              else{
                setState(() {
                  _currentStep++;
                });
              }
            }
            else if(_currentStep==1){
              if(descrController.text.isEmpty){
                const snackBar = SnackBar(
                  content: Text('Enter Description'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              else{
                setState(() {
                  _currentStep++;
                });
              }
            }
          });
        },
        onStepCancel: (){
          setState(() {
            if(_currentStep==0) {
              AlertDialogueBox.showAlertDialog(context, content: "Would you like to Discard this task?", title:"Discard ?", no: "No", yes: "Yes", yesbutt: (){Navigator.popUntil(context,(route)=> route.isFirst);});
            }
            else{
              if(_currentStep==2)
                description="";
              else
                title="";
              _currentStep--;
            }
          });
        },
        currentStep: _currentStep,
        steps: stepList,
      ),
    );
  }

}