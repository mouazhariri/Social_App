class Students {
  int? _id;
  String? _name;
  String? _deacription;
  int? _pass;
  String? _date;

  Students(
    this._name,
    this._deacription,
    this._pass,
    this._date,
  );
  Students.withId(
    this._id,
    this._name,
    this._deacription,
    this._pass,
    this._date,
  );

  int get id => this._id!;

  set id(int value) => this._id = value;

  get name => this._name;

  set name(value) => this._name = value;

  get deacription => this._deacription;

  set deacription(value) => this._deacription = value;

  get pass => this._pass;

  set pass(value) => this._pass = value;

  get date => this._date;

  set date(value) => this._date = value;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["name"] = this._name;
    map["date"] = this._date;
    map["deacription"] = this._deacription;
    map["pass"] = this._pass;
    return map;
  }

  Students.getMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._date = map["date"];
    this._deacription = map["deacription"];
    this._pass = map["pass"];
  }

  // @override
  // String toString() {
  //   return 'Students(_id: $_id, _name: $_name, _deacription: $_deacription, _pass: $_pass, _date: $_date)';
  // }
}
