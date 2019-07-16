import 'package:flutter/material.dart';
import 'package:kamus_maluku/utils/database_helper.dart';
import 'package:kamus_maluku/models/kamus.dart';
import 'package:sqflite/sqflite.dart';

class GetList extends StatefulWidget {
  @override
  _GetListState createState() => _GetListState();
}

class _GetListState extends State<GetList> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Kamus> listofKamus;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (listofKamus == null) {
      listofKamus = new List<Kamus>();
      updateListKamus();
    }

    if (listofKamus.isNotEmpty) {
      return ListView.separated(
        separatorBuilder: (context, i) => Divider(
              color: Colors.black12,
              height: 5.0,
            ),
        itemCount: this.count,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(this.listofKamus[i].kata ?? ''),
            subtitle: Text(this.listofKamus[i].makna ?? ''),
            trailing: GestureDetector(
              child: (this.listofKamus[i].penanda == 0)
                  ? Icon(
                      Icons.star_border,
                      color: Colors.grey[400],
                    )
                  : Icon(
                      Icons.star,
                      color: Colors.amber[500],
                    ),
              onTap: () {
                updatePenanda(i);
              },
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          'Belum ada penanda...',
          style: TextStyle(color: Colors.red[500]),
        ),
      );
    }
  }

  void updatePenanda(int i) {
    Kamus aturPenanda = this.listofKamus[i];
    if (aturPenanda.penanda == 0) {
      aturPenanda.penanda = 1;
    } else {
      aturPenanda.penanda = 0;
    }
    databaseHelper.aturPenanda(aturPenanda);
    updateListKamus();
  }

  void updateListKamus() {
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database) {
      Future<List<Kamus>> kamusListFuture;
      // if (widget.screen == 'MainScreen') {
      // kamusListFuture = databaseHelper.getListofKamus(widget.search);
      // } else {
      kamusListFuture = databaseHelper.getBookmarkofKamus();
      // }
      kamusListFuture.then((kamusList) {
        setState(() {
          this.listofKamus = kamusList;
          this.count = kamusList.length;
        });
      });
    });
  }
}
