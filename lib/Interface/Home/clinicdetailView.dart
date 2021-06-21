import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/Services/Booking/booking.dart';
import 'package:swp409/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../size_config.dart';

// ignore: must_be_immutable
class ClinicPage extends StatefulWidget {
  Clinic clinic;
  User user;
  List<String> cookies;
  ClinicPage.clinic({Key key, this.clinic, this.user, this.cookies})
      : super(key: key);
  @override
  _ClinicPageState createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  Clinic _clinic;
  double rating = 0.0;
  List<String> _cookies;
  bool viewVisible = false;
  List<bool> name;
  User _user;
  ClinicService _clinicService = new ClinicService();

  void changeVisible() {
    setState(() {
      viewVisible = !viewVisible;
    });
  }

  @override
  void initState() {

      _clinic = widget.clinic;
      print(_clinic.toJson());
      _user = widget.user;
      _cookies = widget.cookies;
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
    print(_clinic.coverImage.url);
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
          padding: const EdgeInsets.all(10),
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
                      MaterialPageRoute(
                          builder: (context) => Booking(clinic: _clinic, cookies: _cookies, user: _user)),
                    );
                  },
                  child: Text('Book an appointment')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Image.network(_clinic.coverImage.url),
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
                          _clinic.name,
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
                          Icon(Icons.location_on_outlined, color: Colors.black),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                                _clinic.address ??
                                    "85A Đường Nguyễn Văn Cừ, An Bình, Ninh Kiều, Cần Thơ",
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
                          Icon(Icons.local_phone_outlined, color: Colors.black),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(_clinic.phone,
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
                          Icon(Icons.description_outlined, color: Colors.black),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(_clinic.description,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[0].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[0].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[0].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[0].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[1].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[1].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[1].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[1].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[2].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[2].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[2].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[2].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[3].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[3].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[3].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[3].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[4].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[4].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[4].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[4].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                // width: 230,
                                child: Text(
                                  '${(_clinic.schedule[5].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[5].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[5].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[5].endTime % 60).toInt().toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                //width: 230,
                                child: Text(
                                  '${(_clinic.schedule[6].startTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[6].startTime % 60).toInt().toString().padLeft(2, '0')} - ${(_clinic.schedule[6].endTime ~/ 60).toString().padLeft(2, '0')}:${(_clinic.schedule[6].endTime % 60).toInt().toString().padLeft(2, '0')}',
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
                      Container(child: buildCmtField()),
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
                                  onPressed: () {
                                    print("id: ${_clinic.id}");
                                    String review = cmtController.text;
                                    print ("review: ${review}, rating: ${rating}");
                                    String urlAddReview = '$ServerIP/api/v1/reviews/${_clinic.id}';
                                    _clinicService.addReviewClinic(urlAddReview, _cookies, review, rating)
                                        .then((value) {
                                          print("Review: ${value.data}");
                                          setState(() {
                                          });
                                    });

                                  },
                                  child: Text('Send')),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: (_clinic.reviewCount == 0) ? 0 : 300,
                child: buildListCmt(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double ratingCmt = 4.5;
  buildListCmt() {
    bool isVisible = false;
    return ListView.builder(
      itemCount: _clinic.reviewCount,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Card(
            elevation: 2,
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
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _clinic.reviews[index].user.avatar.url),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          _clinic.reviews[index].user.name,
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
                          rating: _clinic.reviews[index].rating,
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Text(
                        _clinic.reviews[index].review,
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
                        'Replies',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ]),
                  Visibility(
                    visible: viewVisible, //isVisible,
                    child: buildViewCmtAndCmtChild(index),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
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

//o day ne
  buildViewCmtChild(int i) {
    return ListView.builder(
        itemCount: _clinic.reviews[i].replies.length,
        itemBuilder: (context, index) => Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(_clinic
                                  .reviews[i].replies[index].user.avatar.url),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          _clinic.reviews[i].replies[index].user.name,
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
                        _clinic.reviews[i].replies[index].review,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ]),
                ],
              ),
            ));
  }

  String cmtChild = "";

  Widget buildViewCmtAndCmtChild(int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
      child: Column(
        children: [
          Container(
            height: 50,
            child: buildViewCmtChild(i),
          ),
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
              suffixIcon: cmtChild.length == 0
                  ? Container(width: 0)
                  : IconButton(
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
