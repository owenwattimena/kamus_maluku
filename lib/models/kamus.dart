class Kamus {
  int _id;
  String _kata;
  String _makna;
  int _penanda;

  Kamus(this._kata, this._makna, this._penanda);
  Kamus.withId(this._kata, this._makna, this._penanda);
  // geter
  int get id => _id;
  String get kata => _kata;
  String get makna => _makna;
  int get penanda => _penanda;

  // seter
  set penanda(int newPenanda) {
    this._penanda = newPenanda;
  }

  // Conver objek Kamus menjadi objek Map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['kata'] = _kata;
    map['makna'] = _makna;
    map['penanda'] = _penanda;
    return map;
  }

  // Convert Map object menjadi object
  Kamus.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kata = map['kata'];
    this._makna = map['makna'];
    this._penanda = map['penanda'];
  }
}
