import 'package:flutter/material.dart';

showBottom(BuildContext context, Function getImage) async {
  await showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.yellow.withOpacity(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      context: context,
      builder: (context) {
        return TypeSelector(getImage, context);
      });
}

class TypeSelector extends StatefulWidget {
  final context;
  final getImage;
  TypeSelector(this.getImage, this.context);
  @override
  _TypeSelectorState createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  List<Map<String, dynamic>> icons = [
    {"icon": Icons.delete, "text": "Remove Photo"},
    {
      "icon": Icons.camera,
      "text": "Camera",
    },
    {
      "icon": Icons.image,
      "text": "Image",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(6),
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        padding: const EdgeInsets.only(top: 13, left: 10, right: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile Photo",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            SizedBox(height: 25),
            Container(
              height: 100,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 3 / 2,
                    maxCrossAxisExtent: 160,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: icons.length,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(widget.context).pop();
                        widget.getImage(i);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Icon(icons[i]["icon"]),
                            ),
                            FittedBox(
                                child: Text(
                              icons[i]["text"],
                              softWrap: true,
                            ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
