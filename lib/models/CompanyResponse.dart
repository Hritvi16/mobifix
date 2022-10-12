class CompanyResponse {
  CompanyResponse({
      List<Company>? company,}){
    company = company;
}

  CompanyResponse.fromJson(dynamic json) {
    if (json['company'] != null) {
      company = [];
      json['company'].forEach((v) {
        company?.add(Company.fromJson(v));
      });
    }
  }
  
  List<Company>? company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (company != null) {
      map['company'] = company?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Company {
  Company({
      String? id, 
      String? name, 
      String? type, 
      String? createdBy, 
      String? createdAt, 
      String? updatedBy, 
      String? updatedAt,
      String? total,
  }){
    id = id;
    name = name;
    type = type;
    createdBy = createdBy;
    createdAt = createdAt;
    updatedBy = updatedBy;
    updatedAt = updatedAt;
    total = total;
}

  Company.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    total = json['total'];
  }

  String? id;
  String? name;
  String? type;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    map['total'] = total;
    return map;
  }

}