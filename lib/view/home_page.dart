import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
      ),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Welcome to CartVerse!'),
      ),
    );
  }
}
