class Account_Model {
  String id;
  String name;
  double amount;

  Account_Model(this.id, this.name, this.amount);

  factory Account_Model.fromJson(dynamic json) {
    return Account_Model(
      json['id'] as String,
      json['name'] as String,
      json['amount'] as double,
    );
  }
  Map toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
      };

  @override
  String toString() {
    return '{ id : ${this.id}, name : ${this.name}, amount : ${this.amount} }';
  }
}
