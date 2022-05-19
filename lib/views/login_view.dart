

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class Loginview extends StatefulWidget {
  const Loginview({ Key? key }) : super(key: key);

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
                           final userCreditial = await FirebaseAuth.instance.
                         signInWithEmailAndPassword(
                             email: email, 
                             password: password,
                           );
                           print(userCreditial);
                           
                         } on FirebaseAuthException catch (e) {
                           if (e.code == 'user-not-found') {
                             print('User not found');
                           } else if(e.code == 'wrong-passord'){
                             print('Wrong Password');
                             print(e.code);
                           }
                           
                          
                         }
                        
                       },
                       
                       child: const Text('Click Me'),      
                       ),
                       TextButton(
                         onPressed: () {
                           Navigator.of(context).pushNamedAndRemoveUntil(
                             '/register/', (route) => false);
                         },
                         child: const Text('Not registered yet? Register here!'),
                       )
                 ],
               ),
     );
}
}