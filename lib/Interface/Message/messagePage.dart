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
<<<<<<< Updated upstream
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
=======
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
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
              itemCount: 15,
              itemBuilder: (context, index) => ChatCard(),
            ),
          ),
        ],
>>>>>>> Stashed changes
      ),
    );
  }

<<<<<<< Updated upstream
  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Chats'),
      actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      elevation: 0,
    );
  }
=======
class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              'https://s3.cloud.cmctelecom.vn/tinhte1/2018/09/4420878_Cover_Spiderman.jpg'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Spider-man'),
                SizedBox(height: 8),
                Text('Hello neighbor'),
              ],
            ),
          ),
        ),
      ],
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
>>>>>>> Stashed changes
}
