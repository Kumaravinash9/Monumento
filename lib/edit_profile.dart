import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newDemoApp/ProfileChane.dart';

import 'constants.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController;
  TextEditingController _statusController;
  TextEditingController _aboutController;
  TextEditingController _emailController;
  String uid;
  String url;

  final _key = new GlobalKey<ScaffoldState>();
  getintialData() async {
    final auth = await FirebaseAuth.instance.currentUser();
    final doc =
        await Firestore.instance.collection('users').document(auth.uid).get();
    setState(() {
      _nameController.text = doc.data['name'];
      _statusController.text = doc.data['status'];
      _emailController.text = doc.data['email'];
      uid = auth.uid;
      url = doc.data['prof_pic'];
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: 'Avinash');
    _statusController = new TextEditingController(text: "Traveller");
    _aboutController = new TextEditingController(text: "");
    _emailController = new TextEditingController(text: "avi@gamil.com");
    url = '';
    getintialData();
  }

  Widget _buildAboutTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'About',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _aboutController,
            style: TextStyle(
              color: Colors.amber,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.info,
                color: Colors.amber,
              ),
              suffixIcon: Icon(
                Icons.edit,
                color: Colors.amber,
              ),
              hintText: 'Enter your current status',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Status',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _statusController,
            style: TextStyle(
              color: Colors.amber,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.work,
                color: Colors.amber,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  print("hello");
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
              ),
              hintText: 'Enter your current status',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            readOnly: true,
            enableInteractiveSelection: true,
            keyboardType: TextInputType.text,
            controller: _emailController,
            style: TextStyle(
              color: Colors.amber,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.amber,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _nameController,
            style: TextStyle(
              color: Colors.amber,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_pin,
                color: Colors.amber,
              ),
              suffixIcon: Icon(
                Icons.edit,
                color: Colors.amber,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext ctx) {
    return InkWell(
      onTap: () => Navigator.of(ctx)
          .push(new MaterialPageRoute(builder: (_) => Imagey())),
      child: CircleAvatar(
        radius: 80,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: url != ''
                  ? NetworkImage(url)
                  : AssetImage('assets/explore.jpg'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.amber, blurRadius: 1.5, offset: Offset.zero)
            ],
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  _saveData() async {
    await Firestore.instance.collection('users').document(uid).updateData({
      "name": _nameController.text,
      "status": _statusController.text,
      "about": _aboutController.text
    }).whenComplete(() {
      setState(() {});
      _key.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Updated! ',
          style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.w800, fontSize: 25),
        ),
      ));
      print("Updated");
    });
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        splashColor: Colors.lightGreen,
        onPressed: () async {
          await _saveData();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.amber,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: BackButton(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: kLabelStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Save",
            splashColor: Colors.white,
            hoverColor: Colors.white,
            splashRadius: 30,
            icon: Icon(
              Icons.save,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () async {
              await _saveData();
            },
          ),
          SizedBox(width: 5)
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.amber,
                    Colors.yellow[600],
                  ],
                  stops: [0.4, 0.9],
                ),
              ),
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, bottom: 20.0, top: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildProfileImage(context),
                    SizedBox(height: 30),
                    _buildNameTF(),
                    SizedBox(height: 30),
                    _buildStatusTF(),
                    SizedBox(height: 30),
                    _buildAboutTF(),
                    SizedBox(height: 30),
                    _buildEmailTF(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _buildLoginBtn(),
                  ],
                ),
              ),
            )),
      ),
    );

    /*Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: kLabelStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Save",
            splashColor: Colors.white,
            hoverColor: Colors.white,
            splashRadius: 30,
            icon: Icon(
              Icons.save,
              color: Colors.white,
              size: 22,
            ),
            onPressed: null,
          ),
          SizedBox(width: 5)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildProfileImage(context),
            SizedBox(height: 30),
            _buildNameTF(),
            SizedBox(height: 30),
            _buildStatusTF(),
            SizedBox(height: 30),
            _buildAboutTF(),
            SizedBox(height: 30),
            _buildEmailTF(),
            _buildSignUpBtn()
          ],
        ),
      ),
    );*/
  }
}

/*Widget _buildProfileImage(BuildContext ctx) {
  return InkWell(
    onTap: () =>
        Navigator.of(ctx).push(new MaterialPageRoute(builder: (_) => Imagey())),
    child: Hero(
      tag: "Profile",
      child: CircleAvatar(
        radius: 80,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:  url != ''
                    ? NetworkImage(url)
                    : AssetImage('assets/explore.jpg'),
                fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.amber, blurRadius: 1.5, offset: Offset.zero)
            ],
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    ),
  );
}*/
