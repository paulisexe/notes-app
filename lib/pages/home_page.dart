

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/pages/notes_page.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google SignIn"),
        ),
        body: _user != null ? _userInfo() : _googleSignInButton()
    );
  }

  Widget _googleSignInButton() {
    return Center(child: SizedBox(
        height: 50,
        child: SignInButton(Buttons.google, text: "sign up with Google",
          onPressed: _handleGooglesignIn,
        ),
    ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_user!.photoURL!),
            ),
          ),
        ),
          Text(_user!.email!),
          Text(_user!.displayName ?? ""),
          MaterialButton(
            color: Colors.red,
            child: const Text("sign out"),
            onPressed: _auth.signOut,
          ),
          MaterialButton(
            color: Colors.red,
            child: const Text("continue"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NotesPage()),
              );
            }
          ),
        ],

      ),
    );
  }



           














  void _handleGooglesignIn() {
    try {
      GoogleAuthProvider _googleAuthprovider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthprovider);
    } catch (error) {
      print(error) ;
      }
    }
  }
