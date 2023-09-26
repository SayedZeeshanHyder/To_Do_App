import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget{

  final title,description,id;
  TaskDetailsPage({required this.title,required this.description ,required this.id}){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task Id : $id",style: TextStyle(fontSize: 23),),
                  SizedBox(height: 10,),
                  Text("Description : $description",maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 23),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}