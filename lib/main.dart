
import 'package:flutter/material.dart';
import 'package:molaknotes/constant/route.dart';
import 'package:molaknotes/services/auth/auth_service.dart';
import 'package:molaknotes/views/login_view.dart';
import 'package:molaknotes/views/register_view.dart';
import 'package:molaknotes/views/verified_email_view.dart';
import 'views/notes_view.dart';

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
        registerRoute: (context) => const RegisterView(),
        mynotesRoute: (context) => const MyNote(),
        verifiedEmailRoute:(context) => const EmailVericationView(),
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
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const MyNote();
              } else {
                return const EmailVericationView();
              }
            } else {
              return const Loginview();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}



