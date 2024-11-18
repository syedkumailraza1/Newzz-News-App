import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  RemoteMessage? message;

  @override
  void initState() {
    super.initState();
    // Remove the initialization of message from initState
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the message from the route arguments in the build method
    message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Column(
        children: [
          // Display the notification message
          if (message != null)
            ListTile(
              title: Text(message?.notification?.title ?? 'No Title Available'),
              subtitle: Text(message?.notification?.body ?? 'No Body Available'),
            ),
        ],
      ),
    );
  }
}
