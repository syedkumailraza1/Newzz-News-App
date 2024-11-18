

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:newzz/View/catscreens/business.dart';
import 'package:newzz/View/catscreens/entertainment.dart';
import 'package:newzz/View/catscreens/health.dart';
import 'package:newzz/View/catscreens/sports.dart';
import 'package:newzz/View/catscreens/tech.dart';
import 'package:newzz/View/filtereddatapage.dart';
import 'package:newzz/View/notoficationpage.dart';
import 'package:newzz/View/readnews.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void>filterandNavigate(BuildContext context,String fieldName) async{
    CollectionReference  collectionRef= FirebaseFirestore.instance.collection('newsdetails');

    QuerySnapshot filteredData = await collectionRef.where('category', isEqualTo:fieldName).get();

    List<Map<String,dynamic>> filteredDocData = filteredData.docs.map((doc) => doc.data() as Map<String,dynamic>).toList();

    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    filteredDataPage(filteredData: filteredDocData, fieldName: fieldName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Icon(Icons.person, size: 150, color: Colors.white),
            ),
            ListTile(
              title: Text('Entertainment'),
              onTap: () {
               filterandNavigate(context, 'Entertainment');
              },
            ),
            ListTile(
              title: Text('Sports'),
              onTap: () =>
             filterandNavigate(context, 'Sports')
            ),
            ListTile(
              title: Text('Health'),
              onTap: () =>
               filterandNavigate(context, 'Health')

            ),
            ListTile(
              title: Text('Business'),
              onTap: () =>
               filterandNavigate(context, 'Business')
            ),
            ListTile(
              title: Text('Tech'),
              onTap: () =>
               filterandNavigate(context, 'Tech')
            ),
            Divider(),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Newzz"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.zero,
            child: CarouselSlider(
              items: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,
                    'assets/images/n1.webp')),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,
                    'assets/images/n2.webp')),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    height: 200,width: MediaQuery.of(context).size.width, fit: BoxFit.fill,
                    'assets/images/n3.avif')),
              ],
              options: CarouselOptions(
                height: 250,
                aspectRatio: 16 / 8,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text("Trending Now!",style: TextStyle(color: Colors.blueGrey, fontSize: 20,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
          // Center(child: Text("data"))

          SizedBox(height: 20),
          
            trendingNews(),
        ],
      ),
    );
  }
  
 Widget trendingNews() {
  return Expanded(
    child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('newsdetails').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator());
        } else if (streamSnapshot.hasError) {
          // Show an error message if there is an error
          return Center(child: Text('Error: ${streamSnapshot.error}'));
        } else if (!streamSnapshot.hasData || streamSnapshot.data!.docs.isEmpty) {
          // Show a message if there is no data available
          return Center(child: Text('No data available'));
        } else {
          // Display the list of news items
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

              Timestamp timestamp = documentSnapshot['createdAt'];
              DateTime dateTime = timestamp.toDate();
              String formattedTime = DateFormat('dd-MM-yyyy').format(dateTime); // Use capital 'MM' for month

              return Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> ReadNews(
                      thumbnailUrl: documentSnapshot['thumbnail'],
                      title: documentSnapshot["title"],
                      Desc: documentSnapshot["description"],
                      date: formattedTime,
                      catName: documentSnapshot["category"],
                    ) ));
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Ensure children are aligned to the start
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start, // Ensure children are aligned to the start
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                  documentSnapshot['thumbnail'],
                                  width: 110, // Set a fixed width for the thumbnail
                                  height: 90, // Set a fixed height for the thumbnail
                                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        documentSnapshot['title'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      documentSnapshot['subtitle'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.grey.shade600
                                      ),
                                    ),
                                    SizedBox(height: 8),

                                    Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documentSnapshot['category'],
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(formattedTime, style: TextStyle( fontSize: 12),),
                            ],
                          ),
                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    ),
  );
}



}