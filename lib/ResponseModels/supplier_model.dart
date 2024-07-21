class SupplierModel {
  SupplierModel({
    required this.name,
    required this.supplier,
    required this.productsCount,
  });
  late final String name;
  late final String supplier;
  late final int productsCount;

  SupplierModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    supplier = json['supplier'];
    productsCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['supplier'] = supplier;
    _data['products_count'] = productsCount;
    return _data;
  }
}
