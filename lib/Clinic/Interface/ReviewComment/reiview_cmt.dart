import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:io';
import '../../../constants.dart';

class ReviewCmtScreen extends StatefulWidget {
  @override
  _ReviewCmtScreenState createState() => _ReviewCmtScreenState();
}

class _ReviewCmtScreenState extends State<ReviewCmtScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        appBar: AppBar(
          title: Text(
            'Review comment',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildListCmt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool viewVisible = false;
  List<bool> name;

  void changeVisible() {
    setState(() {
      viewVisible = !viewVisible;
    });
  }
  double ratingCmt = 4.5;
  Widget buildListCmt() {
    bool isVisible = false;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Card(
          elevation: 2,
          shadowColor: Colors.black,
          margin: const EdgeInsets.only(
              top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
          child: Padding(
            padding:
            const EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    uploadClinicImg(),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Trinh Ha",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: SmoothStarRating(
                        starCount: 5,
                        size: 20.0,
                        color: Colors.orange,
                        borderColor: Colors.orange,
                        spacing: 0.0,
                        isReadOnly: true,
                        allowHalfRating: true,
                        rating: ratingCmt,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: Text(
                      "This is a good clinic, i very satisfy!!",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ]),
                Row(children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed:
                    changeVisible, //() => setState(() => isVisible = !isVisible),
                    child: const Text(
                      'Comment (1)',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ]),
                Visibility(
                  visible: viewVisible, //isVisible,
                  child: buildViewCmtAndCmtChild(),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PickedFile _imageFile;
  Widget uploadClinicImg() {
    return SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: _imageFile == null
                ? AssetImage('images/userprofile.jpg')
                : FileImage(File(_imageFile.path)),
          ),
        ],
      ),
    );
  }

  final cmtController = TextEditingController();
  TextField buildCmtField() {
    return TextField(
      maxLines: 3,
      maxLength: 150,
      controller: cmtController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        hintText: "Your comment about this clinic",
        suffixIcon: cmtController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close),
          onPressed: () => cmtController.clear(),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildViewCmtChild() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              uploadClinicImg(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  "+4 100%",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
          Row(children: [
            Expanded(
              child: Text(
                "I don't think so! I think we need more 4 months",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  String cmtChild;
  Widget buildViewCmtAndCmtChild() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
      child: Column(
        children: [
          buildViewCmtChild(),
          SizedBox(height: 10),
          TextFormField(
            maxLines: 1,
            onChanged: (value) {
              setState(() {
                cmtChild = value;
              });
              return null;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Cant null";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter your comment",
              enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: cmtChild.length == 0 ? Container(width: 0) : IconButton(
                icon: Icon(Feather.send),
                onPressed: () {},
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
