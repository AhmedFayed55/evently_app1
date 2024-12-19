import 'package:evently_app/tabs/profile_tab/profile.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ProfileTab.routeName,
      routes: {
        ProfileTab.routeName : (context) => ProfileTab(),
      },
    );
  }
}
