class Bill {
  String? sId;
  String? billName;
  int? amount;
  String? date;
  String? dueDate;
  String? category;
  List<BillsUser>? users;
  bool? equalSharing;

  Bill(
      {this.sId,
      this.billName,
      this.amount,
      this.date,
      this.dueDate,
      this.category,
      this.users,
      this.equalSharing});

  Bill.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    billName = json['bill_name'];
    amount = json['amount'];
    date = json['date'];
    dueDate = json['due_date'];
    category = json['category'];
    if (json['users'] != null) {
      users = <BillsUser>[];
      json['users'].forEach((v) {
        users!.add(BillsUser.fromJson(v));
      });
    }
    equalSharing = json['equalSharing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bill_name'] = billName;
    data['amount'] = amount;
    data['date'] = date;
    data['due_date'] = dueDate;
    data['category'] = category;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['equalSharing'] = equalSharing;
    return data;
  }
}

class BillsUser {
  String? sId;
  String? name;
  int? phone;

  BillsUser({this.sId, this.name, this.phone});

  BillsUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
