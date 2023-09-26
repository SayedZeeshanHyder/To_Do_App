import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/signup_page.dart';

import '../Texfield.dart';
import '../home.dart';

class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  bool hidepass=true;

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final namecontroller = TextEditingController();

  bool isLoading=false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log In",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  MyTextField(
                      prefixicon: Icon(Icons.email),
                      validatormsg: "Email is Empty",
                      keytype: TextInputType.emailAddress,
                      controller: emailcontroller,
                      hinttext: "Enter Email"
                  ),
                  SizedBox(height: 15,),
                  MyTextField(
                    suffixicon: InkWell(
                      onTap: (){
                        setState(() {hidepass=!hidepass;});
                      },
                      child: hidepass?Icon(Icons.visibility_off):Icon(Icons.visibility),
                    ),
                    obscuretext: hidepass,
                    prefixicon: Icon(Icons.lock),
                    validatormsg: "Password is Empty",
                    keytype: TextInputType.text,
                    controller: passwordcontroller,
                    hinttext: "Enter Password",
                  ),
                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                        },
                        child: Text("Dont have an Account?",style: TextStyle(fontSize: 16),
                        ),
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                if(_formkey.currentState!.validate()){
                  setState(() {isLoading=true;});
                  _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
                    setState(() {isLoading=false;});

                    final snackBar = SnackBar(
                      content: Text("Signed In Succesfully Using ${_auth.currentUser!.email}"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  }).onError((error, stackTrace){
                    setState(() {isLoading=false;});
                    final snackBar = SnackBar(
                      content: Text(error.toString()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }
              },
              child: Container(
                height:50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Center(child: isLoading?CircularProgressIndicator(color: Colors.white,):Text("Login",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}