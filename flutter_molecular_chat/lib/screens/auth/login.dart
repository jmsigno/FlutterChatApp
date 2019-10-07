import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_molecular_chat/models/user.dart';
import 'package:flutter_molecular_chat/screens/auth/register.dart';
import 'package:flutter_molecular_chat/screens/chat/chat_home.dart';
import 'package:flutter_molecular_chat/screens/validation/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _loginscaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _password = TextEditingController();
  final Validation validationObj = Validation.instance();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool autoValidate = false;
  SharedPreferences prefs;

  BuildContext _scaffoldContext;
  TextEditingController _email = TextEditingController();
  bool submitted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    handleLogin();
  }

/**
 * when a user login to the app his token is saved in the app locally.Again when 
 * the same user coming to the app without logout no need of login again
 * he can directly go in to the app.we saved user token using shared preferences 
 * plugin when a user is logged in.Here we handle that
 * 
 */
  void handleLogin() async {
    prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail');

    if (userEmail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatHome(userEmail)),
      );
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _loginscaffoldKey,
        body: isLoading
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              )
            : Form(
                key: loginFormKey,
                autovalidate: autoValidate,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent
                    ),
                    child: !submitted
                        ? ListView(
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                                child: Column(children: <Widget>[
                                  SizedBox(
                                    height: _height * 0.1,
                                  ),
                                  Text(
                                    "Flutter",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "ChatApp",
                                    style: TextStyle(
                                        fontSize: 60.0, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: _height * 0.2,
                                  ),
                                  TextFormField(
                                    validator: validationObj.validateEmail,
                                    controller: _email,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      errorStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _height * 0.02,
                                  ),
                                  TextFormField(
                                    validator: validationObj.validatePassword,
                                    controller: _password,
                                    obscureText: true,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      errorStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: _height * 0.1,
                                  ),
                                  Container(
                                    height: _height * 0.08,
                                    child: SizedBox.expand(
                                      child: FlatButton(
                                        onPressed: () {
                                          loginUser();
                                        },
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 15.0,
                                          ),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontSize: _height * 0.03),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        "Does not have an account?",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        },
                                        child: Text(
                                          "SIGN UP",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.yellow),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: _height * 0.1,
                                  ),
                                ]),
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
              ));
  }

/**
 * Called to the back-end API when the user credential are given.Currently it gives the 
 * response 'LoginSuccess' for a successful login.After a successfrl login uder email is used as
 * key to the shared preferences.
 */
  Future<String> loginUser() async {
    try {
      User user = new User(
          username: _email.text.toString(),
          password: _password.text.toString());
      Response response = await http.post('user/login', data: user.toJson());

      _loginscaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(response.data.toString())),
      );

      if (response.data.toString() == "LoginSuccess") {
        prefs = await SharedPreferences.getInstance();

        prefs.setString('userEmail', _email.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatHome(_email.text)),
        );
      }
      return response.data;
    } catch (error) {
      _loginscaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ), // if a error occured a error will be shown to the user
      );
      // print(error);
    }

    return null;
  }
}
