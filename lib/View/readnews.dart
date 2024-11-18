import 'package:flutter/material.dart';

class ReadNews extends StatefulWidget {
  String thumbnailUrl;
  String  title;
  String Desc;
  String catName;
  String date;
  ReadNews({
    super.key, 
    required this.thumbnailUrl, 
    required this.title,  
    required this.Desc,  
    required this.catName,  
    required this.date
    });

  @override
  State<ReadNews> createState() => _ReadNewsState();
}

class _ReadNewsState extends State<ReadNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,
            widget.thumbnailUrl),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.catName,style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),),
                  Text(widget.date,style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.Desc,
                style: TextStyle(fontSize: 20)),
            )
        ]
        ),
    );
  }
}