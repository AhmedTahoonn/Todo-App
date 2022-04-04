import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeee/modules/archived_tasks/Archived.dart';
import 'package:noteeee/modules/done_tasks/Done.dart';
import 'package:noteeee/modules/new_tasks/New.dart';
import 'package:noteeee/provider/states.dart';
import 'package:sqflite/sqflite.dart';

class Todo_cuibt extends Cubit<TodoStates> {
  Todo_cuibt() : super(initial_State());

  static Todo_cuibt get(context) => BlocProvider.of(context);
  var currentIndex = 0;
  IconData fabIcon=Icons.edit;

  List <Widget> screens =
  [
    New_tasks(),
    Done_tasks(),
    Archives_tasks(),
  ];
  List<Map>newTasks = [];
  List<Map>archiveTasks = [];
  List<Map>doneTasks = [];

  late Database database;
///////////////////////////////////////////////////////////////////////////////
  void createDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error when table created${error.toString()}');
          });
        },
        onOpen: (database) {
          getDataFromDatabase(database);
          print(('database opened'));
        }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
////////////////////////////////////////////////////////////////////////////////
  Future InsertDatabase({
    required String title,
    required String time,
    required String date,

  }) async {
    database.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('inserted sucessfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserted${error.toString()}');
      });
    });
  }


  void getDataFromDatabase(database) async
  {
    newTasks = [];
    archiveTasks = [];
    doneTasks = [];
    emit(AppGetDatabaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {
        if(element['status']=='new')
          newTasks.add(element);
        else if(element['status']=='done')
          doneTasks.add(element);
        else
          archiveTasks.add(element);
      });

      emit(AppGetDataFromDatabaseState());
    });
  }
  //////////////////////////////////////////////////////////////////////////////

  void ChangeBottomNavigation(index) {
    currentIndex = index;
    emit(changeBottomNavigationBar());
  }
  //////////////////////////////////////////////////////////////////////////////

  void updateDatabase({
    required String status,
    required int id,

  })async
  {
     database.rawUpdate(
        'UPDATE tasks SET status= ? WHERE id= ?', [ status, id],

    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataFromDatabaseState());
     });

  }

///////////////////////////////////////////////////////////////////////////////

  void DeleteDatabase({
    required int id,

  })async
  {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?', [id],

    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }
  //////////////////////////////////////////////////////////////////////////////
  bool isdark=false;
  void changeAppMode()
  {
    isdark=!isdark;
    emit(AppModeChangeState());
    print(isdark);
  }
  //////////////////////////////////////////////////////////////////////////////




}