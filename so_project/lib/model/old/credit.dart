class Credit_Model {
  String id;
  String name;
  double amount;
  String date;
  DateTime date_time;
  String zone;

  Credit_Model(
      this.id, this.name, this.amount, this.date, this.date_time, this.zone);

  factory Credit_Model.fromJson(dynamic json) {
    return Credit_Model(
      json['id'] as String,
      json['name'] as String,
      json['amount'] as double,
      json['date'] as String,
      json['date_time'] as DateTime,
      json['zone'] as String,
    );
  }
  Map toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'date': date,
        'date_time': date_time,
        'zone': zone,
      };

  @override
  String toString() {
    return '{ id : $id, name : $name, amount : $amount, date : $date, date_time : $date_time, zone : $zone }';
  }
}
