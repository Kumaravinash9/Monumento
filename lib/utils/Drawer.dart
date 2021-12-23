import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newDemoApp/about.dart';
import 'package:newDemoApp/edit_profile.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../RecentVisit.dart';
import '../login_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.description,
              text: 'Recent Visit',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => RecentVisit()))
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.edit,
              text: 'Edit Profile',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => EditProfile()))
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.share,
              text: 'Share App',
              onTap: () => {Navigator.pop(context), shareApp()}),
          Divider(),
          _createDrawerItem(
              icon: Icons.book,
              text: 'About',
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => About()))
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report,
              text: 'Report A Bug',
              onTap: () async {
                try {
                  await _launchURL();
                } catch (e) {}

                Navigator.pop(context);
              }),
          Divider(),
          _createDrawerItem(
              icon: Icons.logout,
              text: 'Log Out',
              onTap: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              }),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/monumento_icon.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              child: Text(
                'Providing better learning way',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}

reportABug() async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'costofcare225@gmail.com',
    query: 'subject=Bug Report',
  );
  if (await canLaunch(_emailLaunchUri.toString())) {
    await launch(_emailLaunchUri.toString());
  } else {
    throw Exception('No App found to send mail');
  }
}

void shareApp() {
  Share.share("Try the LibreHealth Cost Of Care Explorer App," +
      " it is developed by LibreHealth & it provides functionality to compare costs of medical procedures of different hospitals." +
      "\n  APP_LINK ");
}

_launchURL() async {
  const url = 'https://gitlab.com/aossie/monumento/-/issues';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch';
  }
}
