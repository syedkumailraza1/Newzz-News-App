import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  Admin({
    Key? key,
  }) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

FirebaseAuth auth = FirebaseAuth.instance;

Signout() async{
  await auth.signOut();
  Navigator.pop(context);
}

  String? selectedCat;
  List<String> newsCategory = [
    "Entertainment",
    "Sports",
    "Health",
    "Business",
    "Tech"
  ];
  late String? imgUrl;
  String? thumbnailUrl;
  TextEditingController newsTitle = TextEditingController();
  TextEditingController newsSubtitle = TextEditingController();
  TextEditingController newsDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    imgUrl = null; // Initialize imgUrl with null value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {
          Signout();
        })],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Add News",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              // Your existing UI code

              Theme(
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
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                      border: Border.all(
                        color: Colors.blueGrey, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: TextField(
                      controller: newsTitle,
                      decoration: InputDecoration(
                        labelText: 'News Title',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Theme(
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
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                      border: Border.all(
                        color: Colors.blueGrey, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: TextField(
                      controller: newsSubtitle,
                      decoration: InputDecoration(
                        labelText: 'News Subtitle',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Theme(
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
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                      border: Border.all(
                        color: Colors.blueGrey, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: TextField(
                      controller: newsDesc,
                      decoration: InputDecoration(
                        labelText: 'News Description',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Adjust the value as needed
                    border: Border.all(
                      color: Colors.blueGrey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none, // Remove the underline
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10), // Add padding
                    ),
                    value: selectedCat,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCat = newValue;
                      });
                    },
                    hint: Text('Select a category'),
                    items: newsCategory.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  height: 200,
                  width: 300,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: imgUrl!=null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        height: 200, width: 200, fit: BoxFit.fill,
                        imgUrl!),
                    ):
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
                          height: 200, width: 200, fit: BoxFit.fill,
                          ),
                      )
                    
                    ),
                ),

                SizedBox(height: 15,),

                MaterialButton(
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                    ),
                    onPressed: () {
                      selectfile();
                    },
                    child: Text('Select Image')),

                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    minWidth: 200,
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the value as needed
                    ),
                    onPressed: () {
                      addDetails(context);
                    },
                    child: Text('Add News')),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String? uploadImageUrl = await uploadFile(file);
      if (uploadImageUrl != null && uploadImageUrl.isNotEmpty) {
        setState(() {
          imgUrl = uploadImageUrl;
        });
      }
    } else {
      // User canceled the picker
    }
  }

  void addDetails(BuildContext context) async {
    try {
      String title = newsTitle.text.trim();
      String subtitle = newsSubtitle.text.trim();
      String desc = newsDesc.text.trim();
      String? category = selectedCat;

      CollectionReference newsDetailsCollection =
          FirebaseFirestore.instance.collection('newsdetails');

      await newsDetailsCollection.add({
        'title': title,
        'subtitle': subtitle,
        'description': desc,
        'category': category,
        'thumbnail': thumbnailUrl,
        'createdAt': DateTime.now()
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("News added Successfully")));
    } catch (e) {
      print('Error adding news details: $e');
    }
  }

  Future<String?> uploadFile(File file) async {
  try {
    String fileName = file.path.split('/').last;

    Reference storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      String thumbnailUrl = await storageReference.getDownloadURL();
      print('File Uploaded Successfully! Download Url: $thumbnailUrl');

      // Call the updateThumbnailUrl function to update the thumbnailUrl
      updateThumbnailUrl(thumbnailUrl);

      return thumbnailUrl;
    } else {
      print('File Upload Failed');
      return null;
    }
  } catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}


  void updateThumbnailUrl(String? url) {
    setState(() {
      thumbnailUrl = url;
    });
  }
}
