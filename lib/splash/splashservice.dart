import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/Login_Page.dart';
import 'package:todo/home.dart';

class SplashServices{

  void splash(BuildContext context){
    FirebaseAuth _auth = FirebaseAuth.instance;
    if(_auth.currentUser!=null){
      Timer(Duration(seconds: 4),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      });
    }
    else{
      Timer(Duration(seconds: 4),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      });
    }
  }

}