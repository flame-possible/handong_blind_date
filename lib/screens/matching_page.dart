import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombar_provider.dart';

class MatchingPage extends StatelessWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("매칭"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text("NEXT"),
          ),
          Card(
            child: Text("This is a card \n\n\n\n\n\n\n\n\n\n\n\Next"),
          )
        ],
      ),
    );
  }
}
