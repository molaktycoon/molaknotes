import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
   const RegisterView({ Key? key }) : super(key: key);
  
  @override
  State<RegisterView> createState() => _RegisterViewState();

}

class _RegisterViewState extends State<RegisterView> {
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
         title:const  Text('Register') ,
         ),
         body: FutureBuilder(
           future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
           ),
           builder: (context,snapshot) {
             switch (snapshot.connectionState){
              
               case ConnectionState.done:
             return Column(
               children: [

                  TextField(
                   controller: _email,
                   enableSuggestions: false,
                   autocorrect: false,
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration(
                   hintText: 'Input your WYGO email here'),
                 ),
                  TextField(
                   controller: _password,
                 
                   obscureText: true,
                   enableSuggestions: false,
                   autocorrect: false,
                   decoration: const InputDecoration(
                     hintText: 'Enter your WYGO password here'
                   ),
                 ),
                  TextButton(
                      
                     onPressed:() async{
                      
                       final email =_email.text;
                       final password = _password.text;
                       try {
                          final userCreditial = await
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                         email: email, 
                         password: password,
                         );
                         print(userCreditial);
                       } on FirebaseAuthException catch (e) {
                         if(e.code == 'weak-password'){
                         print('Password is weak');
                         }else if(e.code=='email-already-in-use'){
                           print('email is in use]');
                         }else if(e.code=='invalid-email'){
                           print('The email is invalid');
                         }
                       }
                      
                     },
                     child: const Text('Click Me'),      
                     ),
               ],
             );
             default:
             return const Text('Loading....');
                 }
             
           }
         ),
     );
   }    
}