import 'package:flutter/material.dart';

class NotDetay extends StatefulWidget {
  String? baslik;

  NotDetay({Key? key, this.baslik}) : super(key: key);

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.baslik!))),
      body: Container(),
    );
  }
}
