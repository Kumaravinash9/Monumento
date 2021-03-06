import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newDemoApp/NewsFeed.dart';
import 'package:newDemoApp/bookmark_screen.dart';
import 'package:newDemoApp/explore_screen.dart';
import 'package:newDemoApp/profile_screen.dart';
import 'package:newDemoApp/utils/bookmark_carousel.dart';

import 'utils/popular_carousel.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;
  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  final _key = GlobalKey<ScaffoldState>();

  List<DocumentSnapshot> popMonumentDocs = new List();
  List<Map<String, dynamic>> monumentMapList = new List();

  Future getPopularMonuments() async {
    await Firestore.instance
        .collection('popular_monuments')
        .getDocuments()
        .then((docs) {
      popMonumentDocs = docs.documents;
      for (DocumentSnapshot doc in popMonumentDocs) {
        monumentMapList.add(doc.data);
      }
    });
  }

  List<DocumentSnapshot> bookmarkedMonumentDocs = new List();

  Future getBookmarkedMonuments() async {
    await Firestore.instance
        .collection('bookmarks')
        .where("auth_id", isEqualTo: widget.user.uid)
        .getDocuments()
        .then((docs) {
      bookmarkedMonumentDocs = docs.documents;
    });
  }

  DocumentSnapshot profileSnapshot;
  Future getProfileData() async {
    await Firestore.instance
        .collection('users')
        .where("auth_id", isEqualTo: widget.user.uid)
        .limit(1)
        .getDocuments()
        .then((docs) {
      if (docs != null && docs.documents.length != 0)
        profileSnapshot = docs.documents[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileData().whenComplete(() {
      setState(() {
        print('Profile Data Received!');
      });
    });
    getPopularMonuments().whenComplete(() {
      setState(() {
        print('Popular Monuments Received!');
      });
    });
  }

  void changeScreen(int tabIndex) {
    setState(() {
      _currentTab = tabIndex;
    });
  }

  static const platform = const MethodChannel("monument_detector");

  _navToMonumentDetector() async {
    try {
      await platform.invokeMethod(
          "navMonumentDetector", {"monumentsList": monumentMapList});
    } on PlatformException catch (e) {
      print("Failed to navigate to Monument Detector: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: _currentTab == 1
          ? ExploreScreen(
              user: widget.user,
              monumentList: popMonumentDocs,
            )
          : _currentTab == 3
              ? BookmarkScreen(
                  user: widget.user,
                  monumentList: bookmarkedMonumentDocs,
                )
              : _currentTab == 4
                  ? UserProfilePage(
                      user: widget.user,
                    )
                  : _currentTab == 2
                      ? NewsFeed()
                      : SafeArea(
                          child: (popMonumentDocs.length == 0)
                              ? Center(
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.amber),
                                    ),
                                  ),
                                )
                              : Stack(
                                  children: <Widget>[
                                    ListView(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.0),
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 120.0),
                                          child: Text(
                                            'Monumento',
                                            style: TextStyle(
                                              fontSize: 28.0,
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        PopularMonumentsCarousel(
                                          popMonumentDocs: popMonumentDocs,
                                          user: widget.user,
                                          changeTab: changeScreen,
                                        ),
                                        SizedBox(height: 20.0),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance
                                                .collection('bookmarks')
                                                .where("auth_id",
                                                    isEqualTo: widget.user.uid)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError)
                                                return Center(
                                                  child: Text(
                                                    'Failed to load Bookmarks!',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 22.0,
                                                        color: Colors.grey),
                                                  ),
                                                );
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                  return SizedBox.shrink();
                                                default:
                                                  if (snapshot != null &&
                                                      snapshot.data.documents !=
                                                          null) {
                                                    bookmarkedMonumentDocs =
                                                        snapshot.data.documents;
                                                  }
                                                  return BookmarkCarousel(
                                                    bookmarkedMonumentDocs:
                                                        (snapshot == null ||
                                                                !(snapshot
                                                                    .hasData) ||
                                                                snapshot.data
                                                                        .documents ==
                                                                    null)
                                                            ? bookmarkedMonumentDocs
                                                            : snapshot
                                                                .data.documents,
                                                    changeTab: changeScreen,
                                                  );
                                              }
                                            })
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: FloatingActionButton(
                                            onPressed: () async {
                                              _navToMonumentDetector();
                                            },
                                            backgroundColor: Colors.amber,
                                            child: Icon(Icons.account_balance,
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.amber),
        currentIndex: _currentTab,
        elevation: 10.0,
        selectedItemColor: Colors.amber,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
              color: Colors.grey,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              size: 35.0,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
              size: 30.0,
              color: Colors.grey,
            ),
            label: 'Popular',
            activeIcon: Icon(
              Icons.apps,
              size: 35.0,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.web,
              size: 30.0,
              color: Colors.grey,
            ),
            label: 'Feed',
            activeIcon: Icon(
              Icons.web,
              size: 35.0,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              size: 30.0,
              color: Colors.grey,
            ),
            label: 'Bookmarks',
            activeIcon: Icon(
              Icons.bookmark,
              size: 35.0,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30.0,
              color: Colors.grey,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person_outline,
              size: 35.0,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
