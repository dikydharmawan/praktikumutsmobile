import 'package:flutter/material.dart';
import 'register_login/RegisterPage.dart';
import 'register_login/LoginPage.dart';
import 'register_login/ProfilPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login/Register Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profil' : (context)=> ProfilePage(),
      },
    );
  }
}
