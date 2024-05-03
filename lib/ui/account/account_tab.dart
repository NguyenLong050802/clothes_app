// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/sign_in.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                logOut();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Center(
                    child: Text("Sign Out",
                        style: TextStyle(fontSize: 20.0, color: Colors.black))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
