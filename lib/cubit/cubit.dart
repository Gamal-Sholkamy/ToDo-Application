import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubit/states.dart';
import '../sceenes/archive_screen.dart';
import '../sceenes/done_screen.dart';
import '../sceenes/new_screen.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  ////////////// Bottom Nav Bar Cubit ///////////////
  List screens = [ DoneScreen(), NewScreen(),  ArchiveScreen()];
  List titles = [
    "Done Tasks",
    "New Tasks",
    "Archived Tasks",
  ];
  int currentIndex = 1;

  void changeCurrentIndexValue(int index) {
    currentIndex = index;
    emit(ToDoChangeCurrentIndexState());
  }

  /////////////  Database Structure  Cubit //////////////
  late Database database;
  List<Map<String, dynamic>>? tasks;
  List<Map<String, dynamic>>? newTasks;
  List<Map<String, dynamic>>? doneTasks;
  List<Map<String, dynamic>>? archiveTasks;
  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database database, int version) async {
      await database.execute('CREATE TABLE tasks'
          '(id INTEGER PRIMARY KEY ,title TEXT, date TEXT ,time TEXT ,status TEXT)');
    }, onOpen: (database) async {
      await getDataFromDatabase(database);
    }).then((value) {
      emit(ToDoCreateDatabaseState());
      return value;
    });
  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
            "INSERT INTO tasks (title,date,time,status) VALUES(?,?,?,?)",
            [title, date, time, 'New'],
          )
          .then((value) async {
            emit(ToDoInsertToDatabaseState());
            await getDataFromDatabase(database);
          })
          .catchError((e) {
            //print('insert error ::: $e');

          });
    });
  }

   Future<void> getDataFromDatabase(database) async {
    tasks = await database.rawQuery('SELECT * FROM tasks') as List<Map<String, dynamic>>;
    newTasks = tasks!.where((task) => task['status'] == 'New').toList();
    doneTasks = tasks!.where((task) => task['status'] == 'Done').toList();
    archiveTasks = tasks!.where((task) => task['status'] == 'Archive').toList();

    // newTasks = await database.rawQuery("SELECT * FROM tasks WHERE status = 'New'") as List<Map<String, dynamic>>;
    // doneTasks = await database.rawQuery("SELECT * FROM tasks WHERE status = 'Done'") as List<Map<String, dynamic>>;
    // archiveTasks = await database.rawQuery("SELECT * FROM tasks WHERE status = 'Archive'") as List<Map<String, dynamic>>;

    emit(ToDoGetFromDatabaseState());

  }

  void deleteFromDatabase(int taskId) async{
    await database.rawDelete('DELETE FROM tasks WHERE id=?',[taskId]);
    await getDataFromDatabase(database);

  }

  void updateINDatabase(int taskId, String status) async {
    await database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',[status, taskId]);
    await getDataFromDatabase(database);
  }

/////////////   End of Database Structure   //////////////
  bool isButtonSheetShow = false;
  IconData fabIcon = Icons.edit;

  void changeButtonSheetValue({
    required bool isShown,
    required IconData icon,
  }) {
    isButtonSheetShow = isShown;
    fabIcon = icon;
    emit(ToDoChangeBottomSheetState());
  }
}
