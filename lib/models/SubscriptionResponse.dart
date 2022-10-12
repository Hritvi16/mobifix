class SubscriptionResponse {
  SubscriptionResponse({
      String? status, 
      String? message, 
      String? id,
      Subscription? subscription,}){
    status = status;
    message = message;
    id = id;
    subscription = subscription;
}

  SubscriptionResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    subscription = json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null;
  }
  String? status;
  String? message;
  String? id;
  Subscription? subscription;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['id'] = id;
    if (subscription != null) {
      map['subscription'] = subscription?.toJson();
    }
    return map;
  }

}


class Subscription {
  Subscription({
      String? id, 
      String? sId, 
      String? pId, 
      String? startDate, 
      String? endDate, 
      String? hardwareId, 
      String? code, 
      String? source, 
      String? payment, 
      String? txnId, 
      String? createdAt, 
      String? paymentStatus, 
      String? paymentDate,}){
    id = id;
    sId = sId;
    pId = pId;
    startDate = startDate;
    endDate = endDate;
    hardwareId = hardwareId;
    code = code;
    source = source;
    payment = payment;
    txnId = txnId;
    createdAt = createdAt;
    paymentStatus = paymentStatus;
    paymentDate = paymentDate;
}

  Subscription.fromJson(dynamic json) {
    id = json['id'];
    sId = json['s_id'];
    pId = json['p_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    hardwareId = json['hardware_id'];
    code = json['code'];
    source = json['source'];
    payment = json['payment'];
    txnId = json['txn_id'];
    createdAt = json['created_at'];
    paymentStatus = json['payment_status'];
    paymentDate = json['payment_date'];
  }
  String? id;
  String? sId;
  String? pId;
  String? startDate;
  String? endDate;
  String? hardwareId;
  String? code;
  String? source;
  String? payment;
  String? txnId;
  String? createdAt;
  String? paymentStatus;
  String? paymentDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['s_id'] = sId;
    map['p_id'] = pId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['hardware_id'] = hardwareId;
    map['code'] = code;
    map['source'] = source;
    map['payment'] = payment;
    map['txn_id'] = txnId;
    map['created_at'] = createdAt;
    map['payment_status'] = paymentStatus;
    map['payment_date'] = paymentDate;
    return map;
  }

}