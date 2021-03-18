import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class RecentVisit extends StatefulWidget {
  const RecentVisit({Key key}) : super(key: key);

  @override
  _RecentVisitState createState() => _RecentVisitState();
}

class _RecentVisitState extends State<RecentVisit> {
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuid();
  }

  _delect(String id) async {
    await Firestore.instance
        .collection("bookmarks")
        .document(id)
        .delete()
        .whenComplete(() => print("documents delected"));
  }

  _delectall() async {
    String collection = "bookmarks";
    QuerySnapshot query = await Firestore.instance
        .collection(collection)
        .where("auth_id", isEqualTo: uid)
        .getDocuments();
    query.documents.forEach((element) {
      element.reference.delete();
    });
  }

  getuid() async {
    final id = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = id.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          'Visits',
          style: kLabelStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            tooltip: "Add photos",
            splashColor: Colors.white,
            hoverColor: Colors.white,
            splashRadius: 30,
            icon: Icon(
              Icons.clear,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () async {
              await _delectall();
            },
          ),
          SizedBox(width: 5)
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('bookmarks')
                  .where("auth_id", isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                if (snapshot.hasData == null)
                  return Center(child: Text("Oops !No Bookmark added yet"));

                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: UniqueKey(),
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 6),
                            elevation: 10,
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: 8, top: 4, bottom: 4),
                              title: Text(
                                  "${snapshot.data.documents[index]['name']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              leading: Icon(Icons.account_balance,
                                  color: Colors.amber, size: 26),
                              dense: true,
                              trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await _delect(snapshot.data.documents[index]
                                        .reference.documentID);
                                  }),
                            ),
                          ));
                    });
              })),
    );
  }
}
