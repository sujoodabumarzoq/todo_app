import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screen/likes.dart';
import 'package:todo_app/widget/constants.dart';

import 'Screen/my_home_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  MyHomePage(),
        );

  }
}
