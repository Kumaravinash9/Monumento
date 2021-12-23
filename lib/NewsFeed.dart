import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newDemoApp/constants.dart';

import 'RecentVisit.dart';
import 'View.dart';
import 'utils/Drawer.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News Feed",
          style: kLabelStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              icon: Stack(alignment: Alignment.topRight, children: [
                Icon(
                  Icons.add_alert_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                Positioned(
                    top: 0,
                    left: 10,
                    child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: FittedBox(
                            child: Text(
                          "5",
                          style: TextStyle(color: Colors.white),
                        ))))
              ]),
              onPressed: () => Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (ctx) => RecentVisit())))
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("posts")
              .orderBy('timestamp')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) {
              print(snapshot.hasError);
              return Center(child: Text("Nothing posts yet"));
            }
            if (snapshot.hasData && snapshot.data.documents.length == 0)
              return Center(child: Text("Nothing posted yet"));

            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (ctx, index) =>
                    posts(index, snapshot.data.documents[index]));
          }),
    );
  }
}

class posts extends StatefulWidget {
  final i;
  final data;
  posts(this.i, this.data);
  @override
  _postsState createState() => _postsState();
}

class _postsState extends State<posts> {
  //String title =
  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection("users")
            .document(widget.data.data['auth_id'])
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => View(widget.data.reference.documentID))),
            child: Column(
              children: [
                ListTile(
                  trailing: Text("20:30 pm"),
                  title: Text(
                    snapshot.data['name'],
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15.0,
                        color: Colors.amber,
                      ),
                      Text(widget.data.data['location']),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: snapshot.data['prof_pic'] != ''
                        ? NetworkImage(
                            snapshot.data['prof_pic'],
                          )
                        : AssetImage('assets/explore.jpg'),
                    radius: 30,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Text(
                      widget.data.data['title'].substring(0, 100) + "....",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    widget.data.data['url'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        row(Icons.favorite, "Like", Colors.red),
                        row(Icons.comment, "comment", Colors.blue[200]),
                        row(Icons.share, "share", Colors.amber)
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 10,
                )
              ],
            ),
          );
        });

    /*InkWell(
      onTap: () => Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) => View())),
      child: Column(
        children: [
          ListTile(
            trailing: Text("20:30 pm"),
            title: Text(
              widget.i == 1
                  ? "Paris"
                  : widget.i == 2
                      ? "Colosseum"
                      : "Taj Mahal",
              style: TextStyle(fontSize: 15),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 15.0,
                  color: Colors.amber,
                ),
                Text(widget.i == 1
                    ? "France"
                    : widget.i == 2
                        ? " Italy"
                        : "India"),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/explore.jpg'),
              radius: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Text(title.substring(0, 100) + "....",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              widget.i == 1
                  ? "https://firebasestorage.googleapis.com/v0/b/monumento-project-b0dc8.appspot.com/o/eiffel.jpeg?alt=media&token=3d2ba987-dea4-4611-a1cf-5eee18a17418"
                  : widget.i == 2
                      ? "https://firebasestorage.googleapis.com/v0/b/monumento-project-b0dc8.appspot.com/o/colosseum.jpg?alt=media&token=1f945c0e-14c2-46ea-a0a6-3402c2f5fdd6"
                      : "https://firebasestorage.googleapis.com/v0/b/monumento-project-b0dc8.appspot.com/o/taj.jpeg?alt=media&token=02d33779-fe31-46d6-8349-7e697073acd6",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  row(Icons.favorite, "Like", Colors.red),
                  row(Icons.comment, "comment", Colors.blue[200]),
                  row(Icons.bookmark, "bookmark", Colors.amber)
                ],
              ),
            ),
          ),
          Divider(
            thickness: 10,
          )
        ],
      ),
    );*/
  }
}

Widget row(IconData _icon, String text, Color _color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(
          _icon,
          color: _color,
        ),
      ),
      SizedBox(width: .5),
      Text(text)
    ],
  );
}
