import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/cubit/database_cubit.dart';

Widget CustomTask(Map model,context) {

  return Padding(
    padding:  const EdgeInsets.only(left: 10, top: 15, bottom: 15,),
    child: Slidable(
      key:  const ValueKey(0),

      endActionPane:  ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',

          ),

        ],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){

              DatabaseCubit.get(context).update(
                status:  " Done",
                id: model["id"] ?? 0,
              );
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',

          ),

        ],
      ) ,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: Text(
                      ' ${model["data"]}',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ' ${model["Title"]}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' ${model["time"]}',

                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.start,
                    ),

            ],
                ),
        SizedBox(
          width: 50,
        ),


        Checkbox(
          value: DatabaseCubit.get(context).isChecked,
          onChanged: (bool? value) {
            DatabaseCubit.get(context).isChecked = value!;
            String newStatus = value ? "Done" : "new"; // تحديث الحالة بناءً على قيمة الـ Checkbox
            DatabaseCubit.get(context).update(
              status: newStatus,
              id: model["id"] ?? 0,
            );
          },
        ),
              ],
            ),
    ),

      );
  }

