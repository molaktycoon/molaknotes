import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;


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
     return  Scaffold(
       appBar: AppBar(
         title:const Text('Register'),
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
                            final userCreditial = await
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                           email: email, 
                           password: password,
                           );
                           devtools.log(userCreditial.toString());
                         } on FirebaseAuthException catch (e) {
                           if(e.code == 'weak-password'){
                           devtools.log('Password is weak');
                           }else if(e.code=='email-already-in-use'){
                             devtools.log('email is in use]');
                           }else if(e.code=='invalid-email'){
                             devtools.log('The email is invalid');
                           }
                         }
                        
                       },
                       child: const Text('Click Me'),      
                       ),
                       TextButton(
                         onPressed:(){
                        Navigator.of(context).pushNamedAndRemoveUntil
                        ('/login/', (route) => false);                          
                       },
                       child: const Text('Already Registered, Login here'),
                       )
                 ],
               ),
     );
   }    
}