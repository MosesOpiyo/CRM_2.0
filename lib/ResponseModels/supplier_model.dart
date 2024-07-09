class SupplierModel {
  SupplierModel({
    required this.id,
    required this.stockSupply,
    required this.name,
  });
  late final int id;
  late final List<StockSupply> stockSupply;
  late final String name;

  SupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockSupply = List.from(json['stock_supply'])
        .map((e) => StockSupply.fromJson(e))
        .toList();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['stock_supply'] = stockSupply.map((e) => e.toJson()).toList();
    _data['name'] = name;
    return _data;
  }
}

class StockSupply {
  StockSupply({
    required this.imei,
    required this.sold,
    required this.status,
  });
  late final int imei;
  late final bool sold;
  late final String status;

  StockSupply.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    sold = json['sold'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imei'] = imei;
    _data['sold'] = sold;
    _data['status'] = status;
    return _data;
  }
}
