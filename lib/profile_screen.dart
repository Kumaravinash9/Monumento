import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newDemoApp/View.dart';
import 'package:newDemoApp/utils/Drawer.dart';

import 'ProfileChane.dart';
import 'constants.dart';

class UserProfilePage extends StatefulWidget {
  final FirebaseUser user;

  UserProfilePage({this.user});
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String _bio =
      "\"Hi, I am a vagabond and love to visit different monuments.\"";
  final _key = GlobalKey<ScaffoldState>();

  Widget _buildCoverImage(Size screenSize, BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height / 2.6,
          color: Colors.amber,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                'Monumento',
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(AsyncSnapshot<dynamic> profileSnapshot) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(new MaterialPageRoute(builder: (_) => Imagey())),
        child: Hero(
          tag: "Profile",
          child: Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: profileSnapshot.data['prof_pic'] != ''
                    ? NetworkImage(profileSnapshot.data['prof_pic'])
                    : AssetImage('assets/explore.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: 10.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullName(AsyncSnapshot<dynamic> profileSnapshot) {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      profileSnapshot.data["name"] ?? "Monumento User", //_fullName
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(
      BuildContext context, AsyncSnapshot<dynamic> profileSnapshot) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        profileSnapshot.data["status"] == ''
            ? 'Monumento-nian'
            : profileSnapshot.data["status"],
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Last Visited:",
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Monumento",
          style: kLabelStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Add photos",
            splashColor: Colors.white,
            hoverColor: Colors.white,
            splashRadius: 30,
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 25,
            ),
            onPressed: null,
          ),
          SizedBox(width: 5)
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(widget.user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            print(widget.user.uid);
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData)
              return Center(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
              );
            print(snapshot.data['name']);
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        color: Colors.amber,
                        child: Column(children: [
                          SizedBox(height: screenSize.height / 10),
                          _buildProfileImage(snapshot),
                          _buildFullName(snapshot),
                          _buildStatus(context, snapshot),
                        ])),
                    //_buildStatContainer(),
                    _buildBio(context),
                    _buildSeparator(screenSize),
                    SizedBox(height: 8.0),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 300,
                      child: StreamBuilder(
                          stream: Firestore.instance
                              .collection("posts")
                              .where("auth_id", isEqualTo: widget.user.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Center(child: CircularProgressIndicator());
                            if (snapshot.hasError) {
                              print(snapshot.hasError);
                              return Center(child: Text("Nothing posts yet"));
                            }
                            if (snapshot.hasData &&
                                snapshot.data.documents.length == 0)
                              return Center(child: Text("Nothing posted yet"));
                            return Flexible(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      childAspectRatio: 3 / 2,
                                      maxCrossAxisExtent: 200,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (_) => View(snapshot
                                                    .data
                                                    .documents[index]
                                                    .reference
                                                    .documentID))),
                                        child: Container(
                                          width: 400,
                                          height: 320,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "https://firebasestorage.googleapis.com/v0/b/monumento-project-b0dc8.appspot.com/o/eiffel.jpeg?alt=media&token=3d2ba987-dea4-4611-a1cf-5eee18a17418"))),
                                        ),
                                      );
                                    }));
                          }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
