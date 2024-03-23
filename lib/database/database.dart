import 'dart:io';

import 'package:curd_opration/model/ToduModel.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  static const tableName = "Todu";

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'cureOption.db');
    var db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
          create table $tableName(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           dec TEXT NOT NULL
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {
      // if(newVersion > oldVersion){
      //   db.execute('ALTER TABLE TblUser()');
      // }
    }, version: 1);
    return db;
  }

  Future<int> insert(Todu newTodu) async {
    Database db = await initDatabase();
    return await db.insert(tableName, Todu.toMap(newTodu));
  }

  Future<List<Todu>> getAllTodu() async {
    Database db = await initDatabase();
    List<Todu> todu = [];

    for (Map<String, dynamic> t in await db.query(tableName)) {
      todu.add(Todu.toJson(t));
    }
    return todu;
  }

  Future<int> updateTodu(Todu updateTodu) async {
    Database db = await initDatabase();

    return await db.update(tableName, Todu.toMap(updateTodu),
        where: 'id = ?', whereArgs: [updateTodu.id]);
  }

  Future<int> deleteTodu(int id) async {
    Database db = await initDatabase();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}





//
// class DBHelper{
//   static Database? _db;
//   static const dbTable = 'notes';



  // Future<NoteModel> insert(NoteModel noteModel)async{
  //   var dbClint = await db;
  //   await dbClint!.insert(dbTable, noteModel.toMap());
  //   return noteModel;
  // }

//   Future<List<NoteModel>> getNoteList () async{
//     var dbClient = await db;
//     final List<Map<String,dynamic>> queryResult = await dbClient!.query(dbTable);
//     return queryResult.map((e) => NoteModel.fromMap(e)).toList();
//   }
//
//   Future<int> delete(int id)async{
//     var dbClient = await db;
//     return await dbClient!.delete(dbTable,where: 'id = ?',whereArgs: [id]);
//   }
//
//   Future<int> update(NoteModel noteModel)async{
//     var dbClient = await db;
//     return await dbClient!.update(dbTable, noteModel.toMap(),where: 'id = ?',whereArgs: [noteModel.id]);
//   }
// }