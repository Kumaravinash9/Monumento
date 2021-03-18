import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/*class View extends StatefulWidget {
  final postID;
  View(this.postID);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  FocusNode inputNode = FocusNode();
// to open keyboard call this function;
  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  Widget Comment() {
    return Container(
      width: 500,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 10),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/explore.jpg'),
                  radius: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Paris",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text("3 days ago", style: TextStyle(fontSize: 9))
                          ],
                        ),
                        Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w500)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: null),
                            FlatButton(
                                onPressed: () => openKeyboard(),
                                child: Text("Reply",
                                    style: TextStyle(
                                        color: Colors.blue[300], fontSize: 11)))
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }

  String title =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                elevation: 8,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                underline: null,
                items: [
                  DropdownMenuItem(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Save"),
                        Divider(),
                      ],
                    ),
                    value: "Save",
                  ),
                  DropdownMenuItem(
                    child: Text("LogOut"),
                    value: "logout",
                  ),
                ],
                onChanged: (value) async {}),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Container(
          child:
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "20:30 pm",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('20-10-2020', style: TextStyle(fontSize: 10))
                    ],
                  ),
                  title: Text(
                    "Paris",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Row(children: [
                    Icon(
                      Icons.location_on,
                      size: 10.0,
                      color: Colors.amber,
                    ),
                    Text(
                      "France",
                      style: TextStyle(fontSize: 11),
                    ),
                  ]),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/explore.jpg'),
                    radius: 23,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 12,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/monumento-project-b0dc8.appspot.com/o/colosseum.jpg?alt=media&token=1f945c0e-14c2-46ea-a0a6-3402c2f5fdd6",
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      row(Icons.favorite, "Like", Colors.red),
                      row(Icons.comment, "comment", Colors.blue[200]),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                  child: Row(children: [
                    Text("Comments :",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Comment()
              ],
            )),
          ),
        ),
        Container(
            height: 61,
            color: Colors.black12.withOpacity(.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 40,
                  child: TextField(
                    maxLines: 5,
                    focusNode: inputNode,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 14.0, left: 10),
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      hintText: 'Post your comments',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ))
      ]),
    );
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
        onPressed: () {},
      ),
      SizedBox(width: 1),
      Text(text)
    ],
  );
}
*/

