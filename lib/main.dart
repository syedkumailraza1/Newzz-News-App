import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:newzz/View/notoficationpage.dart';
import 'package:newzz/auth/login.dart';
import 'package:newzz/View/admin.dart';
import 'package:newzz/View/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newzz/View/readnews.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCkulaAzFDCHglxMh0xLwNTajPshgmD1lE', 
      appId: '1:637738306129:android:2d2c951ff6f0a1deb00670', 
      messagingSenderId: '637738306129', 
      projectId: 'newzz-6a47e',
      storageBucket: 'gs://newzz-6a47e.appspot.com'
      )
  ) : await Firebase.initializeApp();// Initialize Firebase
  

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newzz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
      navigatorKey: navigatorkey,
      routes: {
        '/notification':(context) => const NotificationScreen(),
        },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator if the authentication state is still loading
          return CircularProgressIndicator();
        } else {
          // Check if the user is logged in
          if (snapshot.hasData) {
            // User is logged in
            final User? user = FirebaseAuth.instance.currentUser;
            // Check if the logged-in user is an admin
            if (user != null && user.email == "admin@gmail.com") {
              // Redirect to admin screen
              return Admin();
            } else {
              // Redirect to home screen
              return Home();
            }
          } else {
            // User is not logged in, redirect to login screen
            return LoginScreen();
          }
        }
      },
    );
  }
}
