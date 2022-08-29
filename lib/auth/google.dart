import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart' as sign_in;

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

}

final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

Future<void>signup(BuildContext context) async{
  final sign_in.GoogleSignIn googleSignIn =  sign_in.GoogleSignIn();
  final sign_in.GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
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
           context, MaterialPageRoute(builder: (context) => HomePage()));
     }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Tren"),
        ),
        body: const Center(child:Text('Home page'),)
    );
  }
}