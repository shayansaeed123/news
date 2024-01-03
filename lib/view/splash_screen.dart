import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/utils/routes/routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, RoutesNames.home,(route) => false,);
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/splash_pic.jpg",
          fit: BoxFit.cover,
          height: height * .5,
          ),
          SizedBox(height: height* 0.05,),
          Text("Top Headlines" , style: GoogleFonts.anton(letterSpacing: .6,fontSize: 30,color: Colors.grey.shade500),),
          SizedBox(height: height * .07,),
          SpinKitWave(
            color: Colors.black,
            size: 50,
          )
        ],
      ),
    );
  }
}
