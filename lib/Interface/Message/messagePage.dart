import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swp409/Components/filled_outline_button.dart';
import 'package:swp409/constants.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            color: Colors.blue,
            child: Row(
              children: [
                FillOutlineButton(
                  press: () {},
                  text: 'Recent Messages',
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(

                  itemBuilder: (context, index) => Row()))
        ],
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text('Chats'),
    actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
    elevation: 0,
  );
}
