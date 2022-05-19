import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:molaknotes/views/login_view.dart';
import 'package:molaknotes/views/register_view.dart';
import 'package:molaknotes/views/verified_email_view.dart';

import 'firebase_options.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Homepage(),
      routes: {
        '/login/': (context) => const Loginview(),
        '/register/':(context) => const RegisterView(),
      },
    ),  );
  
}

 class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
           future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
           ),
           builder: (context,snapshot) {
             switch (snapshot.connectionState){
               case ConnectionState.done:
               final user = FirebaseAuth.instance.currentUser;
              if(user != null){
                if(user.emailVerified){
                  print('Email is Verified');
                }else{
                  return const EmailVericationView();
                }
                }else {
                  return const Loginview();
              }
              return const Text('Done');
              //  if(user?.emailVerified ?? false){
              //    return const Text('Welcome, All DONE');
              //   // print('You are a verified user');
              //  }else{
              //    return const EmailVericationView();
              //   // print('You are not Verified');
              // //  //Navigator.of(context).push(MaterialPageRoute(
              // //builder:(context)=>const EmailVericationView())
              // //  );
              //  }
               
             default:
             return const CircularProgressIndicator();
                 }
             
           },
         );
  }
}

