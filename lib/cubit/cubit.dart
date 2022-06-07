import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/component/constant.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:todoapp/modules/archivedTask.dart';
import 'package:todoapp/modules/doneTask.dart';
import 'package:todoapp/modules/newTask.dart';

class cubitApp extends Cubit<states> {
  cubitApp() : super(initialState());

  static cubitApp get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  List<String> titles = ['New Task', 'Done Task', 'Archive Task'];
  List<Widget> screens = [NewTask(), ArchivedTask(), DoneTask()];

  void change(int index) {
    currentIndex = index;
    emit(changeBottomNavBarState());
  } //change

  late Database database;
  List<Map> newTasks = [];
  List<Map> archiveTasks = [];
  List<Map> doneTasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      print('Database Created');
      await database
          .execute('CREATE TABLE task (id INTEGER PRIMARY KEY ,title TEXT,'
              'data TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when Table is created ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(createDatabaseState());
    });
  }

  insertoDatabase(
      {required String title, required String time, required date}) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO task(title,data,time,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(insertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserted new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(loadingDatabaseState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(getFromDatabaseState());
    });
  }

  IconData iconfab = Icons.edit;
  bool isbottomSheetShown = false;

  void changeIconBottomSheet({required icon, required isShown}) {
    iconfab = icon;
    isbottomSheetShown = isShown;
    emit(changeIcon());
  }

  void updataDataBase({required String status, required int id}) async {
    database.rawUpdate(
        'Update task SET status=? WHERE id=?', ['$status', id]).then((value) {
      getFromDatabaseState();
      emit(updateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(deleteDatabaseState());
    });
  }
}
