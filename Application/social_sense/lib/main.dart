import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/routes/route.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      getPages: Routes.pages,
      initialRoute: RouteNames.login,
      defaultTransition: Transition.noTransition,
    );
  }
}
