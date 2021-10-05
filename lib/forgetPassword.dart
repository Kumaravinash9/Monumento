import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _passwordcheck = TextEditingController(text: "");
  Future<QuerySnapshot> check(String email) async {
    final String collection = "users";
    QuerySnapshot documentReference = await Firestore.instance
        .collection(collection)
        .where("email", isEqualTo: email)
        .getDocuments();
    print(documentReference.documents.length);
    if (documentReference.documents.length > 0) return documentReference;
    return null;
  }

  Future<bool> forgetpasswordLogic() async {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    print(_passwordcheck.text);
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (_passwordcheck.text.length > 1) {
      var _check = await check(_passwordcheck.text.trim());
      print(_check);
      if (_check != null) {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        _auth
            .sendPasswordResetEmail(email: _passwordcheck.text.trim())
            .then((value) {
          print("check your email Please");
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            elevation: 20,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.white,
            content: Text(
              'Hey ${_check.documents[0].data['name']},reset password link sent to your email ',
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: GoogleFonts.montserrat().fontFamily),
            ),
          ));
          print("check your email Please");
          _passwordcheck.clear();
        }).catchError((err) => print(err));
        return true;
      }
      _passwordcheck.clear();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        elevation: 20,
        duration: Duration(seconds: 1),
        backgroundColor: Colors.white,
        content: Text(
          'Please enter a registered email ',
          style: TextStyle(
              color: Colors.amber,
              fontFamily: GoogleFonts.montserrat().fontFamily),
        ),
      ));

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40.0, left: 9, right: 9, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {},
                  iconSize: 100,
                )),
                Center(
                    child: Text(
                  "FORGET ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
                Center(
                  child: Text("PASSWORD",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 5, bottom: 40),
                  child: Center(
                      child: Text(
                          "Provide your account's email for which you want to reset your password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.2, fontWeight: FontWeight.w500))),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .85,
                      height: 48,
                      color: Colors.black12.withOpacity(.05),
                      child: TextField(
                        maxLines: 5,
                        controller: _passwordcheck,
                        decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(.01).withAlpha(5),
                          filled: true,
                          contentPadding: EdgeInsets.only(top: 10.0, left: 10),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Enter your Email',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 44,
                  width: MediaQuery.of(context).size.width * .85,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    color: Colors.amber,
                    onPressed: () async {
                      await forgetpasswordLogic();
                    },
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
