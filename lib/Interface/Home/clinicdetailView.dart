import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:io';
import '../../size_config.dart';

class ClinicPage extends StatefulWidget {
  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    cmtController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    cmtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Text(
          'Clinic\'s information',
          style: TextStyle(color: kPrimaryLightColor),
        ),
        backgroundColor: kPrimaryAppbar,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    // background
                    onPrimary: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    minimumSize: Size(SizeConfig.screenWidth - 40, 60),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.all(
                            Radius.circular(10))), // foreground
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Booking()),
                    );
                  },
                  child: Text('Book an appointment')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                ListBody(
                  children: [
                    Center(
                      child: Image(
                          image: NetworkImage(
                              'https://lh5.googleusercontent.com/p/AF1QipNfMT9alf72auaXkafqbtfY51b-5Z0qzHBWEPsv=w408-h306-k-no',
                              scale: 0.9)),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Phòng khám bác sĩ Tiêu Phương Lâm',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                    color: Colors.black),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      '85A Đường Nguyễn Văn Cừ, An Bình, Ninh Kiều, Cần Thơ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.local_phone_outlined,
                                    color: Colors.black),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text('0123456789',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.description_outlined,
                                    color: Colors.black),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                      'Phòng khám xịn xò nhất đất nước Việt Nam',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Open hours',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Monday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Tuesday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Wednesday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Thursday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Friday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Saturday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 130,
                                      child: Text(
                                        'Sunday',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        '08:00 AM - 05:00 PM',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Rating this clinic',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Let other know what you think',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            buildCmtField(),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    SmoothStarRating(
                                      starCount: 5,
                                      size: 40.0,
                                      color: Colors.orange,
                                      borderColor: Colors.orange,
                                      spacing: 3.0,
                                      isReadOnly: false,
                                      allowHalfRating: true,
                                      rating: rating,
                                      onRated: (value) {
                                        rating = value;
                                        print("Rating is: $rating");
                                      },
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () {},
                                        child: Text('Send')),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            buildList(),
                            buildList(),
                            buildList(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double ratingCmt = 4.5;
  Widget buildList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          shadowColor: Colors.black,
          margin: const EdgeInsets.only(
              top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
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
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Spacer(),
                    SmoothStarRating(
                      starCount: 5,
                      size: 20.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                      spacing: 0.0,
                      isReadOnly: true,
                      allowHalfRating: true,
                      rating: ratingCmt,
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
                ])
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
}
