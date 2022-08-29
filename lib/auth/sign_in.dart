

import 'package:flutter/material.dart';
import 'package:untitled1/auth/google.dart';

class SignIn extends StatefulWidget{
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_State();

}

class _State extends State<SignIn>{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Google sign in tren",
      home: GoogleSignIn(),
    );
  }


}