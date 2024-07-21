class VendorModel {
  VendorModel({
    required this.id,
    required this.products,
    required this.name,
    required this.supplier,
  });
  late final int id;
  late final List<Products> products;
  late final String name;
  late final String supplier;

  VendorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
    name = json['name'];
    supplier = json['supplier'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['name'] = name;
    _data['supplier'] = supplier;
    return _data;
  }
}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.imei,
    required this.price,
  });
  late final int id;
  late final String name;
  late final int imei;
  late final int price;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imei = json['imei'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imei'] = imei;
    _data['price'] = price;
    return _data;
  }
}
