import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/splash/splashservice.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices services=SplashServices();

  @override
  void initState() {
    super.initState();
    services.splash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/tick.json',repeat: true),
            Text("ToDo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
          ]
        ),
      ),
    );
  }
}