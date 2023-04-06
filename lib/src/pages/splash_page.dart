// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon/src/pages/home_paage.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  late double w, h;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (route) => false);
    });
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        color: Colors.blueAccent,
        child: Center(
          child: SizedBox(
            width: 300,
            height: 250,
            child: Image.asset(
              'assets/icons/pokelogo.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
