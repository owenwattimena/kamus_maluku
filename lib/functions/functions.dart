// import 'package:kamus_maluku/utils/database_helper.dart';
// import 'package:kamus_maluku/models/kamus.dart';
// import 'package:sqflite/sqflite.dart';

// class Functions {
//   DatabaseHelper databaseHelper = new DatabaseHelper();

//   Future<List<Kamus>> updateKamusList(String search) async{
//     // List<Kamus> listofKamus = List<Kamus>();
//     // Database dbFuture = await databaseHelper.initDB();
//     // dbFuture.then((database) {
//     //   Future<List<Kamus>> kamusListFuture =
//     //       databaseHelper.getListofKamus(search);
//     //   kamusListFuture.then((kamusList) {
//     //     // setState(() {
//     //     listofKamus = kamusList;
//     //     // int count = kamusList.length;
//     //     // print(count);
//     //     // return kamusList;
//     //     // });
//     //   });
//     // });
//     List<Kamus> listofKamus = await databaseHelper.getListofKamus(search);
//     return listofKamus;
//   }
// }
