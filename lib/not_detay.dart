import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String? baslik;

  NotDetay({Key? key, this.baslik}) : super(key: key);

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  List<Kategori>? tumKategoriler;
  DatabaseHelper? databaseHelper;
  int? kategoriID = 1;

  @override
  void initState() {
    super.initState();
    tumKategoriler = <Kategori>[];
    databaseHelper = DatabaseHelper();
    databaseHelper!.kategorileriGetir().then((kategoriIcerenMapListesi) {
      setState(() {
        for (var okunanMap in kategoriIcerenMapListesi) {
          tumKategoriler!.add(Kategori.fromMap(okunanMap));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.baslik!)),
      body: tumKategoriler!.length <= 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const Text("Kategori : "),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: kategoriItemleriGetir(),
                              value: kategoriID,
                              onChanged: (int? secilenKategoriID) {
                                setState(() {
                                  kategoriID = secilenKategoriID;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemleriGetir() {
    return tumKategoriler!
        .map(
          (kategori) => DropdownMenuItem<int>(
            value: kategori.kategoriID,
            child: Text(kategori.kategoriBaslik!),
          ),
        )
        .toList();
  }
}
