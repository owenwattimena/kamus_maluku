import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:kamus_maluku/models/kamus.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tbKamus = 'bahasa';
  String colId = 'id';
  String colKata = 'kata';
  String colMakna = 'makna';
  String colPenanda = 'penanda';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    // ambil direktori aplikasi di smartphone
    var dbDir = await getApplicationDocumentsDirectory();
    var dbPath = join(dbDir.path, 'app.sql');
    // var dbDir = await getDatabasesPath();
    // var dbPath = join(dbDir, 'app.db');

    // Copy database dari asset ke direktori smartphone jika database tidak tersedia
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      // ambil database dari asset kemudian Copy
      ByteData data =
          await rootBundle.load(join('assets', 'database', 'my_kamus.sqlite'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // simpan hasil copy ke direktori
      await File(dbPath).writeAsBytes(bytes);
    }
    var db = await openDatabase(dbPath);
    // return getDB();
    return db;
  }

  // Future<Database> getDB() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String databasePath = join(appDocDir.path, 'app.db');
  //   var db = await openDatabase(databasePath);
  //   return db;
  // }

  // ambil semua data kamus
  Future<List<Map<String, dynamic>>> getAllDatas() async {
    Database db = await this.database;
    var result = await db.query(tbKamus);
    /*,
        where: "$colKata != ?", whereArgs: [''], orderBy: '$colKata');*/
    return result;
  }

  // ambil semua data Penanda
  Future<List<Map<String, dynamic>>> getAllBookmarks() async {
    Database db = await this.database;
    var result =
        await db.rawQuery("SELECT * FROM $tbKamus WHERE $colPenanda=1");
    return result;
  }

  // ambil data yang dicari
  Future<List<Map<String, dynamic>>> getSearchDatas(String search) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT * FROM $tbKamus WHERE $colKata LIKE '%$search%' OR $colMakna LIKE '%$search%' ORDER BY $colKata ASC");
    return result;
  }

  // perbarui penanda
  Future<int> aturPenanda(Kamus kamus) async {
    Database db = await this.database;

    var result = await db.update(tbKamus, kamus.toMap(),
        where: '$colId = ?', whereArgs: [kamus.id]);
    return result;
  }

  // Extract Map object to kamus object --> Penanda
  Future<List<Kamus>> getBookmarkofKamus() async {
    var kamusMapList;
    kamusMapList = await getAllBookmarks();
    int count = kamusMapList.length;

    List<Kamus> kamusList = new List<Kamus>();
    for (var i = 0; i < count; i++) {
      kamusList.add(Kamus.fromMapObject(kamusMapList[i]));
    }
    return kamusList;
  }

  // Extract Map object to kamus object
  Future<List<Kamus>> getListofKamus(String search) async {
    var kamusMapList;
    if (search.isEmpty) {
      kamusMapList = await getAllDatas();
    } else {
      kamusMapList = await getSearchDatas(search);
    }
    int count = kamusMapList.length;

    List<Kamus> kamusList = new List<Kamus>();
    for (var i = 0; i < count; i++) {
      kamusList.add(Kamus.fromMapObject(kamusMapList[i]));
    }
    return kamusList;
  }
}
