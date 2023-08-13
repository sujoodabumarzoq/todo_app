import 'package:flutter/material.dart';
import 'package:todo_app/widget/custom%20task.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);
  @override
  ArchiveState createState() => ArchiveState();
}

class ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return const CustomTask();
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          );
        },
        itemCount: 10);
  }
}
