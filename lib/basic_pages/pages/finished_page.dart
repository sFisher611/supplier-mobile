import 'package:darwin_camera/darwin_camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supplier_project/const/const_text.dart';
import 'package:supplier_project/ui/widgets/bottom_navigation_button.dart';
import 'package:supplier_project/ui/widgets/dropdown_be_border.dart';
import 'package:supplier_project/ui/widgets/text_field_in_border_radius.dart';
import 'package:location/location.dart';
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
  double _currentSliderValue = 20;
  List<String> list = ['Boy', 'Orta', 'Nochor'];
  var selectEvalution = 'Boy';
  var location = new Location();
  var currentLocation;
  @override
  void initState() {
    super.initState();
    _location();
  }

  _location() async {
    try {
      var value = await location.getLocation();
      setState(() {
        currentLocation = {
          'latitude': value.latitude,
          'longitude': value.longitude
        };
      });
    } catch (e) {
      currentLocation = null;
    }
    setState(() {});
    // location.onLocationChanged.listen((value) {
    //   print(value);

    //   setState(() {
    //     currentLocation = {
    //       'latitude': value.latitude,
    //       'longitude': value.longitude
    //     };
    //   });
    // });
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      if (imageSource == ImageSource.camera) {
        String filePath = await FileUtils.getDefaultFilePath();
        String uuid = DateTime.now().millisecondsSinceEpoch.toString();
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
          // print(result.file);
          // print(result.file.path);
          File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
              path: result.file.path);
          listImage.add({'image_path': rotatedImage.path});
        }
      } else {
        ImagePicker _picker = ImagePicker();
        var imageFile = await _picker.pickImage(
          source: imageSource,
          maxHeight: 600,
          // preferredCameraDevice: CameraDevice.rear,
        );

        var path = imageFile.path;
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
        child: Image.file(
          File(listImage[index]['image_path']),
        ),
      );
    } else {
      return ImageIcon(
        AssetImage("assets/image/add_image.png"),
        color: Colors.black,
        size: size.height * 0.08,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationButton(
        size: size,
        onPressed: () {},
        text: 'Сақлаш',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              child: ListView.builder(
                itemCount: listImage.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          index == 0
                              ? _selectCamerOrGallery()
                              : _selectImage(index);
                        },
                        child: new Container(
                          width: size.width * 0.25,
                          child: new GridTile(
                            child: _buildImage(index),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            DropDownBeBorder(
                size: size,
                list: list,
                icon: Icons.mail,
                onChanged: (value) {
                  setState(() => selectEvalution = value);
                },
                selectedIndex: selectEvalution),
            SizedBox(
              height: 10,
            ),
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            TextFieldInBorderRadius(
              hintText: "Изох",
            ),
            currentLocation == null
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ListTile(
                        tileColor: Colors.blue[100],
                        title: Text('latitude'),
                        trailing: Text(currentLocation["latitude"].toString()),
                      ),
                      ListTile(
                        tileColor: Colors.blue[100],
                        title: Text('longitude'),
                        trailing: Text(currentLocation["longitude"].toString()),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future _selectCamerOrGallery() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: size.width * 0.8,
              height: size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  Future _selectImage(index) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 10),
            content: Container(
              width: size.width * 0.8,
              height: size.height * 0.5,
              child: Image.file(
                File(listImage[index]['image_path']),
              ),
            ),
          );
        });
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
