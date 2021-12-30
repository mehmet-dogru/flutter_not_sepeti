import 'package:flutter/material.dart';
import 'package:flutter_not_sepeti/models/kategori.dart';
import 'package:flutter_not_sepeti/utils/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotListesi(),
    );
  }
}

class NotListesi extends StatelessWidget {
  NotListesi({Key? key}) : super(key: key);

  DatabaseHelper? databaseHelper = DatabaseHelper();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(
          child: Text('Not Listesi'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Kategori Ekle',
            onPressed: () {
              kategoriEkleDialog(context);
            },
            child: const Icon(Icons.bookmark_add_rounded),
            mini: true,
          ),
          FloatingActionButton(
            tooltip: 'Not Ekle',
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }

  void kategoriEkleDialog(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String? yeniKategoriAdi;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              'Kategori Ekle',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (newValue) {
                      yeniKategoriAdi = newValue;
                    },
                    validator: (girilenKategoriAdi) {
                      if (girilenKategoriAdi!.length < 3) {
                        return 'En az 3 karakter giriniz.';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Kategori Adı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Vazgeç')),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          databaseHelper!
                              .kategoriEkle(Kategori(yeniKategoriAdi!))
                              .then((kategoriID) {
                            if (kategoriID > 0) {
                              _scaffoldKey.currentState!.showSnackBar(
                                const SnackBar(
                                  content: Text('Kategori Eklendi.'),
                                ),
                              );
                            }
                          });
                        }
                      },
                      child: const Text('Kaydet')),
                ],
              )
            ],
          );
        });
  }
}
