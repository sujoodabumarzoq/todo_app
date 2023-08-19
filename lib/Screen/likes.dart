// import 'package:flutter/material.dart';
// import 'package:todo_app/widget/constants.dart';
// import 'package:todo_app/widget/custom%20task.dart';
//
// class Likes extends StatefulWidget {
//   const Likes({Key? key}) : super(key: key);
//
//   @override
//   _LikesState createState() => _LikesState();
// }
//
// class _LikesState extends State<Likes> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         itemBuilder: (context, index) {
//           return  CustomTask(tasks![index]);
//         },
//         separatorBuilder: (context, index) {
//           return Container(
//             height: 1.0,
//             width: double.infinity,
//             color: Colors.grey[300],
//           );
//         },
//         itemCount: 10);
//     //CustomTask();
//   }
// }
