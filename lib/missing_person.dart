class MissingPerson {
  final String nameOfMissing;
  final String lastSeen;
  final String phone;
  final String name;
  final String age;
  final String address;

  MissingPerson(
      {this.nameOfMissing,
      this.lastSeen,
      this.phone,
      this.name,
      this.age,
      this.address});

  factory MissingPerson.fromJson(Map<String, dynamic> json) {
    return MissingPerson(
        name: json['name'],
        nameOfMissing: json['nameofmissing'],
        lastSeen: json['lastseen'],
        age: json['age'],
        address: json['adress'],
        phone: json['phone']);
  }

  static List<MissingPerson> fromList(List json) {
    return json.map((e) => MissingPerson.fromJson(e)).toList(growable: true);
  }
}
