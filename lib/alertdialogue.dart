import 'package:flutter/material.dart';

class AlertDialogueBox
{
  static showAlertDialog(BuildContext context,{required yesbutt,required String content,required String title,required String no,required String yes,}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(no),
      onPressed: (){Navigator.pop(context);}
    );
    Widget continueButton = TextButton(
      child: Text(yes),
      onPressed:yesbutt,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}