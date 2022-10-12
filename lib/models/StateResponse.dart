class StateResponse {
  StateResponse({
      List<States>? state,}){
    state = state;
}

  StateResponse.fromJson(dynamic json) {
    if (json['state'] != null) {
      state = [];
      json['state'].forEach((v) {
        state?.add(States.fromJson(v));
      });
    }
  }
  List<States>? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (state != null) {
      map['state'] = state?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class States {
  States({
      String? id, 
      String? name, 
      String? coId,}){
    id = id;
    name = name;
    coId = coId;
}

  States.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coId = json['co_id'];
  }
  String? id;
  String? name;
  String? coId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['co_id'] = coId;
    return map;
  }

}