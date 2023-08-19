import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/database_cubit.dart';
import 'package:todo_app/widget/CustomTextFormField.dart';
import 'package:todo_app/widget/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyHomePage extends StatelessWidget {
  // int _selectedIndex = 0;

  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  var scafoldkey = GlobalKey<ScaffoldState>();
  var fromkey = GlobalKey<FormState>();

  // Color coloricon = Colors.blue;

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseCubit()..creatdb(),
      child: BlocConsumer<DatabaseCubit, DatabaseState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is DatabaseInsert) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scafoldkey,
            backgroundColor: Colors.white,
            body: Center(
              child: ConditionalBuilder(
                condition: State is! DatabaseLoading,
                builder: (context) {
                  return DatabaseCubit.get(context)
                      .widgetOptions
                      .elementAt(DatabaseCubit.get(context).selectedIndex);
                },
                fallback: (context) {
                  return const CircularProgressIndicator();
                },
                // child: _widgetOptions.elementAt(_selectedIndex)
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: DatabaseCubit.get(context).coloricon,
              onPressed: () {
                if (DatabaseCubit.get(context).shbootom) {
                  Navigator.pop(context);
                  DatabaseCubit.get(context)
                      .changeFloating(Floatingicon: Icons.edit, isshow: false);
                } else {
                  scafoldkey.currentState!
                      .showBottomSheet((context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 30),
                          child: Form(
                            key: fromkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    DatabaseCubit.get(context).creatdb();
                                    if (DatabaseCubit.get(context).shbootom &&
                                        fromkey.currentState!.validate()) {
                                      DatabaseCubit.get(context).insertdb(
                                        title: _titleController.text,
                                        date: _dateController.text,
                                        time: _timeController.text,
                                      );
                                        DatabaseCubit.get(context)
                                          .getdata(context)
                                          .then((value) {
                                        DatabaseCubit.get(context)
                                            .changeFloating(
                                          Floatingicon: Icons.edit,
                                          isshow: false,
                                          backgrundcolor: Colors.blue,
                                        );
                                      });
                                    } else {}
                                  }

                                  ,
                                  child: const Text(
                                    '✔',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTextFormField(
                                  controller: _titleController,
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  onChanged: (value) {},
                                  onFieldSubmitted: (value) {},
                                  onTap: () {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  hintText: "Title",
                                  prefixIconData: Icons.title,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomTextFormField(
                                  readOnly: true,
                                  controller: _dateController,
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  onChanged: (value) {},
                                  onFieldSubmitted: (value) {},
                                  onTap: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2023-12-31"),
                                    );
                                    if (selectedDate != null) {
                                      final formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(selectedDate);
                                      _dateController.text = formattedDate;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  hintText: "Date",
                                  prefixIconData: Icons.calendar_month_outlined,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                CustomTextFormField(
                                  readOnly: true,
                                  controller: _timeController,
                                  keyboardType: TextInputType.name,
                                  obscureText: false,
                                  onChanged: (value) {},
                                  onFieldSubmitted: (value) {},
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        _timeController.text =
                                            value.format(context).toString();
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  hintText: "Time",
                                  prefixIconData: Icons.access_alarm,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                      .closed
                      .then((value) {
                        DatabaseCubit.get(context).changeFloating(
                            Floatingicon: Icons.edit,
                            isshow: false,
                            backgrundcolor: Colors.blue);
                        // setState(() {
                        //   fIcon = Icons.edit;
                        //   coloricon = Colors.blue;
                        // });
                      });
                  DatabaseCubit.get(context).changeFloating(
                      backgrundcolor: Colors.red,
                      Floatingicon: Icons.close,
                      isshow: true); // setState(() {
                  //   fIcon = Icons.close;
                  //   coloricon = Colors.red;
                  // });
                }
              },
              child: Icon(DatabaseCubit.get(context).fIcon),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      rippleColor: Colors.grey[300]!,
                      hoverColor: Colors.grey[100]!,
                      gap: 8,
                      activeColor: Colors.black,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100]!,
                      color: Colors.black,
                      tabs: const [
                        GButton(
                          icon: Icons.menu,
                          text: 'Tasks',
                        ),
                        GButton(
                          icon: Icons.check_circle_outline,
                          text: 'Done',
                        ),
                        GButton(
                          icon: Icons.archive_outlined,
                          text: 'Archive',
                        ),
                      ],
                      selectedIndex: DatabaseCubit.get(context).selectedIndex,
                      onTabChange: (index) {
                        DatabaseCubit.get(context).changeindex(
                          index,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
