class User {
  String? sId;
  String? name;
  int? phone;
  String? upiId;
  List<Friends>? friends;
  List<UserBills>? bills;

  User({this.sId, this.name, this.phone, this.upiId, this.friends, this.bills});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    upiId = json['upi_id'];
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(Friends.fromJson(v));
      });
    }
    if (json['bills'] != null) {
      bills = <UserBills>[];
      json['bills'].forEach((v) {
        bills!.add(UserBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['upi_id'] = upiId;
    if (friends != null) {
      data['friends'] = friends!.map((v) => v.toJson()).toList();
    }
    if (bills != null) {
      data['bills'] = bills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friends {
  String? sId;
  String? name;
  int? phone;
  String? upiId;

  Friends({this.sId, this.name, this.phone, this.upiId});

  Friends.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['upi_id'] = upiId;
    return data;
  }
}

class UserBills {
  String? sId;
  String? billName;
  int? amount;
  String? date;
  String? dueDate;
  String? category;
  bool? equalSharing;

  UserBills(
      {this.sId,
      this.billName,
      this.amount,
      this.date,
      this.dueDate,
      this.category,
      this.equalSharing});

  UserBills.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    billName = json['bill_name'];
    amount = json['amount'];
    date = json['date'];
    dueDate = json['due_date'];
    category = json['category'];
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
    data['equalSharing'] = equalSharing;
    return data;
  }
}
