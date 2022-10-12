class PartResponse {
  PartResponse({
      List<Part>? part,}){
    part = part;
}

  PartResponse.fromJson(dynamic json) {
    if (json['part'] != null) {
      part = [];
      json['part'].forEach((v) {
        part?.add(Part.fromJson(v));
      });
    }
  }

  List<Part>? part;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (part != null) {
      map['part'] = part?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Part {
  Part({
      String? id, 
      String? name, 
      String? mId, 
      String? createdBy, 
      String? createdAt, 
      String? updatedBy, 
      String? updatedAt, 
      String? total,}){
    id = id;
    name = name;
    mId = mId;
    createdBy = createdBy;
    createdAt = createdAt;
    updatedBy = updatedBy;
    updatedAt = updatedAt;
    total = total;
}

  Part.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mId = json['m_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    total = json['total'];
  }
  String? id;
  String? name;
  String? mId;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['m_id'] = mId;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_by'] = updatedBy;
    map['updated_at'] = updatedAt;
    map['total'] = total;
    return map;
  }

}