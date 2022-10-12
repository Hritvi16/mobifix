class PackageResponse {
  PackageResponse({
      List<Package>? package,}){
    package = package;
}

  PackageResponse.fromJson(dynamic json) {
    if (json['package'] != null) {
      package = [];
      json['package'].forEach((v) {
        package?.add(Package.fromJson(v));
      });
    }
  }

  List<Package>? package;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (package != null) {
      map['package'] = package?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Package {
  Package({
      String? id, 
      String? name, 
      String? description,
      String? price,
      String? tenure, 
      String? createdBy, 
      String? createdAt, 
      String? updatedBy,
      String? updatedAt,}){
    id = id;
    name = name;
    description = description;
    price = price;
    tenure = tenure;
    createdBy = createdBy;
    createdAt = createdAt;
    updatedBy = updatedBy;
    updatedAt = updatedAt;
}

  Package.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    tenure = json['tenure'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? name;
  String? description;
  String? price;
  String? tenure;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['tenure'] = tenure;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    return map;
  }

}