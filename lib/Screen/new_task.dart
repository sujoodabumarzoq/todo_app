import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/database_cubit.dart';
import 'package:todo_app/widget/constants.dart';
import 'package:todo_app/widget/constants.dart';
import 'package:todo_app/widget/constants.dart';

import '../widget/constants.dart';
import '../widget/constants.dart';
import '../widget/custom task.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = DatabaseCubit.get(context).Newtask;

        if (tasks == null) {
          return CircularProgressIndicator();
        }

        return Padding(
          padding: const EdgeInsets.only(left: 10, top: 50, right: 10),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return CustomTask(tasks![index], context);
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                );
              },
              itemCount: tasks!.length),
        );
      },
    );
  }
}
