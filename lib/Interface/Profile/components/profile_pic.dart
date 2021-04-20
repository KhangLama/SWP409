import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        clipBehavior: Clip.none, fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('images/userprofile.jpg'),

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
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.camera_alt),
                  ],
                ),
                color: Color(0xFFDFDFE3),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
