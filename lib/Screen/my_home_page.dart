import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/CustomTextFormField.dart';
import 'package:todo_app/Screen/likes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Database? database;

  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  var scafoldkey = GlobalKey<ScaffoldState>();
  var fromkey = GlobalKey<FormState>();
  bool shbootom = false;
  IconData fIcon = Icons.edit;
  Color coloricon = Colors.blue;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Likes(),
    Text(
      'Search',
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    creatdb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldkey,
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: coloricon, // تحديد لون الزر

        onPressed: () {
          if (shbootom) {
            Navigator.pop(context);
            shbootom = false;
            setState(() {
              fIcon = Icons.edit;
              coloricon = Colors.blue;
            });
          } else {
            scafoldkey.currentState!.showBottomSheet((context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Form(
                  key: fromkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (shbootom && fromkey.currentState!.validate()) {
                            await insertdb(
                              title: _titleController.text,
                              date: _dateController.text,
                              time: _timeController.text,
                            );
                            Navigator.pop(context);
                            shbootom = false;
                            setState(() {
                              fIcon = Icons.edit;
                              coloricon = Colors.blue;
                            });
                          }
                        },
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
                            DateFormat('dd/MM/yyyy').format(selectedDate);
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
            }).closed.then((value) {
              shbootom = false;
              setState(() {
                fIcon = Icons.edit;
                coloricon = Colors.blue;
              });
            });
            shbootom = true;
            setState(() {
              fIcon = Icons.close;
              coloricon = Colors.red;
            });
          }
        },
        child: Icon(fIcon),
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
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    text: 'Search',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String path = "dbtodo";

  Future<void> creatdb() async {
    database =
    await openDatabase(path, version: 1, onCreate: (db, version) async {
      print("creat");
      await db.execute('''CREATE TABLE Todo (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Title TEXT NOT NULL,
  data TEXT,
  time TEXT,
  status TEXT
)''');
      print("creat");
    }, onOpen: (db) {
      print("open ");
      getdata(db);
    });
  }

  Future<void> insertdb({
    required String title,
    required String time,
    required String date,
  }) async {
    await database
        ?.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Todo(Title, data, time, status) VALUES("$title", "$time", "$date", "sujood")');
    })
        .then((value) => print("$value: success"))
        .catchError((onError) {
      print("$onError: no success");
    });
  }

  Future<    List<Map>> getdata(db) async {
return await database!.rawQuery('SELECT * FROM Todo');

  }
}