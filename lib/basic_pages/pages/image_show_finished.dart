import 'package:flutter/material.dart';

class ImageShowFinished extends StatefulWidget {
  const ImageShowFinished({Key key}) : super(key: key);

  @override
  _ImageShowFinishedState createState() => _ImageShowFinishedState();
}

class _ImageShowFinishedState extends State<ImageShowFinished> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: new GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new GridTile(
              footer: new Text('name'),
              child: new Text('asd'), //just for testing, will fill with image later
            ),
          );
        },
      ),
    );
  }
}
