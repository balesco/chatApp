import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Contact extends StatefulWidget{
  const Contact({super.key});
  @override
  _ContactState createState()=> _ContactState();
}

class _ContactState extends State<Contact>{
  var contactList = [];
  @override
  void initState() {
    _getContacts();
    super.initState();
  }
  void _getContacts()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final String tokenString = localStorage.getString('token')??"";
    tokenString;
    var response = await http.get(
      Uri.parse('http://3.72.4.127/api/users'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenString'
      }
    );
    var data = json.decode(response.body??"");
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Contacts",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Recherche...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: contactList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Text("Bonjour");
              }
            ),

          ],
        ),
      ),
    );
  }
}