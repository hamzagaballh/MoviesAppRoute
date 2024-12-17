import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/Spalsh_image.dart';
import 'package:movie_app/screens/bottom_nav.dart/bottom_nav_screen.dart';
import 'package:movie_app/screens/login_signup/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(BottomNavScreen.routeName);
      }
    });
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splash), fit: BoxFit.fill)),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
