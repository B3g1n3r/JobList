import 'package:flutter/material.dart';
import 'package:job_management_app/screens/job_list.dart';
import 'package:job_management_app/screens/login.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/job_viewmodel.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => JobViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job App',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
