import 'package:flutter/material.dart';
import 'package:kamus_maluku/widget/widget.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Scaffold.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text('Penanda'),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: GetList(),
        ),
      ),
    );
  }
}
