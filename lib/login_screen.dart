import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController),
            SizedBox(height: 20),
            TextField(controller: passController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  var data =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passController.text,
                  );

                  if (data.user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("invalid data")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Login Success ${data.user!.email}")),
                    );
                  }
                } catch (e) {
                  print(e.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("invalid data, please try again")),
                  );
                }
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  print("no user");
                } else {
                  print(
                      "${FirebaseAuth.instance.currentUser!.email} user found");
                }
              },
              child: Text("Check login"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var data = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passController.text,
                  );

                  if (data.user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("invalid data")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("Created Successfully ${data.user!.email}")),
                    );
                  }
                } catch (e) {
                  print(e.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("invalid data, please try again")),
                  );
                }
              },
              child: Text("Create Account"),
            ),
            ElevatedButton(
              onPressed: () async {
                var data = await signInWithGoogle();
                print(data.user!.email);
              },
              child: Text("Sign in with google"),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
