import 'package:flutter/material.dart';
import 'package:newDemoApp/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          'About',
          style: kLabelStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                        'assets/monumento_icon.png',
                      ),
                    ),
                    Text(
                      "Monumento",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'The goal of the project is to provide users an unique experience of exploring and learning more about the various monumental structures all around the world within the app.'
                  'It is core feature involves detecting a monument from its image, letting users know its name and Wikipedia details all from within the app along with visualizing a 3D model of it infront of them.'
                  ' The app having features like Popular Monuments, Bookmarks, Exploring about them all from within the app provides an interesting and knowledgable experience for them.'
                  '\n \nThis is Free & Open Source project'
                  ' you can visit to Aossie to know more about it & can contribute if you have an interesting idea.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    color: Colors.amber,
                    onPressed: () {
                      try {
                        _launchURL();
                      } catch (e) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: e.message,
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Visit Project',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://gitlab.com/aossie/monumento';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }
}
