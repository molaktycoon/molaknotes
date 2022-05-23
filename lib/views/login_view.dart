import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:molaknotes/constant/route.dart';

import '../utilities/show_error_dialog.dart';

class Loginview extends StatefulWidget {
  const Loginview({Key? key}) : super(key: key);

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    //this the user name and password
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Input your WYGO email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
                hintText: 'Enter your WYGO password here'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.green),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  mynotesRoute,
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                 await showErrorDialog(context, 'User not found');
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(context, 'Wrong Password');          
                }else {
                  await showErrorDialog(context, 'Error: ${e.code}', );
                }
              }catch (e){
                await showErrorDialog(context, e.toString(),);
              }
            },
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Don't have account? Register here"),
          )
        ],
      ),
    );
  }
}
