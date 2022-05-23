import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:molaknotes/constant/route.dart';

class EmailVericationView extends StatefulWidget {
  const EmailVericationView({Key? key}) : super(key: key);

  @override
  State<EmailVericationView> createState() => _EmailVericationViewState();
}

class _EmailVericationViewState extends State<EmailVericationView> {
  @override
  Widget build(BuildContext context) {
   return   Scaffold(
     appBar: AppBar(
       title: const Text('Verified Email'),
     ),
     body: Column(
         children: [
           const Text("We've sent you an email verifcation, please open to verify your account"),
          const Text("If you haven't received email verifcation yet, press this button below"),
          TextButton (onPressed: () async{
            final user = FirebaseAuth.instance.currentUser;
             await user?.sendEmailVerification();
          },
          child: const Text('send email verification') ),
          TextButton(
            onPressed:() async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false,);
            },
            child: const Text('Restart'),
          )
         ],
       ),
   );

    
  }
}
