import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/network_utils/api.dart';
import 'package:flutter_project/screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isLoading = false;
  var name;
  var email;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _setDatas();
    super.initState();
  }

  void _setDatas() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user') ?? "";
    if (user != null) {
      var jsonUser = jsonDecode(user);
      setState(() {
        name = jsonUser['name'];
        email = jsonUser['email'];
      });
    }
  }

  void _logout() async {
    setState(() {
      _isLoading = true;
    });

    var res = await Network().postData([], '/logout');
    var body = json.decode(res.body);
    print(body);
    if (body['message']!=null) {
      _showMsg(body['message']);
    }
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', '');
    localStorage.setString('user', '');
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => Login()),
    );
    setState(() {
      _isLoading = false;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        title: Column(
          children: [
            Align(alignment: Alignment.centerLeft, child: Text(name ?? "")),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(email ?? "",
                    style: TextStyle(
                      fontSize: 10,
                    )))
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: TextButton(
                  onPressed: () => {_logout()},
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      _isLoading ? 'En cours' : 'Deconnexion',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
