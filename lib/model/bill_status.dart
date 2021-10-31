class BillStatus {
  String? sId;
  String? billId;
  int? amount;
  int? share;
  bool? active;
  String? userId;

  BillStatus(
      {this.sId,
      this.billId,
      this.amount,
      this.share,
      this.active,
      this.userId});

  BillStatus.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    billId = json['bill_id'];
    amount = json['amount'];
    share = json['share'];
    active = json['active'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bill_id'] = billId;
    data['amount'] = amount;
    data['share'] = share;
    data['active'] = active;
    data['user_id'] = userId;
    return data;
  }
}
