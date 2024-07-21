import 'package:admin/API/SupplierService/service.dart';
import 'package:admin/ResponseModels/vendor_model.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'storage_info_card.dart';

class SupplierDetails extends StatefulWidget {
  const SupplierDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  late List<VendorModel> suppliers = [];

  getSuppliers() {
    SupplierService().getSuppliers().then((value) {
      setState(() {
        suppliers = value
            .map((dynamic supplier) => VendorModel.fromJson(supplier))
            .toList();
      });
    });
  }

  void initState() {
    super.initState();
    getSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Suppliers Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            ListView.builder(
                shrinkWrap: true,
                itemCount: suppliers.length,
                itemBuilder: ((context, index) {
                  return StorageInfoCard(
                    title: suppliers[index].name,
                    numOfDevices: suppliers[index].products.length,
                  );
                })),
          ],
        ),
      ),
    );
  }
}
