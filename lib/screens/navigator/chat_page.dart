import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombarProvider.dart';
import 'matching_page.dart';


class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("채팅"),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}

