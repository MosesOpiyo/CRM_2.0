class StockModel {
  StockModel({
    required this.id,
    required this.product,
    required this.units,
    required this.imeiNumbers,
    required this.checkedInPersonName,
    required this.warrantyDuration,
    required this.price,
    required this.clients,
  });
  late final int id;
  late final String product;
  late final int units;
  late final List<ImeiNumbers> imeiNumbers;
  late final String checkedInPersonName;
  late final String warrantyDuration;
  late final int price;
  late final List<Clients> clients;

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    units = json['units'];
    imeiNumbers = List.from(json['imei_numbers'])
        .map((e) => ImeiNumbers.fromJson(e))
        .toList();
    checkedInPersonName = json['checked_in_person_name'];
    warrantyDuration = json['warranty_duration'];
    price = json['price'];
    clients =
        List.from(json['clients']).map((e) => Clients.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = product;
    _data['units'] = units;
    _data['checked_in_person_name'] = checkedInPersonName;
    _data['warranty_duration'] = warrantyDuration;
    _data['price'] = price;
    _data['clients'] = clients.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ImeiNumbers {
  ImeiNumbers(
      {required this.imeiNumber, required this.sold, required this.status});
  late final int imeiNumber;
  late final bool sold;
  late final String status;

  ImeiNumbers.fromJson(Map<String, dynamic> json) {
    imeiNumber = json['imei'];
    sold = json['sold'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imei'] = imeiNumber;
    _data['sold'] = sold;
    _data['status'] = status;
    return _data;
  }
}

class Clients {
  Clients({
    required this.clientName,
    required this.clientPhoneNumber,
    required this.clientEmail,
    required this.clientLocation,
    required this.clientPin,
  });
  late final String clientName;
  late final String clientPhoneNumber;
  late final String clientEmail;
  late final String clientLocation;
  late final String clientPin;

  Clients.fromJson(Map<String, dynamic> json) {
    clientName = json['client_name'];
    clientPhoneNumber = json['client_phone_number'];
    clientEmail = json['client_email'];
    clientLocation = json['client_location'];
    clientPin = json['client_pin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['client_name'] = clientName;
    _data['client_phone_number'] = clientPhoneNumber;
    _data['client_email'] = clientEmail;
    _data['client_location'] = clientLocation;
    _data['client_pin'] = clientPin;
    return _data;
  }
}
