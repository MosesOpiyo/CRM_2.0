class StockModel {
  StockModel(
      {required this.id,
      required this.product,
      required this.supplier,
      required this.imei,
      required this.checkedInPersonName,
      required this.warrantyDuration,
      required this.amount,
      required this.status,
      required this.dueDate});
  late final int id;
  late final String product;
  late final Supplier supplier;
  late final int imei;
  late final String checkedInPersonName;
  late final String warrantyDuration;
  late final int amount;
  late final String status;
  late final String dueDate;

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    supplier = Supplier.fromJson(json['supplier']);
    imei = json['imei'];
    checkedInPersonName = json['checked_in_person_name'];
    warrantyDuration = json['warranty_duration'];
    amount = json['amount'];
    status = json['status'];
    dueDate = json['credit_due_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = product;
    _data['supplier'] = supplier;
    _data['checked_in_person_name'] = checkedInPersonName;
    _data['warranty_duration'] = warrantyDuration;
    _data['amount'] = amount;
    _data['status'] = status;
    _data['credit_due_date'] = dueDate;
    return _data;
  }
}

class Supplier {
  Supplier({required this.name, required this.supplier});
  late final String name;
  late final String supplier;

  Supplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    supplier = json['supplier'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['supplier'] = supplier;
    return _data;
  }
}
