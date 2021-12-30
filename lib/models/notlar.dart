class Not {
  late int notID;
  late int kategoriID;
  late String notBaslik;
  late String notIcerik;
  late String notTarih;
  late int notOncelik;

  Not(this.kategoriID, this.notBaslik, this.notIcerik, this.notTarih,
      this.notOncelik);

  Not.withID(this.notID, this.kategoriID, this.notBaslik, this.notIcerik,
      this.notTarih, this.notOncelik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['notID'] = this.notID;
    map['kategoriID'] = this.kategoriID;
    map['notBaslik'] = this.notBaslik;
    map['notIcerik'] = this.notIcerik;
    map['notTarih'] = this.notTarih;
    map['notOncelik'] = this.notOncelik;

    return map;
  }

  Not.formMap(Map<String, dynamic> map) {
    this.notID = map['notID'];
    this.kategoriID = map['kategoriID'];
    this.notBaslik = map['notBaslik'];
    this.notIcerik = map['notIcerik'];
    this.notTarih = map['notTarih'];
    this.notOncelik = map['notOncelik'];
  }

  @override
  String toString() {
    return 'Not(notID: $notID, kategoriID: $kategoriID, notBaslik: $notBaslik, notIcerik: $notIcerik, notTarih: $notTarih, notOncelik: $notOncelik)';
  }
}
