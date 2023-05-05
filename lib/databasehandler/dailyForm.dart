// For Directory
import 'dart:io';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:sqflite/sqflite.dart';

// For join()
import 'package:path/path.dart';
// For getApplicationDocumentsDirectory()
import 'package:path_provider/path_provider.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);

class DailyFormInput {
// Primary key:
  final int? dailyEntryid;
  final String? userid; //userid; //C_UserId from table userinfo      // Foreign key
  final int TS;             // Seconds since epoch of DateTime.now();
  final int TS_DATE;
  // Other fields:
  final double sleepQuality;
  final int sleepHours;
  final int sleepMinutes;
  // How do we store images???
  final String dailyDescription;
  final int stressLV;
  final String? didExercise;
  final String exerciseType;

  final int exerciseDurationMin;

  DailyFormInput({this.dailyEntryid, this.userid, required this.TS, required this.TS_DATE, required this.sleepQuality, required this.sleepHours, required this.sleepMinutes, required this.dailyDescription, required this.stressLV, required this.didExercise, required this.exerciseType, required this.exerciseDurationMin});

  factory DailyFormInput.fromMap(Map<String, dynamic> json) => DailyFormInput(
    dailyEntryid: json['dailyEntryid'],
    userid: json['userid'],
    TS: json['TS'],
    TS_DATE: json['TS_DATE'],
    sleepQuality: json['sleepquality'],
    sleepHours: json['sleepHours'],
    sleepMinutes: json['sleepMinutes'],
    // How do we store images???
    dailyDescription: json['dailyDescription'],
    stressLV: json['stressLV'],
    didExercise: json['didExercise'],
    exerciseType: json['exerciseType'],
    exerciseDurationMin: json['exerciseDurationMin'],
  );

  Map<String,dynamic> toMap(){
    return{
      'dailyEntryid': dailyEntryid,
      'userid':userid,
      'TS':TS,
      'TS_DATE':TS_DATE,
      'sleepQuality':sleepQuality,
      'sleepHours':sleepHours,
      'sleepMinutes':sleepMinutes,
      'dailyDescription':dailyDescription,
      'stressLV': stressLV,
      'didExercise': didExercise,
      'exerciseType': exerciseType,
      'exerciseDurationMin': exerciseDurationMin,
    };
  }
}

class DailyFormDBHelper{
  DailyFormDBHelper._privateConstructor();
  static final DailyFormDBHelper instance = DailyFormDBHelper._privateConstructor();

  static Database? _DailyFormDB;
  // Init DB if _DailyFormDB is null

  Future<Database> get database async => _DailyFormDB ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'dailyForm.db');

    return await openDatabase(
      path,
      version:1,
      onCreate: _onCreate,
    );
  }
  // Create Table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
        CREATE TABLE DailyForm(
          dailyEntryid INTEGER PRIMARY KEY AUTOINCREMENT,
          userid TEXT NOT NULL,     
          TS INT NOT NULL, 
          TS_DATE INT NOT NULL,
          sleepQuality DOUBLE,
          sleepHours INTEGER,
          sleepMinutes INTEGER,
          dailyDescription TEXT,
          stressLV INT,
          didExercise TEXT,
          exerciseType TEXT,
          exerciseDurationMin INT,
          UNIQUE(userid, TS)
        )
      '''
    );

    // FOREIGN KEY (userid) REFERENCES User(id)
  }


  Future dropTable(Database db, int version) async {
    await db.execute(
        '''
      Drop TABLE DailyForm
      '''
    );
  }

  fetchTableData() async{

    Database db = await instance.database;

    final result = await db.query('DailyForm',
        orderBy:'dailyEntryid DESC');

    // print(result);
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllUserEntries(String userId) async {
    Database db = await instance.database;
    var result = await db.query(
      'DailyForm',
      where: 'userid = ?',
      whereArgs: [userId],
    );

    // print(result);
    return result;
  }


  Future<Map<String, dynamic>?> fetchLatestDailyFormByUserId(String userId) async {
    final Database db = await instance.database;
    var result =  await db.query(
      'DailyForm',
      where: 'userid = ?',
      whereArgs: [userId],
      orderBy: 'TS DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      // print(result.first);
      return result.first;
    }

    return null;
  }

  Future<Map<String, dynamic>?> fetchLatestDailyFormByUserIdAndDate(String userId, DateTime date) async {
    final Database db = await instance.database;
    var date_ts = date.millisecondsSinceEpoch;
    int TS_DATE = (date_ts / 1000).round();

    var result = await db.rawQuery(
      '''
      SELECT * FROM DailyForm
      WHERE userid = ?
      AND TS_DATE = ?
      ORDER BY TS DESC
      LIMIT 1;
      ''',
      [userId, TS_DATE],
    );

    if (result.isNotEmpty) {
      // print(result.first);
      return result.first;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> fetchValidEntriesForUser(String userId) async {
    final db = await database;
    final results = await db.rawQuery(
      '''
        SELECT *
        FROM DailyForm AS DF1
        INNER JOIN (
          SELECT TS_DATE, MAX(TS) AS maxTS FROM DailyForm
          WHERE userid = ?
          GROUP BY TS_DATE
        ) AS DF2 ON DF1.TS_DATE = DF2.TS_DATE AND DF1.TS = DF2.maxTS
        WHERE DF1.userid = ?
      ''',
      [userId, userId]);
    // print(results);
    return results;
  }

  Future<int> add(DailyFormInput dailyFormInput) async{
    Database db = await instance.database;

    return await db.insert('DailyForm',dailyFormInput.toMap());
  }

}