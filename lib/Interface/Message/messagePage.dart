import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          child: Row(
            children: [
              OutlinedButton(
                  style: ButtonStyle(), onPressed: () {}, child: Text('Recent'))
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Chats'),
      actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      elevation: 0,
    );
  }
}
