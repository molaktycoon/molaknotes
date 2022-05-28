import 'package:molaknotes/services/auth/auth_user.dart';
import 'package:molaknotes/services/auth/auth_provider.dart';
import 'package:molaknotes/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth,FirebaseAuthException;
      

      class FirebaseAuthProvider implements AuthProvider{
        @override
        Future<AuthUser> createUser({
          required String email, 
          required String password,
          }) { 
          try{
            FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,);
          }on FirebaseAuthException catch (e){

          }catch (e){}
        }
      
        @override
      
        AuthUser? get currentUser {
          final user = FirebaseAuth.instance.currentUser;
          if(user != null){
            return AuthUser.fromFirebaseUser(user);
          }else{
            return null;
          }
        }
      
        @override
        Future<AuthUser> logIn({required String email, required String password}) {
          // TODO: implement logIn
          throw UnimplementedError();
        }
      
        @override
        Future<void> logOut() {
          // TODO: implement logOut
          throw UnimplementedError();
        }
      
        @override
        Future<void> sendEmailVerification() {
          // TODO: implement sendEmailVerification
          throw UnimplementedError();
        }
        
        
      }