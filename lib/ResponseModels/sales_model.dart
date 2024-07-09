class SaleModel {
  SaleModel({
    required this.id,
    required this.product,
    required this.imei,
    required this.supplier,
    required this.deliveredToClientBy,
    required this.clientName,
    required this.status,
    required this.cash,
    required this.mpesa,
    required this.warrantyStatus,
    required this.invoicedAmount,
  });

  late final int id;
  late final String product;
  late final int imei;
  late final String supplier;
  late final String deliveredToClientBy;
  late final String clientName;
  late final String status;
  late final int cash;
  late final int mpesa;
  late final String warrantyStatus;
  late final int invoicedAmount;

  SaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    imei = json['imei'];
    supplier = json['supplier'];
    deliveredToClientBy = json['delivered_to_client_by'];
    clientName = json['client_name'];
    status = json['status'];
    cash = json['cash'];
    mpesa = json['mpesa'];
    warrantyStatus = json['warranty_status'];
    invoicedAmount = json['invoiced_amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = product;
    _data['imei'] = imei;
    _data['supplier'] = supplier;
    _data['delivered_to_client_by'] = deliveredToClientBy;
    _data['client_name'] = clientName;
    _data['status'] = status;
    _data['cash'] = cash;
    _data['mpesa'] = mpesa;
    _data['warranty_status'] = warrantyStatus;
    _data['invoiced_amount'] = invoicedAmount;
    return _data;
  }
}
