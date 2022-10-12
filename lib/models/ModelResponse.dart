class ModelResponse {
  ModelResponse({
      List<Model>? model,}){
    model = model;
}

  ModelResponse.fromJson(dynamic json) {
    if (json['model'] != null) {
      model = [];
      json['model'].forEach((v) {
        model?.add(Model.fromJson(v));
      });
    }
  }

  List<Model>? model;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (model != null) {
      map['model'] = model?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Model {
  Model({
      String? id, 
      String? name, 
      String? comId, 
      String? createdBy, 
      String? createdAt, 
      String? updatedBy, 
      String? updatedAt, 
      String? total,}){
    id = id;
    name = name;
    comId = comId;
    createdBy = createdBy;
    createdAt = createdAt;
    updatedBy = updatedBy;
    updatedAt = updatedAt;
    total = total;
}

  Model.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    comId = json['com_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    total = json['total'];
  }
  String? id;
  String? name;
  String? comId;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['com_id'] = comId;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    map['total'] = total;
    return map;
  }

}