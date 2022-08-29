import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart' as sign_in;


final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
final sign_in.GoogleSignIn _googleSignIn =  sign_in.GoogleSignIn();

class GoogleSignIn extends StatefulWidget{
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_State();

}

class _State extends State<GoogleSignIn>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.add_box_rounded),
            onPressed: () {
              signup(context);
            },
          )
        ),
      ),
    );
  }

  Future<void>signup(BuildContext context) async{
    final sign_in.GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if(googleSignInAccount!=null){
      final sign_in.GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final auth.AuthCredential authCredential =
      auth.GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      auth.UserCredential userCredential = await _firebaseAuth.signInWithCredential(authCredential);
      auth.User? user = userCredential.user;
      if(user!=null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignOut()));
      }
    }
  }

}

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                signout(context);
              },
            )
        ),
      ),
    );
  }

  void signout(BuildContext context) {
    _googleSignIn.signOut().then((user){
      if(user==null){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GoogleSignIn()));
      }
    });
  }

}