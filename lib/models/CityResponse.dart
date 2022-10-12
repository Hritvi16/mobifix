/// city : [{"id":"1","name":"Surat","stid":"1"},{"id":"2","name":"Ahmedabad","stid":"1"}]

class CityResponse {
  CityResponse({
      List<City>? city,}){
    city = city;
}

  CityResponse.fromJson(dynamic json) {
    if (json['city'] != null) {
      city = [];
      json['city'].forEach((v) {
        city?.add(City.fromJson(v));
      });
    }
  }
  List<City>? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (city != null) {
      map['city'] = city?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class City {
  City({
      String? id, 
      String? name, 
      String? stId,}){
    id = id;
    name = name;
    stId = stId;
}

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    stId = json['st_id'];
  }
  String? id;
  String? name;
  String? stId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['st_id'] = stId;
    return map;
  }

}