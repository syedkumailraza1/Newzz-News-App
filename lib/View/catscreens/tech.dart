import 'package:flutter/material.dart';

class Tech extends StatefulWidget {
  const Tech({super.key});

  @override
  State<Tech> createState() => _TechState();
}

class _TechState extends State<Tech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tech"),
      ),
    );
  }
}