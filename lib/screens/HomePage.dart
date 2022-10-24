import 'package:flutter/material.dart';

import 'chatPage.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage()
    );
  }
}