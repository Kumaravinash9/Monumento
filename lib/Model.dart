import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

import 'constants.dart';

class modelshow extends StatelessWidget {
  const modelshow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          '3D View',
          style: kLabelStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ModelViewer(
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        src:
            'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // a bundled asset file
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}
