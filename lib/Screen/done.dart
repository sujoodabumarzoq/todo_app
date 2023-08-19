import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/database_cubit.dart';
import '../widget/custom task.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  _DoneState createState() => _DoneState();
}
 int Number = 0;
class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatabaseCubit, DatabaseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = DatabaseCubit.get(context).Donetasks;

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
