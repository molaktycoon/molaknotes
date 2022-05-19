import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          const Text('Please verified your Email'),
          TextButton (onPressed: () async{
            final user = FirebaseAuth.instance.currentUser;
             await user?.sendEmailVerification();
          },
          child: const Text('send email verification') )
         ],
       ),
   );

    
  }
}
