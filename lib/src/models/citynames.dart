class CityName {
  String name;
  String lang;
  int cityposrowid;

  CityName(
      {required this.name, required this.lang, required this.cityposrowid});

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(
        name: json['name'],
        lang: json['lang'],
        cityposrowid: json['cityposrowid']);
  }
}
