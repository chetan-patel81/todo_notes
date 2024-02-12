import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/notes_model.dart';

class DbHandler {
  Database? _database;

  Future<Database> get getDataBase async {
    if (_database != null) return _database!;
    _database = await initDataBase();
    return _database!;
  }

  initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, '_database');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT,  date TEXT, category TEXT,time TEXT )',
    );
  }

  createNote(NotesModel notesModel) async {
    DbHandler dbHelper = DbHandler();
    Database db = await dbHelper.getDataBase;
    await db.insert('notes', notesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//***    READ OPERATION    ***//

  Future<List<NotesModel>> getNotes() async {
    DbHandler dbHelper = DbHandler();
    Database db = await dbHelper.getDataBase;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (index) {
      return NotesModel(
        id: maps[index]['id'],
        title: maps[index]['title'],
        notes: maps[index]['note'],
        date: maps[index]['date'],
        category: maps[index]['category'],
        time: maps[index]['time'],
      );
    });
  }

//***    UPDATE OPERATION    ***//

  Future<void> updateNotes(NotesModel notesModel) async {
    DbHandler dbHelper = DbHandler();
    Database db = await dbHelper.getDataBase;
    await db.update("notes", notesModel.toMap(),
        where: 'id = ?', whereArgs: [notesModel.id]);
  }

//***    DELETE OPERATION    ***//
  Future<void> deleteNotesByIndex(int index) async {
    DbHandler dbHelper = DbHandler();
    Database db = await dbHelper.getDataBase;
    List<Map<String, dynamic>> notesModel = await db.query("notes");
    if (index >= 0 && index < notesModel.length) {
      await db.delete("notes",
          where: 'id = ?', whereArgs: [notesModel[index]['id']]);
    }
  }

//category according save created note
  Future<List<NotesModel>> getNotesByCategory(String category) async {
    DbHandler dbHelper = DbHandler();
    Database db = await dbHelper.getDataBase;
    final List<Map<String, dynamic>> maps =
        await db.query('notes', where: 'category = ?', whereArgs: [category]);

    return List.generate(maps.length, (index) {
      return NotesModel(
        id: maps[index]['id'],
        title: maps[index]['title'],
        notes: maps[index]['note'],
        date: maps[index]['date'],
        category: maps[index]['category'],
        time: maps[index]['time'],
      );
    });
  }
}
