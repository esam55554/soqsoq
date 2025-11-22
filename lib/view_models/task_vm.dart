import 'package:soqsoq/helpers/database_helper.dart';

import '../models/Task.dart';

class TaskVM{
  DatabaseHelper _databaseHelper =  DatabaseHelper.instance;
  TaskVM();
   getTasks () async{
    List<Map<String,dynamic>> data = await  _databaseHelper.getFromTable(tableName: "tasks");
    List<Task> tasks = data.map((t)=> Task.fromMap(t)).toList();
    return tasks;
  }
}