import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});
  

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Enter Your Email",style: TextStyle(color: Colors.blueGrey,fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Theme(
                      data: ThemeData(
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor:
                              Colors.blueGrey, // Set cursor color for selected text
                          selectionColor:
                              Colors.blueGrey.withOpacity(0.3), // Set selection color
                          selectionHandleColor:
                              Colors.blueGrey, // Set selection handle color
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10.0), // Adjust the value as needed
                          border: Border.all(
                            color: Colors.blueGrey, // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
          ),
          SizedBox(height: 20,),
          MaterialButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the value as needed
                ),
                onPressed: () => resetPass(),
                child: Text('Submit')),
        ],
      ),

    );
  } 
  
  Future resetPass() async {
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
     print("Password reset email sent successfully.");
   } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      // Handle invalid email exception
      print('Invalid email format.');
    } else if (e.code == 'user-not-found') {
      // Handle user not found exception
      print('User not found.');
    } else {
      // Handle other FirebaseAuthException
      print('Failed to send password reset email: ${e.message}');
    }
  } catch (e) {
    // Handle generic exception
    print('Failed to send password reset email: $e');
  }
  }
}