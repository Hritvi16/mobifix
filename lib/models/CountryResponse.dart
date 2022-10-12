class CountryResponse {
  CountryResponse({
      List<Country>? country,}){
    country = country;
}

  CountryResponse.fromJson(dynamic json) {
    if (json['country'] != null) {
      country = [];
      json['country'].forEach((v) {
        country?.add(Country.fromJson(v));
      });
    }
  }

  List<Country>? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (country != null) {
      map['country'] = country?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Country {
  Country({
      String? id, 
      String? name, 
      String? code,}){
    id = id;
    name = name;
    code = code;
}

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  String? id;
  String? name;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    return map;
  }

}