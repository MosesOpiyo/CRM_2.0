import 'package:admin/responsive.dart';
import 'package:admin/screens/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../components/header.dart';

import '../../components/recent_files.dart';
import '../../components/storage_details.dart';

class StockScreen extends StatefulWidget {
  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
// Product Details Controllers
  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _checkedByController = TextEditingController();

  final TextEditingController _warrantyDurationController =
      TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  newStock() {
    int _currentStep = 0;

    List<Step> stepList() => [
          Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: Text('Product Details'),
            content: Column(
              children: [
                TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: _checkedByController,
                  decoration: InputDecoration(labelText: 'Checked By'),
                ),
                TextField(
                  controller: _warrantyDurationController,
                  decoration: InputDecoration(labelText: 'Warranty Duration'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("New Sale"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SizedBox(
              height: height - 100,
              width: width - 800,
              child: Stepper(
                steps: stepList(),
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: () {
                  Navigator.pop(ctx);
                  // Capture the data here
                  // var productName = _productNameController.text;
                  // var checkedBy = _checkedByController.text;
                  // var warrantyDuration = _warrantyDurationController.text;
                  // var price = int.parse(_priceController.text);
                  // var clientName = _clientNameController.text;
                  // var clientEmail = _clientEmailController.text;
                  // var clientLocation = _clientLocationController.text;
                  // var clientPin = _clientPinController.text;

                  // Call your API or handle the captured data
                  // SalesService().postSale(
                  //   productName,
                  //   checkedBy,
                  //   warrantyDuration,
                  //   price,
                  //   clientName,
                  //   clientEmail,
                  //   clientLocation,
                  //   clientPin,
                  // );
                },
                onStepCancel: () {
                  setState(() {
                    _currentStep > 0 ? _currentStep -= 1 : Navigator.pop(ctx);
                  });
                },
                onStepTapped: (int value) {
                  setState(() {
                    _currentStep = value;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              Page: "Stock",
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Overalls(
                        onpressed: newStock,
                        overalls: "Stock Overalls",
                      ),
                      SizedBox(height: defaultPadding),
                      StockList(Option: "Stock"),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) SupplierDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: SupplierDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
