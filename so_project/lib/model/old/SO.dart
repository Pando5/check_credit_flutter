

import 'package:so_project/model/old/account_model.dart';

class SO_Model {
  String id;
  String name;
  double amount;
  List<Account_Model> account;

  SO_Model(this.id, this.name, this.amount, this.account);
  factory SO_Model.fromJson(dynamic json) {
    return SO_Model(
        json['id'] as String,
        json['name'] as String,
        json['amount'] as double,
        json['account'] != []
            ? List<Account_Model>.from(
                json['account'].map((p) => Account_Model.fromJson(p)))
            : []);
  }
  Map toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'account': account,
      };

  @override
  String toString() {
    return '{ id : ${this.id}, name : ${this.name}, amount : ${this.amount}, account : ${this.account} }';
  }
}
