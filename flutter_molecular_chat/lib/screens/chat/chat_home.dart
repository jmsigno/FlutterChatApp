import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_molecular_chat/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';
import 'const.dart';

class ChatHome extends StatefulWidget {
  // user email
  final String userEmail;

  ChatHome(this.userEmail);

  @override
  State createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> {
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat List Screen',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            iconSize: 20,
            icon: Icon(Icons.settings),
            onPressed: () {
              logOut(context);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // List
          /**
             * Get the users from the database.Here the data is comint as streams from the
             * firebase.so we take all the user list and show to the user
             * to choose a one to start the chat
             * 
             */
          Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                  );
                }
              },
            ),
          ),

          // Loading
          Positioned(
            child: isLoading
                /**
              * It takes some time to load the data from the firebase to the app.
              * so untill the data is loaded a progress indicator is shown
              * 
              */
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          )
        ],
        // ),
        //onWillPop: onBackPress,
      ),
    );
  }

/**This widget is used to show the users in a list view.From the firebase we take a user list
 * so we going through that list and show one by one by loop through the list
 */
  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    /**
     * No need of showing currently logged user details to himself as
     * he don't chat with himself.So the currently users details are
     * not shown in the chat user list
     */
    if (document['username'] == widget.userEmail) {
      return Container();
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black)),
                child: Text(
                  '${document['username']}',
                  style: TextStyle(color: primaryColor),
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat(
                              peerId: document['username'],
                            )));
              },
            )
          ],
        ),
      );
    }
  }

  // logout the user when the setting button is pressed
  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userEmail');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}
