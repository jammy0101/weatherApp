import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text('Discover the weather in your City',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 30
              ),)),
              SizedBox(height: 20,),
              Image(
                fit: BoxFit.cover,
                  image: ExactAssetImage('assets/images/weather.jpg')),
              SizedBox(height: 20,),
              Center(
                child: Text('Get to Know Your Weather maps and radar\n recipitations forcast',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Text('Get Started',style: TextStyle(color: Colors.red),),
                  )
                ),
              ),
           ],
          ),
        ),
      ),
    );
  }
}
