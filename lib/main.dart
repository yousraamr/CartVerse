import 'package:cartverse/utils/custom_router.dart';
import 'package:cartverse/utils/route_names.dart';
import 'package:flutter/material.dart';

import 'view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      onGenerateRoute:CustomRouter.allRoutes,
      initialRoute: homeScreen,
    );
  }
}
