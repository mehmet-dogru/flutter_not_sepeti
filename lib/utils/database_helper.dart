import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/models/notlar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "notlarApp.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "notlar.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, Object?>>> kategorileriGetir() async {
    var db = await _getDatabase();
    var sonuc = db.query('kategori');

    return sonuc;
  }

  Future<int> kategoriEkle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = db.insert("kategori", kategori.toMap());

    return sonuc;
  }

  Future<int> kategoriGuncelle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = db.update("kategori", kategori.toMap(),
        where: 'kategori = ?', whereArgs: [kategori.kategoriID]);
    return sonuc;
  }

  Future<int> kategoriSil(int kategoriID) async {
    var db = await _getDatabase();
    var sonuc =
        db.delete("kategori", where: 'kategori = ?', whereArgs: [kategoriID]);
    return sonuc;
  }

  /*Not data*/
  Future<List<Map<String, Object?>>> notlariGetir() async {
    var db = await _getDatabase();
    var sonuc = db.query('not', orderBy: 'notID DESC');

    return sonuc;
  }

  Future<int> notEkle(Not not) async {
    var db = await _getDatabase();
    var sonuc = db.insert("not", not.toMap());

    return sonuc;
  }

  Future<int> notGuncelle(Not not) async {
    var db = await _getDatabase();
    var sonuc =
        db.update("not", not.toMap(), where: 'not = ?', whereArgs: [not.notID]);
    return sonuc;
  }

  Future<int> notSil(int notID) async {
    var db = await _getDatabase();
    var sonuc = db.delete("not", where: 'not = ?', whereArgs: [notID]);
    return sonuc;
  }
}
