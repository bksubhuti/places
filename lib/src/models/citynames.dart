class CityName {
  final String name;
  final String lang;
  final int cityposrowid;

  CityName(
      {required this.name, required this.lang, required this.cityposrowid});

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(
        name: json['name'],
        lang: json['lang'],
        cityposrowid: json['cityposrowid']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lang': lang,
      'cityposrowid': cityposrowid,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'CityName{id: $name, name: $lang, age: $cityposrowid}';
  }
}// end of class




