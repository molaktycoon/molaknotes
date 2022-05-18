
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
     return Scaffold(
       appBar: AppBar(
         title:const  Text('Home Page') ,
         ),
         body: FutureBuilder(
           future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
           ),
           builder: (context,snapshot) {
             switch (snapshot.connectionState){
               case ConnectionState.done:
               final user = FirebaseAuth.instance.currentUser;
               if(user?.emailVerified ?? false){
                 print('You are a verified user');
               }else{
                 print('You are not Verified');
               }
             return const Text('Welcome, All DONE');
             default:
             return const Text('Loading....');
                 }
             
           },
         ),
    );
  }
}
