import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: _imageFile == null
                ? AssetImage('images/userprofile.jpg')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            right: 25,
            bottom: -8,
            child: SizedBox(
              height: 45,
              width: 45,
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Color(0xFFDFDFE3)),
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.camera_alt),
                  ],
                ),
                color: Color(0xFFDFDFE3),
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void TakePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              FlatButton.icon(
                  onPressed: () {
                    TakePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              // ignore: deprecated_member_use
              FlatButton.icon(
                  onPressed: () {
                    TakePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Camera')),
            ],
          )
        ],
      ),
    );
  }
}
