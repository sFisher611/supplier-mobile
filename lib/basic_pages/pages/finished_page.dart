import 'package:darwin_camera/darwin_camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/ui/widgets/bottom_navigation_button.dart';
import 'package:supplier_project/ui/widgets/neck_background.dart';
import 'package:supplier_project/ui/widgets/texts.dart';
import 'package:supplier_project/ui/widgets/universal_button.dart';

class FinishedPage extends StatefulWidget {
  FinishedPage({
    Key key,
  }) : super(key: key);

  @override
  _FinishedPageState createState() => _FinishedPageState();
}

class _FinishedPageState extends State<FinishedPage> {
  var listImage = [
    {"image_path": ''}
  ];
  File _imageFile;
  var size;
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      if (imageSource == ImageSource.camera) {
        String filePath = await FileUtils.getDefaultFilePath();
        String uuid = DateTime.now().millisecondsSinceEpoch.toString();

        ///
        filePath = '$filePath/$uuid.jpg';
        List<CameraDescription> cameraDescription = await availableCameras();
        DarwinCameraResult result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DarwinCamera(
              cameraDescription: cameraDescription,
              filePath: filePath,
              resolution: ResolutionPreset.high,
              defaultToFrontFacing: false,
              quality: 90,
            ),
          ),
        );

        if (result != null && result.isFileAvailable) {
          /// File object returned by Camera.
          print(result.file);

          /// Path where the file is faced.
          print(result.file.path);
          File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
              path: result.file.path);
          listImage.add({'image_path': rotatedImage.path});
        }
      } else {
        final ImagePicker _picker = ImagePicker();
        final imageFile = await _picker.pickImage(
          source: imageSource,
          maxHeight: 1000,
          maxWidth: 500,
          imageQuality: 90,

          // preferredCameraDevice: CameraDevice.rear,
        );

        final path = imageFile.path;
        // await ImageResize.saveImage(path);
        File rotatedImage =
            await FlutterExifRotation.rotateAndSaveImage(path: path);
        _imageFile = rotatedImage;
        listImage.add({'image_path': _imageFile.path});
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage(index) {
    // var a =
    //     '/storage/emulated/0/Pictures/3c27f462-0fb4-485a-b847-5509d691c0805200698126285788651.jpg';
    if (index != 0) {
      return Container(
        height: 100,
        width: 100,
        child: Image.file(
          File(listImage[index]['image_path']),
        ),
      );
    } else {
      return Icon(
        Icons.add,
        size: size.height * 0.08,
      );
      //  Container(
      //     height: 100,
      //     width: 100,
      //     child: Image.file(
      //       File(a),
      //     ));
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationButton(
        size: size,
        onPressed: () {},
        text: 'Сақлаш',
      ),
      body: Stack(
        children: [
          NeckBackground(
            size: size,
            captureArea: 0.2,
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.9,
              maxChildSize: 1.0,
              builder: (context, scrolControoller) {
                return NotificationListener(
                  child: GridView.builder(
                    itemCount: listImage.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          // color: ThemeOther.containerCar(),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            new BoxShadow(
                              // color: ThemeOther.containerShadowColor(),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              index == 0 ? _selectCamerOrGallery() : null;
                            },
                            child: new Container(
                              child: new GridTile(
                                child: _buildImage(index),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }

  Future _selectCamerOrGallery() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: ThemeOther.containerCar(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: size.width * 0.8,
              height: size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  UniversalButton(
                    height: size.height * 0.15,
                    width: size.height * 0.13,
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.camera,
                          size: size.height * 0.08,
                        ),
                        Texts.textButtonDialog(TEXT_BUTTON_DIALOG_CAMERA)
                      ],
                    ),
                  ),
                  UniversalButton(
                    height: size.height * 0.15,
                    width: size.height * 0.13,
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.image,
                          size: size.height * 0.08,
                        ),
                        Texts.textButtonDialog(TEXT_BUTTON_DIALOG_GALLERY)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })) {
      case 0:
        captureImage(ImageSource.camera);
        break;
      case 1:
        captureImage(ImageSource.gallery);
        break;
    }
  }
}

class FileUtils {
  static Future<String> getDefaultFilePath() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String mediaDirectory = appDocDir.path + "/media";
      Directory(mediaDirectory).create(recursive: true);
      return mediaDirectory;
    } catch (error, stacktrace) {
      print('could not create folder for media assets');
      print(error);
      print(stacktrace);
      return null;
    }
  }
}
