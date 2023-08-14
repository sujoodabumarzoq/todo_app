import 'package:flutter/material.dart';
import 'package:todo_app/widget/constants.dart';

import '../widget/custom task.dart';

class NewTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return  CustomTask(tasks ![index]);
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          );
        },
        itemCount: tasks!.length
    );
  }
}
