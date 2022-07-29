import 'package:so_ui_flutter/model/credit.dart';

class Status_Model {
  String id;
  String name;

  List<Credit_Model> credit;

  Status_Model(this.id, this.name, this.credit);
  factory Status_Model.fromJson(dynamic json) {
    return Status_Model(
        json['id'] as String,
        json['name'] as String,
        json['credit'] != []
            ? List<Credit_Model>.from(
                json['credit'].map((p) => Credit_Model.fromJson(p)))
            : []);
  }
  Map toJson() => {
        'id': id,
        'name': name,
        'credit': credit,
      };

  @override
  String toString() {
    return '{ id : ${this.id}, name : ${this.name}, credit : ${this.credit} }';
  }
}
