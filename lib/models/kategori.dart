class Kategori {
  int? kategoriID;
  String? kategoriBaslik;

  //kategori eklerken kullan, çünkü id veritanından otomatik ekleniyor.
  Kategori(this.kategoriBaslik);

  // veri tarabanında veri çekerken kullan.
  Kategori.withID(this.kategoriID, this.kategoriBaslik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['kategoriID'] = this.kategoriID;
    map['kategoriBaslik'] = this.kategoriBaslik;

    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    this.kategoriID = map['kategoriID'];
    this.kategoriBaslik = map['kategoriBaslik'];
  }

  @override
  String toString() =>
      'Kategori(kategoriID: $kategoriID, kategoriBaslik: $kategoriBaslik)';
}
