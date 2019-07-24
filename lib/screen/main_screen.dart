import 'package:flutter/material.dart';
import 'package:kamus_maluku/utils/database_helper.dart';
import 'package:kamus_maluku/models/kamus.dart';
import 'package:kamus_maluku/screen/bookmark_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController mSearch = new TextEditingController();

  DatabaseHelper databaseHelper = new DatabaseHelper();

  List<Kamus> listofKamus;
  int count = 0;
  var snackBar;
  String url = 'http://owenwattimena.github.io';

  @override
  Widget build(BuildContext context) {
    if (listofKamus == null) {
      listofKamus = new List<Kamus>();
      updateKamusList(context, mSearch.text);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Kamus Maluku'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookmarkScreen()));
              // hideSnackBar();
              updateKamusList(context, mSearch.text);
            },
            icon: Icon(Icons.bookmark),
          ),
          IconButton(
            onPressed: () {
              // updateKamusList(mSearch.text);
              tampilkanDialog();
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 15,
              child: Container(
                // padding: EdgeInsets.only(right: 10),
                height: 40,
                child: Center(
                  child: TextField(
                    controller: mSearch,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cari...",
                      border: InputBorder.none,
                      fillColor: Colors.blue,
                      suffixIcon: (mSearch.text.isNotEmpty)
                          ? IconButton(
                              onPressed: () {
                                mSearch.text = "";
                                setState(() {
                                  updateKamusList(context, mSearch.text);
                                });
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border: Border.all(
                                      color: Colors.red[200], width: 1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red[200],
                                  size: 15,
                                ),
                              ),
                            )
                          : null,
                    ),
                    onChanged: (input) {
                      setState(() {
                        updateKamusList(context, input);
                      });
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: (listofKamus.isNotEmpty || mSearch.text.isEmpty)
                    ? getListView()
                    : notResult(),
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView getListView() {
    return ListView.separated(
      separatorBuilder: (context, i) => Divider(
        color: Colors.black12,
        height: 5.0,
      ),
      itemCount: this.count,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Text(this.listofKamus[i].kata ?? '',
              style: TextStyle(fontSize: 18)),
          subtitle: Text(this.listofKamus[i].makna ?? '',
              style: TextStyle(fontSize: 15)),
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
              updatePenanda(context, i);
            },
          ),
        );
      },
    );
  }

  Column notResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/tampayang_sopi.png"),
          // fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'Yah, \'' + mSearch.text + '\' tidak ditemukan',
          style: TextStyle(
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          'Coba cari kata yang lain, misalnya \'Beta\'',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ],
    );
  }

  void tampilkanDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tentang Kamus Maluku',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Kamus maluku adalah aplikasi yang dibuat untuk membantu masyarakat luas untuk mamahami bahasa Maluku. \nTerdapat 623 kata yang di muat dalam aplikasi ini.',
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    'Developer : Owen Wattimena\nDesign Advisor : Charla Sopacua',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Linkify(
                    text: '$url',
                    onOpen: (url) async {
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'can not launch $url';
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: OutlineButton(
                  color: Colors.red,
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 12.0, color: Colors.red[300]),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  void updatePenanda(BuildContext context, int i) {
    Kamus aturPenanda = this.listofKamus[i];
    Scaffold.of(context).hideCurrentSnackBar();
    String snackbarText;
    if (aturPenanda.penanda == 0) {
      aturPenanda.penanda = 1;
      snackbarText = 'Penanda ditambahkan...';
    } else {
      aturPenanda.penanda = 0;
      snackbarText = 'Penanda dilepas...';
    }
    databaseHelper.aturPenanda(aturPenanda);
    updateKamusList(context, mSearch.text);
    snackBar = SnackBar(content: Text(snackbarText));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateKamusList(BuildContext context, String search) {
    // Scaffold.of(context).hideCurrentSnackBar();
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database) {
      Future<List<Kamus>> kamusListFuture =
          databaseHelper.getListofKamus(search);
      kamusListFuture.then((kamusList) {
        setState(() {
          listofKamus = kamusList;
          count = kamusList.length;
        });
      });
    });
  }
}
