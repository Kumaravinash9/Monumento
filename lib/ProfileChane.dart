import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newDemoApp/utils/bottom.dart';

class Imagey extends StatefulWidget {
  @override
  _ImageyState createState() => _ImageyState();
}

class _ImageyState extends State<Imagey> {
  String uid;
  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    final auth = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = auth.uid;
    });
  }

  AsyncSnapshot snapshot;
  Future getImage(int i) async {
    final profileSnapshot =
        await Firestore.instance.collection('users').document(uid).get();

    if (i == 0) {
      if (profileSnapshot.data['prof_pic'] != null ||
          profileSnapshot.data['prof_pic'].length >= 2) {
        QuerySnapshot query = await Firestore.instance
            .collection('users')
            .where("auth_id", isEqualTo: profileSnapshot.data['auth_id'])
            .limit(1)
            .getDocuments();
        query.documents[0].reference.updateData({'prof_pic': ""}).then(
            (value) => {print("successfully Updated")});
      }
      return;
    }

    var pickedFile = null;

    if (i == 1)
      pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    else
      pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File _image = File(pickedFile.path);
      StorageTaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child("${profileSnapshot.data['auth_id']}/profile")
          .child("${profileSnapshot.data['name']}.jpeg")
          .putFile(_image)
          .onComplete;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      String url = downloadUrl;
      print(url);
      QuerySnapshot query = await Firestore.instance
          .collection('users')
          .where("auth_id", isEqualTo: profileSnapshot.data['auth_id'])
          .limit(1)
          .getDocuments();
      print(query.documents[0].data);
      query.documents[0].reference
          .updateData({'prof_pic': url})
          .then((value) => {print("successfully updated")})
          .catchError((err) => {print(err.toString())});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: <Widget>[
          Card(
            color: Colors.black,
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.only(top: 40, bottom: 15),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 10, left: 0, right: 0, bottom: 0),
                width: double.infinity,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      padding: const EdgeInsets.only(left: 15),
                      tooltip: "Back",
                      color: Colors.white,
                      splashColor: Colors.white,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text("Profile Photo",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    IconButton(
                        icon: Icon(Icons.edit),
                        padding: const EdgeInsets.only(right: 15),
                        color: Colors.white,
                        tooltip: "Edit",
                        splashColor: Colors.white,
                        onPressed: () async {
                          await showBottom(context, getImage);
                        }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .19),
          Container(
              width: double.infinity,
              height: 400,
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .document(uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    return Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: snapshot.data['prof_pic'] != ''
                              ? NetworkImage(
                                  snapshot.data['prof_pic'],
                                )
                              : AssetImage('assets/explore.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  })),
        ]));
  }
}
