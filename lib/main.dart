import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:molaknotes/constant/route.dart';
import 'package:molaknotes/views/login_view.dart';
import 'package:molaknotes/views/register_view.dart';
import 'package:molaknotes/views/verified_email_view.dart';
import 'firebase_options.dart' ;



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
        loginRoute: (context) => const Loginview(),
        registerRoute:(context) => const RegisterView(),
        mynotesRoute:(context) => const MyNote(),
      },
    ),  
    );
  
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
                  return const MyNote();
                }else{
                  return const EmailVericationView();
                }
                }else {
                  return const Loginview();
              }
                             
             default:
             return const CircularProgressIndicator();
                 }
             
           },
         );
  }
}

enum MenuAction {logout}

class MyNote extends StatefulWidget {
  const MyNote({Key? key}) : super(key: key);

  @override
  State<MyNote> createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
            switch (value) {
              case MenuAction.logout:
              final shouldlogout = await showLogOutDialog(context);
              if(shouldlogout){
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false,);
              }
                
                break;
              default:
            }
            // devtools.log(value.toString());
            },
            itemBuilder: (context){
              return [
                const PopupMenuItem<MenuAction>(
                value:MenuAction.logout, 
                child:Text ('Logout')
                )
              ];
              
            },)
        ],
        title: const Text('Main UI'),
      ),
    body: const Text('Hello World'),
    );
    
  }
}

Future<bool>showLogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder:(context){
      return AlertDialog (
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out'),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);
          },child: const Text('Cancle'),),
          TextButton(onPressed: () {
            Navigator.of(context).pop(true);},
            child: const Text('Log Out'), ),
        ],
      );
  } 
  ).then((value) => value ?? false);
}