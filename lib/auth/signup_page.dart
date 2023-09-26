import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Texfield.dart';
import 'package:todo/auth/Login_Page.dart';
import 'package:todo/home.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();

  bool hidepass=true;

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final namecontroller = TextEditingController();

  bool isLoading=false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final fireref = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  MyTextField(
                      prefixicon: Icon(Icons.person),
                      validatormsg: "Username is Empty",
                      keytype: TextInputType.text,
                      controller: namecontroller,
                      hinttext: "Enter Username"
                  ),
                  SizedBox(height: 15,),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      child: Text("Already have an Account?",style: TextStyle(fontSize: 16),
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
                  _auth.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
                    setState(() {isLoading=false;});

                    final snackBar = SnackBar(
                      content: Text("Account Created Succesfully"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    final timeid=DateTime.now().millisecondsSinceEpoch;

                    fireref.doc(timeid.toString()).set({
                      'email':emailcontroller,
                      'name':namecontroller,
                      'id':timeid.toString(),
                    });

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
                child: Center(child: isLoading?CircularProgressIndicator(color: Colors.white,):Text("SignUp",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
