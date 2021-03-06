import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monumento/home_screen.dart';
import 'package:monumento/register_screen.dart';
import 'constants.dart';
import 'For_Password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isseen = false;

  @override
  void initState() {
    super.initState();
    isseen = false;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> emailSignIn(String email, String password) async {
    try {
      AuthResult authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      print('Email Sign In error: ' + e.toString());
      return null;
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    print('Google Sign In called');
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  Future<bool> createUser(FirebaseUser user) async {
    String collection = "users";
    Map<String, dynamic> map = new Map();
    map["auth_id"] = user.uid;
    map["name"] = user.displayName ?? 'Monumento User';
    map["prof_pic"] = user.photoUrl ?? '';
    map["status"] = 'Monumento-nian';
    map["email"] = _emailController.text.trim();
    map["password"] = _passwordController.text.trim();

    DocumentReference documentReference =
        Firestore.instance.collection(collection).document();
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(documentReference, map).catchError((e) {
        return false;
      }).whenComplete(() {
        print('User Created!');
        return true;
      });
    }).catchError((e) {
      print(e.toString());
      return false;
    });
    return true;
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            //TODO: Email Validation
            keyboardType: TextInputType.emailAddress,
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
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            //TODO: Password Validation
            obscureText: !isseen,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            style: TextStyle(
              color: Colors.amber,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.amber,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  !isseen ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    isseen = !isseen;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () async {
          print('Forgot Password Button Pressed');
          //await forgetPassword(context);
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (_) => ForgetPassword()));
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        splashColor: Colors.lightGreen,
        onPressed: () {
          print('Login Button Pressed');
          emailSignIn(_emailController.text, _passwordController.text)
              .then((user) {
            if (isseen)
              setState(() {
                isseen = !isseen;
              });
            if (user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            user: user,
                          )),
                  (Route<dynamic> route) => false);
            } else {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Please enter a registered email and password!',
                  style: TextStyle(
                      color: Colors.amber,
                      fontFamily: GoogleFonts.montserrat().fontFamily),
                ),
              ));
            }
          }).whenComplete(() => print('Email Sign in process complete'));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: MaterialButton(
        onPressed: () {
          signInWithGoogle().then((user) {
            if (user != null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Signing In! Please wait...',
                  style: TextStyle(color: Colors.amber),
                ),
              ));
              createUser(user).then((value) {
                if (value)
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                user: user,
                              )),
                      (Route<dynamic> route) => false);
                else
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      'Error! Please Try Again Later...',
                      style: TextStyle(
                          color: Colors.amber,
                          fontFamily: GoogleFonts.montserrat().fontFamily),
                    ),
                  ));
              });
            } else {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Google Sign-In failed!',
                  style: TextStyle(
                      color: Colors.amber,
                      fontFamily: GoogleFonts.montserrat().fontFamily),
                ),
              ));
            }
          }).whenComplete(() => print('Google Sign In process completed.'));
        },
        elevation: 10.0,
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        splashColor: Colors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login with Google',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/google.png',
              height: 30.0,
              width: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        if (isseen)
          setState(() {
            isseen = !isseen;
          });
        print('Sign Up Button Pressed');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.yellow[600],
                      Colors.amber,
                    ],
                    stops: [0.4, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
