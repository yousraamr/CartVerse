import 'package:cartverse/utils/custom_router.dart';
import 'package:cartverse/utils/route_names.dart';
import 'package:flutter/material.dart';

import 'view/home_page.dart';
import 'utils/cache_helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
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
