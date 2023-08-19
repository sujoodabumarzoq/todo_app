import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Screen/archive.dart';
import 'package:todo_app/Screen/done.dart';
import 'package:todo_app/Screen/new_task.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  static DatabaseCubit get(BuildContext context) {
    return BlocProvider.of<DatabaseCubit>(context);
  }

  int selectedIndex = 0;
  List<Map> Newtask = [];

  List<Map> Donetasks = [];

  List<Map> Archivetasks = [];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> widgetOptions = <Widget>[
    NewTask(),
    const Done(),
    const Archive(),
  ];

  String path = "dbtodo";
  Database? database;

  void creatdb() {
    openDatabase(path, version: 1, onCreate: (db, version) async {
      print("creat");
      await db.execute('''CREATE TABLE Todo (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Title TEXT NOT NULL,
  data TEXT,
  time TEXT,
  status TEXT
)''');
      print("creat");
    }, onOpen: (database) {
      getdata(database);
      print("open ");
    }).then((value) {
      emit(Databasecreat());
      database = value;
    });
  }

  insertdb({
    required String title,
    required String time,
    required String date,
  }) {
    database?.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Todo(Title, data, time, status) VALUES("$title", "$time", "$date", "new")');
    }).then((value) {
      emit(DatabaseInsert());

      getdata(database);
    }).catchError((onError) {
      print("$onError: no success");
    });
  }

  getdata(database) {
    Newtask = [];
    Donetasks = [];
    Archivetasks = [];

    emit(DatabaseLoading());

    database.rawQuery('SELECT * FROM Todo').then((value) {
      print("$value");

      value.forEach((element) {
        print(element['status']);
        if (element['status'] == "new") {
          Newtask.add(element);
        } else if (element['status'] == "Done")
          Donetasks.add(element);
        else
          Archivetasks.add(element);
      });

      emit(DatabaseGet());
    });
  }

  void changeindex(int Index) {
    selectedIndex = Index;
    emit(changebootom());
  }

  bool shbootom = false;
  IconData fIcon = Icons.edit;
  Color coloricon = Colors.blue;

  void changeFloating({
    isshow,
    Floatingicon,
    backgrundcolor,
  }) {
    shbootom = isshow;
    fIcon = Floatingicon;
    coloricon = backgrundcolor;
    emit(changeFloatingActionButton());
  }

  bool isChecked = false;

  void Checkbox({
    Checked,
  }) {
    isChecked = !isChecked; // تغيير قيمة isChecked بين true و false
    emit(DatabaseCheckbox());
  }

  void update({
    required String status,
    required int id,
  }) async {
    // قم بتحديث حالة المهمة في قاعدة البيانات
    await database?.rawUpdate("UPDATE Todo SET status = ? WHERE id = ?",
        ["$status", id]).then((value) {
      // بعد نجاح التحديث في قاعدة البيانات، قم بتحديث القوائم (Newtask، Donetasks، Archivetasks)
      getdata(database);

      // بعد ذلك، قم بإصدار الحالة الجديدة لإعادة بناء واجهة المستخدم
      emit(DatabaseUpdate());
    });
  }

}