class View extends StatefulWidget {
  final postID;
  View(this.postID);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  FocusNode inputNode = FocusNode();

  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  String prof_pic;
  String uid;
  String name;
  TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: '');
    getinitialvalue();
  }

  getinitialvalue() async {
    final id = await FirebaseAuth.instance.currentUser();
    final auth =
        await Firestore.instance.collection("users").document(id.uid).get();
    setState(() {
      prof_pic = auth.data['prof_pic'];
      name = auth.data['name'];
      uid = auth.data['auth_id'];
    });
  }

  String title =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  elevation: 8,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  underline: null,
                  items: [
                    DropdownMenuItem(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Save"),
                          Divider(),
                        ],
                      ),
                      value: "Save",
                    ),
                    DropdownMenuItem(
                      child: Text("LogOut"),
                      value: "logout",
                    ),
                  ],
                  onChanged: (value) async {}),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("posts")
                .document(widget.postID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());

              return Column(children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: Firestore.instance
                                .collection("users")
                                .document(uid)
                                .get(),
                            builder: (context, snapshoty) {
                              if (!snapshoty.hasData)
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    child: ListTile(
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Shimmer.fromColors(
                                              direction: ShimmerDirection.rtl,
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[300],
                                              child: Text(
                                                "20:30 pm",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              )),
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[300],
                                              child: Text('20-10-2020',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white)))
                                        ],
                                      ),
                                      title: Shimmer.fromColors(
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[300],
                                          child: Text(
                                            "Avinash kumar",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          )),
                                      subtitle: Row(children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 10.0,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          "paris",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ]),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/explore.jpg'),
                                        radius: 23,
                                      ),
                                    ));
                              return ListTile(
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "20:30 pm",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text('20-10-2020',
                                        style: TextStyle(fontSize: 10))
                                  ],
                                ),
                                title: Text(
                                  snapshoty.data['name'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Row(children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 10.0,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    snapshot.data['location'],
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ]),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      snapshoty.data['prof_pic'] != ''
                                          ? NetworkImage(
                                              snapshoty.data['prof_pic'],
                                            )
                                          : AssetImage('assets/explore.jpg'),
                                  radius: 23,
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(snapshot.data['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 12,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 0),
                            child: Container(
                              width: double.infinity,
                              height: 280,
                              child: Image.network(
                                snapshot.data['url'],
                                fit: BoxFit.cover,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              row(Icons.favorite, "Like", Colors.red),
                              row(Icons.comment, "comment", Colors.blue[200]),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 2),
                          child: Row(children: [
                            Text("Comments :",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        if (snapshot.data['comments'] != null &&
                            snapshot.data['comments'].length > 0)
                          Column(
                              children: snapshot.data['comments']
                                  .map<Widget>((element) {
                            // get index

                            return /*StreamBuilder(
                                stream: Firestore.instance
                                    .collection("comments")
                                    .document(element['comment_id'])
                                    .snapshots(),
                                builder: (context, commentsnapshot) {
                                  print(element['comment_id']);

                                  if (commentsnapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Center(
                                        child: CircularProgressIndicator());
                                  print(commentsnapshot.data);
                                  return Comment(
                                      commentsnapshot, openKeyboard, uid);
                                });*/
                                CommentstateFul(element, openKeyboard, uid);
                          }).toList())
                      ],
                    )),
                  ),
                ),
                Container(
                    height: 61,
                    color: Colors.black12.withOpacity(.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          height: 40,
                          child: TextField(
                            maxLines: 5,
                            focusNode: inputNode,
                            controller: _textController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.only(top: 14.0, left: 10),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  inputNode.unfocus();
                                  if (_textController.text != null &&
                                      _textController.text.trim().length > 0) {
                                    /*Firestore.instance
                                        .collection("comments")
                                        .document()
                                        .setData({
                                      "name": name,
                                      "prof_pic": prof_pic,
                                      "timestamp": Timestamp.now(),
                                      "auth_id": uid,
                                      "comment_msg": _textController.text,
                                    });*/

                                    DocumentReference docReference = Firestore
                                        .instance
                                        .collection("comments")
                                        .document();

                                    docReference.setData({
                                      "timestamp": Timestamp.now(),
                                      "auth_id": uid,
                                      "comment_msg": _textController.text,
                                    }).then((doc) {
                                      _textController.clear();
                                      print('hop ${docReference.documentID}');
                                      Firestore.instance
                                          .collection("posts")
                                          .document(widget.postID)
                                          .setData({
                                        'comments': FieldValue.arrayUnion([
                                          {
                                            "comment_id":
                                                docReference.documentID,
                                            "timestamp": new Timestamp.now()
                                          }
                                        ])
                                      }, merge: true).whenComplete(() {
                                        print("successfully Saved");
                                      });
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: 'Post your comments',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ))
              ]);
            }));
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
        onPressed: () {},
      ),
      SizedBox(width: 1),
      Text(text)
    ],
  );
}

Widget Comment(
    AsyncSnapshot<dynamic> snapshot, Function openKeyboard, String uid) {
  return Container(
    width: 500,
    child: Column(
      children: [
        FutureBuilder(
            future: Firestore.instance.collection("users").document(uid).get(),
            builder: (context, snapshoty) {
              if (!snapshoty.hasData) return SizedBox();
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 10),
                        child: CircleAvatar(
                          backgroundImage: snapshoty.data['prof_pic'] != ''
                              ? NetworkImage(
                                  snapshoty.data['prof_pic'],
                                )
                              : AssetImage('assets/explore.jpg'),
                          radius: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0, right: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshoty.data['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("3 days ago",
                                        style: TextStyle(fontSize: 9))
                                  ],
                                ),
                                Text(snapshot.data['comment_msg'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        onPressed: null),
                                    FlatButton(
                                        onPressed: () => openKeyboard(),
                                        child: Text("Reply",
                                            style: TextStyle(
                                                color: Colors.blue[300],
                                                fontSize: 11)))
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ));
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 0),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}

class CommentstateFul extends StatefulWidget {
  final element;
  final openKeyboard;
  final uid;
  CommentstateFul(this.element, this.openKeyboard, this.uid);

  @override
  _CommentstateFulState createState() => _CommentstateFulState();
}

class _CommentstateFulState extends State<CommentstateFul> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("comments")
            .document(widget.element['comment_id'])
            .snapshots(),
        builder: (context, commentsnapshot) {
          print(widget.element['comment_id']);

          if (commentsnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          print(commentsnapshot.data);
          return Comment(commentsnapshot, widget.openKeyboard, widget.uid);
        });
  }
}
