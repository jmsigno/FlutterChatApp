import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/auth/register.dart';
import 'package:chatapp/screens/validation/validation.dart';

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

  BuildContext _scaffoldContext;
  TextEditingController _email = TextEditingController();
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    // _email.text = "sa@gmail.com";
    // _password.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _loginscaffoldKey,
        body: Form(
          key: loginFormKey,
          autovalidate: autoValidate,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                // image: DecorationImage(
                //   colorFilter: ColorFilter.mode(
                //       Colors.black.withOpacity(0.1), BlendMode.dstATop),
                //   image: AssetImage('images/chat.jpg'),
                //   fit: BoxFit.fitHeight,
                // ),
              ),
              child: !submitted
                  ? ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
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
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
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
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
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
                                  // TODO:
                                  // onPressed: login,
                                  onPressed: () {
                                    // if (loginFormKey.currentState.validate()) {}
                                    // setState(() {
                                    //   autoValidate = true;
                                    // });
                                    loginUser();
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 15.0,
                                    ),
                                    child: Text(
                                      "Login",
                                      style:
                                          TextStyle(fontSize: _height * 0.03),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            builder: (context) => Register()));
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

  Future<String> loginUser() async {
    try {
      User user = new User(
          username: _email.text.toString(),
          password: _password.text.toString());
      Response response = await http.post('user/login', data: user.toJson());
      print(
          "registration request *****************" + user.toJson().toString());
      print("registration response *****************");
      print(response.data.toString());

      _loginscaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(response.data.toString())),
      );

      return response.data;
    } catch (error) {
      _loginscaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
      print(error);
    }

    return null;
  }
}
