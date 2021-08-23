import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swp409/Interface/Home/clinicListView.dart';
import 'package:swp409/Interface/Profile/components/body.dart';
import 'package:swp409/Models/clinic.dart';
import 'package:swp409/Models/user.dart';
import 'package:swp409/Services/ApiService/clinic_service.dart';
import 'package:swp409/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewCmtScreen extends StatefulWidget {
  User user;
  List<String> cookies;

  ReviewCmtScreen({Key key, this.user, this.cookies}) : super(key: key);
  @override
  _ReviewCmtScreenState createState() => _ReviewCmtScreenState();
}

class _ReviewCmtScreenState extends State<ReviewCmtScreen> {
  ClinicService _clinicService = new ClinicService();
  List<String> _cookies;
  Clinic _clinic;
  User _user;
  int reviewLength = 0;

  Clinic getClinicId(List<Clinic> list, User user) {
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        if (list[i].email == user.email) {
          print('abc');
          print(list[i].toJson());
          return list[i];
        }
      }
    }
    return null;
  }

  Future<List<Clinic>> fetchClinics() async {
    var fetchdata = await _clinicService.getClinics(urlGet);
    var clinics = <Clinic>[];
    var clinicsjson = fetchdata.data['data']['data'] as List;
    for (var clinic in clinicsjson) {
      clinics.add(Clinic.fromJson(clinic));
    }
    return clinics;
  }

  @override
  void initState() {
    _cookies = widget.cookies;
    _user = widget.user;
    fetchClinics().then((value) {
      setState(() {
        _clinic = getClinicId(value, _user);
        reviewLength = _clinic.reviewCount;
        for (int i = 0; i < _clinic.reviewCount; i++) {
          isVisible.add(false);
        }
      });
    });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPrimaryBackground,
        appBar: AppBar(
          title: Text(
            'Review comment',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          backgroundColor: kPrimaryAppbar,
        ),
        body: SafeArea(
          child: Container(
            height: (_clinic.reviewCount == 0)
                ? 0
                : MediaQuery.of(context).size.height,
            child: buildListCmt(),
          ),
        ),
      ),
    );
  }

  List<bool> isVisible = [];
  List<bool> name;

  void changeVisible(int i) {
    setState(() {
      isVisible[i] = !isVisible[i];
    });
  }

  double ratingCmt = 4.5;
  buildListCmt() {
    return ListView.builder(
      itemCount: reviewLength,
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
                      onPressed: () {
                        changeVisible(index);
                      },
                      child: const Text(
                        'Replies',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ]),
                  Visibility(
                    visible: isVisible[index], //isVisible,
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

  buildViewCmtChild(int i) {
    return ListView.builder(
        itemCount: _clinic.reviews[i].replies.length ?? 0,
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
                        _clinic.reviews[i].replies[index].reply,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                ],
              ),
            ));
  }

  String cmtChild = "";

  double getHeight(int i) {
    if (_clinic.reviews[i].replies.length == 0) {
      return 0;
    } else if (_clinic.reviews[i].replies.length <= 3) {
      return (_clinic.reviews[i].replies.length * 80).toDouble();
    } else {
      return 240;
    }
  }

  Widget buildViewCmtAndCmtChild(int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
      child: Column(
        children: [
          Container(
            height: getHeight(i),
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
                      onPressed: () {
                        String reply = cmtChild;
                        String urlAddReview =
                            '$ServerIP/api/v1/reviews/reply/${_clinic.reviews[i].id}';
                        _clinicService
                            .addReplyClinic(urlAddReview, _cookies, reply)
                            .then((value) {
                          setState(() {
                            List<Clinic> clinics = <Clinic>[];
                            fetchClinics().then((value) {
                              setState(() {
                                clinics = value;
                                print("list clinic: ${clinics.toString()}");
                                for (Clinic getClinic in clinics) {
                                  if (getClinic.id.compareTo(_clinic.id) == 0) {
                                    _clinic = getClinic;
                                    print("clinicc: ${_clinic.toJson()}");
                                    break;
                                  }
                                }
                                toast("Successfully");
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReviewCmtScreen(
                                      user: _user, cookies: _cookies),
                                ));
                              });
                            });
                          });
                        });
                      },
                      color: kPrimaryColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
