class LoginResponse {
  LoginResponse({
      String? status, 
      String? message,
      String? s_id,
      String? id,
  });

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    s_id = json['s_id'];
    id = json['id'];
  }
  String? status;
  String? message;
  String? s_id;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['s_id'] = s_id;
    map['id'] = id;
    return map;
  }

}