import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newzz/View/readnews.dart';

class filteredDataPage extends StatefulWidget {
  final List<Map<String, dynamic>> filteredData;
  final String fieldName;
  const filteredDataPage(
      {super.key, required this.filteredData, required this.fieldName});

  @override
  State<filteredDataPage> createState() => _filteredDataPageState();
}

class _filteredDataPageState extends State<filteredDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.fieldName),
          centerTitle: true,
        ),
        body: widget.filteredData.isEmpty
            ? Center(child: Text("No News In This Category"))
            : ListView.builder(
                itemCount: widget.filteredData.length,
                itemBuilder: (context, index) {
                  Timestamp timestamp = widget.filteredData[index]['createdAt'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedTime = DateFormat('dd-MM-yyyy')
                      .format(dateTime); // Use capital 'MM' for month

                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ReadNews(
                                      thumbnailUrl: widget.filteredData[index]
                                          ['thumbnail'],
                                      title: widget.filteredData[index]
                                          ["title"],
                                      Desc: widget.filteredData[index]
                                          ["description"],
                                      date: formattedTime,
                                      catName: widget.filteredData[index]
                                          ["category"],
                                    )));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Ensure children are aligned to the start
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.network(
                                  widget.filteredData[index]['thumbnail'],
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.filteredData[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.filteredData[index]['subtitle'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.filteredData[index]['category'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      formattedTime,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
